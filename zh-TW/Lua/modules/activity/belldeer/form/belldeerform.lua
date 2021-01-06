local BaseForm = BaseForm
local BellDeerForm = class("BellDeerForm", BaseForm)
local CardGridView = require "Modules/Activity/BellDeer/Form/CardGridView"
local TaskView = require "Modules/Activity/BellDeer/Form/TaskView"
local RewardView = require "Modules/Activity/BellDeer/Form/RewardView"
local MainUIView = require "Modules/Activity/BellDeer/Form/MainUIView"

function BellDeerForm:LUA_OnInit(gameObject, userParamData)
    self.injections = ParseInjections(gameObject)
    self.uguiForm = gameObject:GetComponent(typeof(CS.DarkBoom.LuaUGUIForm))
    self:InjectComponent()
    self:Init()
end

function BellDeerForm:InjectComponent()
    self.CardGridView = self.injections.CardGridView
    self.TaskView = self.injections.TaskView
    self.RewardView = self.injections.RewardView
    self.MainUIView = self.injections.MainUIView
end

function BellDeerForm:Init()
    self.manager = Game:GetManager("BellDeerManager")
    self.model = self.manager:GetModel()
    self.event = self.manager:GetEvent()
    self.model.resMask = self.uguiForm:GetMask()
    self.cardGridView = CardGridView.new(self.CardGridView.gameObject)
    self.mainUIView = MainUIView.new(self.MainUIView.gameObject)
    self.mainUIView:RefreshUI()
    if self.model:HasReceivedFinalReward() then
        self.TaskView.gameObject:SetActive(false)
        self.RewardView.gameObject:SetActive(false)
    else
        self.taskView = TaskView.new(self.TaskView.gameObject)
        self.rewardView = RewardView.new(self.RewardView.gameObject)
        self.taskView:SetActive(true)
        self.rewardView:SetActive(true)
    end
    self:AddListeners()
end

function BellDeerForm:AddListeners()
    self.event.BellDeerGetFinalRewardEvent:AddListener(self.OnGetFinalReward, self)
end

function BellDeerForm:RemoveListeners()
    self.event.BellDeerGetFinalRewardEvent:RemoveListener(self.OnGetFinalReward, self)
end

function BellDeerForm:OnGetFinalReward(userData)
    self.model:PlayStory(
        "merrychristmas_story_end",
        function()
            self.taskView:SetActive(false)
            self.rewardView:SetActive(false)
            self.mainUIView:RefreshUI()
            if userData ~= nil then
                DarkBoomUtility.ShowRewardUIForm(userData)
            end
            self.cardGridView:ClearReward()
        end
    )
end

function BellDeerForm:LUA_OnOpen(userData)
    -- self.cardGridView:UpdateData()
end

function BellDeerForm:LUA_OnUpdate(elapseSeconds, realElapseSeconds)
    if self.cardGridView ~= nil then
        self.cardGridView:LUA_OnUpdate(elapseSeconds, realElapseSeconds)
    end
    if self.taskView ~= nil then
        self.taskView:LUA_OnUpdate(elapseSeconds, realElapseSeconds)
    end
    if self.mainUIView ~= nil then
        self.mainUIView:LUA_OnUpdate(elapseSeconds, realElapseSeconds)
    end
end

function BellDeerForm:LUA_OnClose()
    self:RemoveListeners()
    if self.cardGridView ~= nil then
        self.cardGridView:OnRelease()
    end
    if self.taskView ~= nil then
        self.taskView:OnRelease()
    end
    if self.rewardView ~= nil then
        self.rewardView:OnRelease()
    end
    self.mainUIView:OnRelease()
    self.cardGridView = nil
    self.taskView = nil
    self.rewardView = nil
    self.mainUIView = nil

    self.injections = {}
    self.injections = nil
    self.uguiForm = nil
end

return BellDeerForm
