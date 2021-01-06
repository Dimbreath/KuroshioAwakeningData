local TaskView = class("TaskView")
local TaskItem = require "Modules/Activity/BellDeer/Form/TaskItem"

function TaskView:ctor(gameObject)
    self.gameObject = gameObject
    self.manager = Game:GetManager("BellDeerManager")
    self.model = self.manager:GetModel()
    self.event = self.manager:GetEvent()
    self.injections = ParseInjections(gameObject)
    self:InjectComponent()
    self:Init()
end

function TaskView:InjectComponent()
    self.ShopBtn = self.injections.ShopBtn
    self.PTBtn = self.injections.PTBtn
    self.CloseBtn = self.injections.CloseBtn
    self.PTDetailsPanel = self.injections.PTDetailsPanel
    self.TaskItemTemplate = self.injections.TaskItemTemplate
    self.LeftFlipNumTxt = self.injections.LeftFlipNumTxt
    self.TodayCoinTxt = self.injections.TodayCoinTxt
    self.PanelAnim = self.injections.PanelAnim
    self.RatioTxt = self.injections.RatioTxt
end

function TaskView:LUA_OnUpdate(elapseSeconds, realElapseSeconds)
    if self.timers ~= nil and #self.timers ~= 0 then
        for i = #self.timers, 1, -1 do
            self.timers[i].time = self.timers[i].time - elapseSeconds
            if self.timers[i].time <= 0 then
                self.timers[i].func(self)
                table.remove(self.timers, i)
            end
        end
    end
end

function TaskView:AddListeners()
    self.event.BellDeerUpdateGridEvent:AddListener(self.OnUpdateCardGridView, self)
    ItemChangeEvent:AddListener(self.OnItemChangeEvent, self)
end

function TaskView:RemoveListeners()
    self.event.BellDeerUpdateGridEvent:RemoveListener(self.OnUpdateCardGridView, self)
    ItemChangeEvent:RemoveListener(self.OnItemChangeEvent, self)
end

function TaskView:OnUpdateCardGridView()
    self.LeftFlipNumTxt.text = tostring(self.model:GetTimesLeft())
end

function TaskView:Init()
    self.PTDetailsPanel.gameObject:SetActive(false)
    self.LeftFlipNumTxt.text = tostring(self.model:GetTimesLeft())
    self.TodayCoinTxt.text =
        string.format(
        "<color=#00FFFF>%s</color><color=#FFFFFF>/%s</color>",
        tostring(self.model:GetTodayCoin()),
        self.model:GetTaskRewardDailyLimit()
    )
    self.RatioTxt.text = "x" .. tostring(self.model:GetRatio()) .. " = "
    self.ShopBtn.onClick:AddListener(
        function()
            self:OnShopBtnClick()
        end
    )
    self.PTBtn.onClick:AddListener(
        function()
            self:OnPTBtnClick()
        end
    )
    self.CloseBtn.onClick:AddListener(
        function()
            self:OnCloseBtnClick()
        end
    )
    self:AddListeners()
    self:InitTaskList()
    self.timers = {}
end

function TaskView:InitTaskList()
    self.taskList = {}
    for i, v in pairs(self.model:GetPlayerBehavior()) do
        local go = GameObject.Instantiate(self.TaskItemTemplate.gameObject, self.TaskItemTemplate.transform.parent)
        go.gameObject:SetActive(true)
        local numstr = string.split(v[4], ",")
        local num = numstr[#numstr]
        local name = ""
        if v[5] == "" then
            name = "No text"
        else
            local str = string.split(v[5], "{0}")
            name = str[1] .. num .. str[2]
        end

        local reward = string.split(v[6], ",")[3]
        local taskItem = TaskItem.new(go, v[1], name, reward)
        table.insert(self.taskList, taskItem)
    end
end

function TaskView:OnShopBtnClick()
    local str = self.model:GetCommodityId()
    --print_log(str[1], str[2])
    LuaBridge.OnQuickBuyCommodity4Lua(tonumber(str[1]), tonumber(str[2]))
end

function TaskView:OnItemChangeEvent()
    --print_log("changed")
    self.LeftFlipNumTxt.text = tostring(self.model:GetTimesLeft())
end

function TaskView:OnPTBtnClick()
    self.PTDetailsPanel.gameObject:SetActive(true)
    self.PTBtn.gameObject:SetActive(false)
    self:PlayAnim()
end

function TaskView:PlayAnim()
    for key, value in pairs(self.PanelAnim) do
        value.time = 0
        value.speed = 1
    end
    for i, v in pairs(self.taskList) do
        v:PlayAnim(false)
    end
    self.PanelAnim:Play("Activity_christmas_panel_01")
end

function TaskView:PlayAnimReversed()
    for key, value in pairs(self.PanelAnim) do
        value.time = self.PanelAnim.clip.length
        value.speed = -1
    end
    for i, v in pairs(self.taskList) do
        v:PlayAnim(true)
    end
    self.PanelAnim:Play("Activity_christmas_panel_01")
end

function TaskView:OnCloseBtnClick()
    self.PTBtn.gameObject:SetActive(true)
    self:PlayAnimReversed()
    table.insert(self.timers, {["time"] = 0.3, ["func"] = self.HidePabel})
end

function TaskView:HidePabel()
    self.PTDetailsPanel.gameObject:SetActive(false)
end

function TaskView:GetGameObject()
    return self.gameObject
end

function TaskView:SetActive(active)
    self.gameObject:SetActive(active)
end

function TaskView:OnRelease()
    self:RemoveListeners()
    self.ShopBtn.onClick:RemoveAllListeners()
    self.PTBtn.onClick:RemoveAllListeners()
    self.CloseBtn.onClick:RemoveAllListeners()
    self.ShopBtn.onClick:Invoke()
    self.PTBtn.onClick:Invoke()
    self.CloseBtn.onClick:Invoke()
    for i, v in pairs(self.taskList) do
        v:OnRelease()
    end
    self.taskList = nil
    self.timers = nil
end

return TaskView
