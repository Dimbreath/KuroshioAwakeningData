local BaseForm = BaseForm
local AcNewYearScoreRankForm  	= class("AcNewYearScoreRankForm", BaseForm)
local AcNewYearScoreRankTagItem = require"Modules/Activity/NewYear/ScoreRank/AcNewYearScoreRankTagItem"
local AcNewYearScoreRankPanel = require"Modules/Activity/NewYear/ScoreRank/AcNewYearScoreRankPanel"
local AcNewYearScoreAwardPanel = require"Modules/Activity/NewYear/ScoreRank/AcNewYearScoreAwardPanel"


function AcNewYearScoreRankForm:LUA_OnInit(gameObject,userParamData)
	self.injections = ParseInjections(gameObject)
    self.uguiForm   = gameObject:GetComponent(typeof(CS.DarkBoom.LuaUGUIForm))
	self:InjectComponent()
	self:Init()
end

function AcNewYearScoreRankForm:InjectComponent()
    self.RankPanel = self.injections.RankPanel
    self.DailyAwardPanel = self.injections.DailyAwardPanel
    self.FinalAwardPanel = self.injections.FinalAwardPanel

    self.RankTagItem = self.injections.RankTagItem
    self.DailyAwardTagItem = self.injections.DailyAwardTagItem
    self.FinalAwardTagItem = self.injections.FinalAwardTagItem
end

function AcNewYearScoreRankForm:Init()
	self.manager = Game:GetManager("AcNewYearManager")  
    self.model = self.manager:GetModel()
	self.event = self.manager:GetEvent()
    self.model.rankFormMask = self.uguiForm:GetMask()

    self.rankTagItem = AcNewYearScoreRankTagItem.new(self.RankTagItem)
    self.rankTagItem:Init(function()
        self:OnRankBtnClick()
    end)
    self.dailyAwardTagItem = AcNewYearScoreRankTagItem.new(self.DailyAwardTagItem)
    self.dailyAwardTagItem:Init(function()
        self:OnDailyAwardsBtnClick()
    end)
    self.finalAwardTagItem = AcNewYearScoreRankTagItem.new(self.FinalAwardTagItem)
    self.finalAwardTagItem:Init(function()
        self:OnFinallyAwardsBtnClick()
    end)   
    self.tagItemTable = {self.rankTagItem,self.dailyAwardTagItem,self.finalAwardTagItem}

    self.rankPanel = AcNewYearScoreRankPanel.new(self.RankPanel)    
    self.dailyAwardPanel = AcNewYearScoreAwardPanel.new(self.DailyAwardPanel)
    self.dailyAwardPanel:InitAwardData(self.model.awardType.Daily)  
    self.finalAwardPanel = AcNewYearScoreAwardPanel.new(self.FinalAwardPanel)
    self.finalAwardPanel:InitAwardData(self.model.awardType.Final)  
    self:AddListeners()
end

function AcNewYearScoreRankForm:AddListeners()
   
end

function AcNewYearScoreRankForm:RefreshTagUI(index)
    for i,v in ipairs(self.tagItemTable) do
        if i == index then
           v:UpdateSelectEffect(true)
        else 
           v:UpdateSelectEffect(false)
        end
    end
end

function AcNewYearScoreRankForm:OnRankBtnClick()
    --显示积分排行
    if self.curTagItem == self.rankTagItem then
       return
    end
    self.curTagItem = self.rankTagItem
    self:RefreshTagUI(1)
    self.RankPanel.gameObject:SetActive(true)
    self.DailyAwardPanel.gameObject:SetActive(false)
    self.FinalAwardPanel.gameObject:SetActive(false)       
    self.manager:ReqGetRankInfo()
end

function AcNewYearScoreRankForm:OnDailyAwardsBtnClick()
    --显示每日奖励
    if self.curTagItem == self.dailyAwardTagItem then
       return
    end
    self.curTagItem = self.dailyAwardTagItem
    self:RefreshTagUI(2)
    self.DailyAwardPanel.gameObject:SetActive(true)
    self.FinalAwardPanel.gameObject:SetActive(false)
    self.RankPanel.gameObject:SetActive(false)
    self.dailyAwardPanel:ShowAwardUI()
end

function AcNewYearScoreRankForm:OnFinallyAwardsBtnClick()
    if self.curTagItem == self.finalAwardTagItem then
       return
    end
    self.curTagItem = self.finalAwardTagItem
    self:RefreshTagUI(3)
    self.FinalAwardPanel.gameObject:SetActive(true)
    self.DailyAwardPanel.gameObject:SetActive(false)   
    self.RankPanel.gameObject:SetActive(false)
    self.finalAwardPanel:ShowAwardUI()
end

function AcNewYearScoreRankForm:LUA_OnOpen(userData)
    self:OnRankBtnClick()
end

function AcNewYearScoreRankForm:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
   self.dailyAwardPanel:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
   self.finalAwardPanel:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
end

function AcNewYearScoreRankForm:LUA_OnClose()
    self.rankPanel:OnRelease()
    self.rankPanel = nil
    self.dailyAwardPanel:OnRelease()
    self.dailyAwardPanel = nil
    self.finalAwardPanel:OnRelease()
    self.finalAwardPanel = nil

    self.rankTagItem:OnRelease()
    self.rankTagItem= nil
    self.dailyAwardTagItem:OnRelease()
    self.dailyAwardTagItem = nil
    self.finalAwardTagItem:OnRelease()
    self.finalAwardTagItem = nil

    self.tagItemTable = {}
    self.tagItemTable = nil

    self.manager = nil  
    self.model = nil
    self.event = nil

    self.injections = {}
    self.injections = nil
    self.uguiForm   = nil
end

return AcNewYearScoreRankForm
