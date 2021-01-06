local AcSupplicateModel = class("AcSupplicateModel")
local GlobalConfigConfig = require"Configs/GlobalConfigConfig"
local ActivityConfig = require"Configs/ActivityConfig"
local LottoRewardConfig = require"Configs/LottoRewardConfig"
local ItemConfig = require"Configs/ItemConfig"
local PlayerBehaviorConfig = require"Configs/PlayerBehaviorConfig"
function AcSupplicateModel:ctor()
    self:InitEnum()
    self:InitData()
end

function AcSupplicateModel:InitEnum()
    self.rewardStatus =
    {
        Not = 0,
        Get = 1,
    }
end

function AcSupplicateModel:InitData()
    self.tagId = 0
    self.serverRewardList = {}
    self.deepBehaviorList = nil
    self.strokeBehaviorList = nil
    self.countDown = 0
end

function AcSupplicateModel:ResetData()
    self.serverRewardList = {}
    self.countDown = 0
end

function AcSupplicateModel:SetTagId(tagId)
    self.tagId = tagId
    self:UpdateActivityConfig(tagId)
    self:ParseBehaviorConfig()
end

function AcSupplicateModel:GetTagId()
    return self.tagId
end

function AcSupplicateModel:ParseBehaviorConfig()
    self.deepBehaviorList = {}
    self.strokeBehaviorList = {}
    local effective_time = "1,"..self.tagId
    for k,v in pairs(PlayerBehaviorConfig) do
        if type(k) == "number" then
            local config = PlayerBehaviorConfig.GetConfig(k)
            if config.effective_time == effective_time then
                local channel = string.split(config.channel,",")
                local behavior = {}
                behavior.desc = config.describe
                local scoreReward = string.split(config.reward,";")[1]
                behavior.getScore = string.split(scoreReward,",")[3]
                if channel[1] == "4" then
                    table.insert(self.deepBehaviorList,behavior)
                elseif channel[1] == "8" then
                    table.insert(self.strokeBehaviorList,behavior)
                else
                    print_error("PlayerBehaviorConfig has other behavior, channel: "..channel[1])
                end
            end
        end
    end
end

function AcSupplicateModel:GetDeepBehaviorList()
    return self.deepBehaviorList
end

function AcSupplicateModel:GetStrokeBehaviorList()
    return self.strokeBehaviorList
end

function AcSupplicateModel:InitInfos(serverData)
    self:ResetData()
    self:UpdateRewardList(serverData.activityInfo.info)
    self.countDown = serverData.activityInfo.countDown
end

function AcSupplicateModel:UpdateActivityConfig(tagId)
    self.activityConfig = ActivityConfig.GetConfig(tagId)

    if self.activityConfig == nil then
        print_error("ActivityConfig = nil,tagid = ",tagId)
        return
    end
end

function AcSupplicateModel:UpdateRewardList(rewardList)
    for i,v in ipairs(rewardList) do
        self.serverRewardList[v.id] = v.status
    end
end

function AcSupplicateModel:GetShowRewardList()
    local rewardList = {}
    for i,v in ipairs(LottoRewardConfig) do
        local config = LottoRewardConfig.GetConfig(i)
        if config.isshow == 1 then
            table.insert(rewardList,config)
        end
    end
    return rewardList
end

function AcSupplicateModel:GetRewardStatus(id)
    return self.serverRewardList[id] or 0
end

function AcSupplicateModel:GetScoreName()
    local itemId = self:GetScoreItemId()
    local config = ItemConfig.GetConfig(itemId)
    if config == nil then
        return ""
    end
    return config.name
end

function AcSupplicateModel:GetCurScore()
    local itemId = self:GetScoreItemId()
    local itemModel = GameEntry.PlayerData.Items:GetItemById(itemId)
    local num = 0
    if itemModel ~= nil then
        num = itemModel.num
    end
    return num
end

function AcSupplicateModel:GetScoreItemId()
    return tonumber(self.activityConfig.parameter_3)
end

function AcSupplicateModel:GetCostScore()
    local config = GlobalConfigConfig.GetConfig("activity_integral")
    return tonumber(config.value)
end

function AcSupplicateModel:GetResourceId()
    local config = GlobalConfigConfig.GetConfig("activity_resouce")
    return tonumber(config.value)
end

function AcSupplicateModel:CanSupplicate()
    local curScore = self:GetCurScore()
    local costScore = self:GetCostScore()
    if curScore >= costScore then
        return true
    end
    return false
end

function AcSupplicateModel:HaveRedPoint()
    if self.activityConfig == nil then
        return false
    end
    return self:CanSupplicate()
end

return AcSupplicateModel