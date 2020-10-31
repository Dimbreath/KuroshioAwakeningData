local MonopolyTaskView      = class("MonopolyTaskView")
local ItemConfig            = require "Configs/ItemConfig"
local TaskItem              = require"Modules/Activity/Monopoly/Form/Task/MonopolyTaskItem"

function MonopolyTaskView:ctor(gameObject)
   if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
    self:InjectComponent()
    self:Init()
end

function MonopolyTaskView:InjectComponent()
    self.TaskConrainer  = self.injections.TaskConrainer
    self.TaskItem        = self.injections.TaskItem
end

function MonopolyTaskView:Init()
    local manager = Game:GetManager("MonopolyManager")
    self.model    = manager:GetModel()
    self.event    = manager:GetEvent()

    self:AddBtnListener()
    self.taskItems = {}
end

function MonopolyTaskView:AddBtnListener()
    self.event.MonopolyTaskEvent:AddListener(self.OnMonopolyTaskEvent,self)
end

function MonopolyTaskView:UpdateData( ... )
    self:UpdateTask()
end

function MonopolyTaskView:OnMonopolyTaskEvent()
    for index, value in ipairs(self.model.taskList) do
        local grid = self.taskItems[index]
        grid:SetData(value)
    end
end

function MonopolyTaskView:UpdateTask()
    for index, value in ipairs(self.model.taskList) do
        if value == nil then
            print_error("task value = nil,index = ",index)
        end

        local go = GameObject.Instantiate(self.TaskItem.gameObject,self.TaskConrainer.transform)
        go:SetActive(true)
        go.transform.localScale = Vector3.one
        local grid = TaskItem.new(go)
        grid:SetData(value)
        self.taskItems[index] = grid
    end
end

function MonopolyTaskView:OnRelease()
    self.event.MonopolyTaskEvent:RemoveListener(self.OnMonopolyTaskEvent,self)

    for k,v in pairs(self.taskItems) do
        v:OnRelease()
    end

    self.taskItems = {}
end

return MonopolyTaskView
