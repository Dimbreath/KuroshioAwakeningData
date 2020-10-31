local AcSupplicateModel = class("AcSupplicateModel")
local TaskConfig = require"Configs/TaskConfig"
local GlobalConfigConfig = require"Configs/GlobalConfigConfig"
local LottoTaskConfig = require"Configs/LottoTaskConfig"
local ActivityConfig = require"Configs/ActivityConfig"
local LottoRewardConfig = require"Configs/LottoRewardConfig"
local ItemConfig = require"Configs/ItemConfig"
function AcSupplicateModel:ctor()
    self:InitEnum()
    self:InitData()
end

function AcSupplicateModel:InitEnum()
    self.taskStatus =
    {
        Not = 0,
        Can = 1,
        Complete = 2,
    }
    self.rewardStatus =
    {
        Not = 0,
        Get = 1,
    }
end

function AcSupplicateModel:InitData()
    self.tagId = 0
    self.serverTaskList = {}
    self.serverRewardList = {}
    self.countDown = 0
end

function AcSupplicateModel:ResetData()
    self.serverTaskList = {}
    self.serverRewardList = {}
    self.countDown = 0
end

function AcSupplicateModel:SetTagId(tagId)
    self.tagId = tagId
    self:UpdateActivityConfig(tagId)
end

function AcSupplicateModel:GetTagId()
    return self.tagId
end

function AcSupplicateModel:InitInfos(serverData)
    self:ResetData()
    -- 初始化任务数据
    self:UpdateTaskList(serverData.taskList)
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

function AcSupplicateModel:UpdateTaskData(task)
    if self.serverTaskList[task.group] == nil then
        self.serverTaskList[task.group] = {}
    end
    self.serverTaskList[task.group].task_id = task.task_id
    self.serverTaskList[task.group].group = task.group
    self.serverTaskList[task.group].progress = task.progress
    self.serverTaskList[task.group].status = task.status
end

function AcSupplicateModel:UpdateTaskList(taskList)
    for i,v in ipairs(taskList) do
        self:UpdateTaskData(v)
    end
end

function AcSupplicateModel:UpdateRewardList(rewardList)
    for i,v in ipairs(rewardList) do
        self.serverRewardList[v.id] = v.status
    end
end

function AcSupplicateModel:GetTaskConfig(task_id)
    return TaskConfig.GetConfig(tonumber(task_id))
end

function AcSupplicateModel:GetTaskScore(group,task_id)
    for i,v in ipairs(LottoTaskConfig) do
        local config = LottoTaskConfig.GetConfig(i)
        if config.groupid == group and config.taskid == task_id then
            return config.integral
        end
    end
    print_error("can`t find groupid:"..group.." taskid:"..task_id.." in config LottoTaskConfig")
    return 0
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
    local itemId = tonumber(self.activityConfig.parameter_3)
    local config = ItemConfig.GetConfig(itemId)
    if config == nil then
        return ""
    end
    return config.name
end

function AcSupplicateModel:GetCurScore()
    local itemId = tonumber(self.activityConfig.parameter_3)
    local itemModel = GameEntry.PlayerData.Items:GetItemById(itemId)
    local num = 0
    if itemModel ~= nil then
        num = itemModel.num
    end
    return num
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
    for k,v in pairs(self.serverTaskList) do
        if v.status == self.taskStatus.Can then
            return true
        end
    end

    return self:CanSupplicate()
end

return AcSupplicateModel