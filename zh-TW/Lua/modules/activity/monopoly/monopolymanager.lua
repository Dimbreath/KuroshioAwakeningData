--小例子
-- local MonopolyManager   = class("MonopolyManager",BaseManager)
-- local MonopolyModel     = require("Modules/Activity/Monopoly/MonopolyModel")
-- local MonopolyEvent     = require("Modules/Activity/Monopoly/MonopolyEvent")

-- function MonopolyManager:AddListeners()

-- end

-- function MonopolyManager:RemoveListeners()

-- end

-- function MonopolyManager:Logout()
--     self:RemoveListeners()
--     self.model = nil
--     self.event = nil
-- end

-- function MonopolyManager:Login()
--     self:AddListeners()
--     self.model = MonopolyModel.new()
--     self.event = 
--     {

--     }
    --self.event = MonopolyEvent.new()

    --数据量少、事件少可用下面这种方式：
    -- self.model = 
    -- {
    --     test1 = 0,
    --     test2 = 1,
    --     test3 = "",
    -- }

    -- self.event = 
    -- {
    --     testEvent1 = Event.new(),
    --     testEvent2 = Event.new(),
    --     testEvent3 = Event.new(),
    -- }
-- end
--------例子结束----------------------------------------

local MonopolyManager   = class("MonopolyManager",BaseManager)
local MonopolyModel     = require("Modules/Activity/Monopoly/MonopolyModel")

--获取Infos
local GETMILLIONAIREACTIVITY = "/activity/getMillionaireActivity"
--掷骰子
local RUNMILLIONAIREACTIVITY = "/activity/runMillionaireActivity"
--下一关或者重置
local MILLIONAIRENEXTFLOOR   = "/activity/millionaireNextFloor"
--领取任务奖励
local FINISHACTIVITYTASK     = "/activity/finishActivityTask"

function MonopolyManager:Logout()
    self.model = nil
    self.event = nil
end

function MonopolyManager:GetModel()
    return self.model
end

function MonopolyManager:GetEvent()
    return self.event
end

function MonopolyManager:Login()
    print("MonopolyManager:Login")
    self.model = MonopolyModel.new()

    self.event = 
    {
        MonopolyInfoEvent  = Event.new(),
        MonopolyDiceEvent  = Event.new(),
        MonopolyResetEvent = Event.new(),
        MonopolyTaskEvent  = Event.new(),
        SelectPointEvent   = Event.new(),
        NextStageEvent     = Event.new(),
        SpecifyStepClickEvent = Event.new(),
        StartMoveEvent    = Event.new()
    }
end

function MonopolyManager:GetMonopolyInfo()
    WebRequest.SendRequest(GETMILLIONAIREACTIVITY,nil,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        self.model:InitInfos(data)
        self.event.MonopolyInfoEvent:Invoke()
    end)
end 

function MonopolyManager:Dice(use_item,item_id,point,dice_type)
    if self.model.walkState ~= self.model.walkType.Idle then return end

    item_id = item_id or 0
    point   = point or 0
    dice_type = dice_type or 0
    local form = CS.UnityEngine.WWWForm()
    form:AddField("use_item", use_item)
    form:AddField("item_id", item_id)
    form:AddField("point",point)
    form:AddField("dice_type",dice_type)
    
    WebRequest.SendRequest(RUNMILLIONAIREACTIVITY,form,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        local stepList = self.model:ParseDiceData(data)
        local diceType = data.dice_type
        self.event.MonopolyDiceEvent:Invoke(stepList,diceType)
    end)
end

--1前往下一层 2刷新棋盘
function MonopolyManager:NextStage(type)
    local form = CS.UnityEngine.WWWForm()
    form:AddField("type", type)

    WebRequest.SendRequest(MILLIONAIRENEXTFLOOR,form,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        self.model:UpdateFloorAndStep(data.position.floor,data.position.step)
        local type = data.type
        self.event.MonopolyResetEvent:Invoke(type)
    end)
end

--领取任务奖励
function MonopolyManager:GetTaskReward(taskId)
    local form = CS.UnityEngine.WWWForm()
    form:AddField("id", taskId)
    
    WebRequest.SendRequest(FINISHACTIVITYTASK,form,function(serverdata)
        local data   = JsonDecode(serverdata.rawData)
        local tempId = data.task_tmp_id
        if TableLength(data.list) <= 0 then
                self.model:UpdateTaskState(tempId)
        else
            for _,v in ipairs(data.list) do
                self.model:RemoveLastTask(tempId)
                self.model:UpdateTaskData(v)
            end
        end

        self.model:GetTaskReward(tempId)
        self.event.MonopolyTaskEvent:Invoke()
    end)
end

function MonopolyManager:HaveRedPoint()
    if self.model == nil then 
        return false
    end
    
    local itemNum = self.model:GetBaseDiceNum()
    return itemNum > 0
end

return MonopolyManager

