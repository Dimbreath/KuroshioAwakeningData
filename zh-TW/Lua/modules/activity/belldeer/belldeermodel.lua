local BellDeerModel = class("BellDeerModel")
local ActivityConfig = require "Configs/ActivityConfig"
local GlobalConfig = require "Configs/GlobalConfigConfig"
local DefaultConfig = require "Configs/DefaultConfig"
local CommodityConfig = require "Configs/CommodityConfig"
local ItemConfig = require "Configs/ItemConfig"
local PointConfig = require "Configs/ChristmasPointConfig"
local RewardConfig = require "Configs/ChristmasrewardConfig"
local PlayerBehaviorConfig = require "Configs/PlayerBehaviorConfig"
local math = math

function BellDeerModel:ctor()
    self:InitEnum()
    self:InitData()
end

function BellDeerModel:InitEnum()
    self.cardStatus = {Opened = 1, Covered = 2, Extra = 3}

    self.cardRewardStatus = {UnReceived = 1, Received = 2}
end

function BellDeerModel:InitData()
    self.resMask = 0
    self.cardList = {}
    self.rewardList = {} -- 已获得奖励的格子下标
    self.stepRewardList = {} -- 已获得阶段任务奖励
    self.skinUnlocked = false
    self.inited = false
    self.timestamp = 0
end

function BellDeerModel:ResetData()
    self.cardList = {}
    self.rewardList = {}
    self.stepRewardList = {}
    self.taskList = {}
    self.inited = false
    self.timestamp = 0
end

function BellDeerModel:InitInfo(data)
    self:ResetData()
    local map = data.map
    local mapType = map.mapType
    for i, v in pairs(map.mapInfo) do
        self.cardList[tonumber(i)] = v
        local configId = MakeJointKey(mapType, i)
        local rewardConfig = self:GetChristmasPointConfig(configId)
        v.reward = rewardConfig.reward
        v.received = false
    end
    -- print_log("opened", #map.rewards.grid)
    for i, v in pairs(map.rewards.grid) do
        -- print_log(v)
        if (self.cardList[v] ~= nil) then
            self.cardList[v].received = true
        end
    end
    self.skinUnlocked = map.status == 1
    self.stepRewardList = map.rewards.plot
    self.todayCoin = data.todayCoin
    self.taskList = data.taskList
    self.timestamp = data.timestamp
    self.inited = true
end

function BellDeerModel:UpdateGridData(data)
    local map = data.map
    if #self.cardList == 0 then
        print_error("self.cardList is empty")
    end
    for i, v in pairs(map.mapInfo) do
        self.cardList[tonumber(i)].status = v.status
    end
    for i, v in pairs(map.rewards.grid) do
        if (self.cardList[v] ~= nil) then
            self.cardList[v].earned = true
        end
    end
end

function BellDeerModel:UpdateStepRewardData(data)
    self.stepRewardList = data.rewards.plot
end

function BellDeerModel:UpdateFinalRewardStatus()
    self.skinUnlocked = true
end

function BellDeerModel:HasRewardReceived(plotId, id)
    local received = false
    local key = tostring(plotId) .. id
    -- print_log("reward", key, #self.stepRewardList)
    for i, v in pairs(self.stepRewardList) do
        -- print_log("received", v)
        if (tostring(v) == key) then
            received = true
        end
    end
    return received
end

function BellDeerModel:IsActivityInTime()
    local timestamp = self.timestamp
    if timestamp == 0 then
        timestamp = DarkBoomUtility.GetServerCrtTime()
    end
    local start = CS.DarkBoom.ActivitiesMgr.GetInstance():GetActivityConfigData(self.tagId).start
    local endT = CS.DarkBoom.ActivitiesMgr.GetInstance():GetActivityConfigData(self.tagId)["end"]

    if start <= timestamp and endT >= timestamp then
        return true
    end
    return false
end

function BellDeerModel:ShouldBeGold(cardId)
    if self:HasReceivedFinalReward() then
        return true
    end
    local plotId = 1
    local id = cardId % 4
    if self:HasRewardReceived(plotId, id) then
        return true
    end
    plotId = 2
    id = math.ceil(cardId / 4)
    if self:HasRewardReceived(plotId, id) then
        return true
    end
end

function BellDeerModel:HasCompleted(plotId, id)
    local completed = true
    for i = 0, 3 do
        if (plotId == 1) then
            if self.cardList[id + i * 4].status ~= self.cardStatus.Opened then
                completed = false
                break
            end
        else
            if self.cardList[4 * (id - 1) + i + 1].status ~= self.cardStatus.Opened then
                completed = false
                break
            end
        end
    end
    return completed
end

function BellDeerModel:HasAllCompleted()
    local completed = true
    if self.cardList == nil then
        print_error("cardList is nil")
    end
    for i, v in pairs(self.cardList) do
        if v.status ~= self.cardStatus.Opened then
            completed = false
            break
        end
    end
    return completed
end

function BellDeerModel:HasAllReceived()
    local received = #self.stepRewardList
    return received == 8
end

function BellDeerModel:HasReceivedFinalReward()
    return self.skinUnlocked
end

function BellDeerModel:GetActivityDuration()
    local config = self:GetActivityConfig()
    local start = config.start
    local endT = config["end"]
    return start, endT
end

function BellDeerModel:GetItemConfig(id)
    return ItemConfig.GetConfig(id)
end

function BellDeerModel:GetActivityConfig()
    return ActivityConfig.GetConfig(self.tagId)
end

function BellDeerModel:GetTaskList()
    if self.taskList == nil then
        print_log("taskList is nil")
    end
    return self.taskList
end

function BellDeerModel:GetTodayCoin()
    if self.todayCoin == nil then
        print_error("todayCoin is nil")
    end
    return self.todayCoin
end

function BellDeerModel:GetDescription()
    local config = DefaultConfig.GetConfig("activity_merrychristmas_10")
    return config.value
end

function BellDeerModel:GetTextFromDefaut(key)
    local config = DefaultConfig.GetConfig(key)
    return config.value
end

function BellDeerModel:GetTimesLeft()
    local config = self:GetActivityConfig()
    local itemId = string.split(config.parameter_3, ",")[1]
    local itemModel = GameEntry.PlayerData.Items:GetItemById(tonumber(itemId))
    if itemModel == nil then
        --print_log("未找到Item", tonumber(itemId))
        return 0
    end
    local times = itemModel.num // self:GetRatio()
    return times
end

function BellDeerModel:GetItemQuality(id)
    local config = self:GetItemConfig(id)
    return config.quality
end

function BellDeerModel:HasAction()
    if not self.inited then
        return false
    end
    if self:HasReceivedFinalReward() then
        return false
    end
    if self:GetTimesLeft() > 0 then
        return true
    end
    if self:HasAllReceived() then
        return true
    end
    for i = 1, 2 do
        for j = 1, 4 do
            if self:HasCompleted(i, j) and not self:HasRewardReceived(i, j) then
                return true
            end
        end
    end
    return false
end

function BellDeerModel:GetCommodityConfig(id)
    return CommodityConfig.GetConfig(tonumber(id))
end

function BellDeerModel:GetCommodityId()
    local str = string.split(self:GetActivityConfig().show_para, ";")[2]
    return string.split(str, ",")
end

function BellDeerModel:GetChristmasPointConfig(id)
    return PointConfig.GetConfig(id)
end

function BellDeerModel:GetPlayerBehavior()
    local list = {}
    for i, v in pairs(PlayerBehaviorConfig.Values) do
        if v[2] == 2 then
            table.insert(list, v)
        end
    end
    return list
end

function BellDeerModel:GetTaskRewardDailyLimit()
    local limit = ""
    for i, v in pairs(PlayerBehaviorConfig.Values) do
        if v[2] == 2 then
            limit = string.split(v[7], ",")[2]
            break
        end
    end
    return tonumber(limit)
end

function BellDeerModel:GetRatio()
    local config = self:GetActivityConfig()
    local ratio = string.split(config.parameter_3, ",")[2]
    return tonumber(ratio)
end

function BellDeerModel:GetFinalReward()
    local config = self:GetActivityConfig()
    return config.parameter_1
end

function BellDeerModel:GetSpineAssetPath()
    local config = self:GetActivityConfig()
    local paths = string.split(string.split(config.show_para, ";")[1], ",")
    local path = ""
    if self:HasReceivedFinalReward() then
        path = paths[2]
    else
        path = paths[1]
    end
    return string.format("Assets/GameMain/Spine/NewBattleSpine/CharSpine/%s/%s_SkeletonData.asset", path, path)
end

function BellDeerModel:GetStoryId(key)
    local storyConfig = GlobalConfig.GetConfig(key)
    if storyConfig == nil then
        return
    end
    return tonumber(storyConfig.value)
end

function BellDeerModel:PlayStory(storyKey, playEndCallBack)
    local value = GameEntry.Setting:GetInt(storyKey, 0)
    local id = self:GetStoryId(storyKey)
    local function playEnd()
        GameEntry.Setting:SetInt(storyKey, 1)
        if playEndCallBack then
            playEndCallBack()
        end
    end
    if value == 0 then
        LuaBridge.PlayStory({id}, playEnd)
    else
        if playEndCallBack then
            playEndCallBack()
        end
    end
end

function BellDeerModel:GetDollText()
    local prefix = "activity_merrychristmas_0"
    local index = 0
    if self.skinUnlocked then
        index = math.random(5, 8)
    else
        index = math.random(1, 4)
    end
    local text = DefaultConfig.GetConfig(prefix .. index).value
    return text
end

function BellDeerModel:GetFinalRewardTipsText()
    local config = DefaultConfig.GetConfig("activity_merrychristmas_11")
    return config.value
end
return BellDeerModel
