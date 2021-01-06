local AcNewYearMainForm  = class("AcNewYearMainForm", BaseForm)
local AcNewYearDefendPanel = require"Modules/Activity/NewYear/AcNewYearDefendPanel"
local AcNewYearAttackPanel = require"Modules/Activity/NewYear/AcNewYearAttackPanel"
local ActivityConfig = require"Configs/ActivityConfig"
function AcNewYearMainForm:LUA_OnInit(gameObject,userParamData)
	self.super:LUA_OnInit(gameObject,userParamData)
	self.injections = ParseInjections(gameObject)
	self.uguiForm   = gameObject:GetComponent(typeof(CS.DarkBoom.LuaUGUIForm))
	self.mask = self.uguiForm:GetMask()
	self:InjectComponent()
    self:Init()
end

function AcNewYearMainForm:InjectComponent()
	self.togDefend = self.injections.togDefend
	self.togAttack = self.injections.togAttack
	self.btnShop = self.injections.btnShop
	self.btnTask = self.injections.btnTask
	self.btnRank = self.injections.btnRank

	self.traDefend = self.injections.traDefend
	self.traAttack = self.injections.traAttack
	self.traUI = self.injections.traUI
	self.imgDefSelect = self.injections.imgDefSelect
	self.imgAtkSelect = self.injections.imgAtkSelect
	self.txtAttackTime = self.injections.txtAttackTime
	self.imgAttackLock = self.injections.imgAttackLock
end

function AcNewYearMainForm:Init()
	self.manager  = Game:GetManager("AcNewYearManager")
	self.model    = self.manager:GetModel()
	self.event    = self.manager:GetEvent()
	self.defendPanel = AcNewYearDefendPanel.new(self.traDefend.gameObject,self.mask)
	self.attackPanel = AcNewYearAttackPanel.new(self.traAttack.gameObject,self.mask)
	self.attackOpenRemainTime = 0
	self.timeDelta = 0
	self.attackOpenTime = 0
	self:AddListeners()
end

function AcNewYearMainForm:LUA_OnOpen(userData)
	self.manager:ReqNewYearInfo()
end

function AcNewYearMainForm:RefreshView()
	self.defendPanel:RefreshView()
	self.attackPanel:RefreshView()
	self:RefreshAttackTogStatus()
end

function AcNewYearMainForm:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
	self.timeDelta = self.timeDelta + Time.deltaTime
	if self.timeDelta > 1 then
		self.timeDelta = 0
		self.defendPanel:Update()
		if self.attackOpenRemainTime > 0 then
			self:RefreshAttackOpenRemainTime()
		end
	end
end

function AcNewYearMainForm:LUA_OnClose()
	self:RemoveListeners()
	self.defendPanel:OnRelease()
	self.attackPanel:OnRelease()
end

function AcNewYearMainForm:AddListeners()
  
	self.btnShop.onClick:AddListener(function()
		self:OnbtnShopClick()
	end)
  
	self.btnTask.onClick:AddListener(function()
		self:OnbtnTaskClick()
	end)
  
	self.btnRank.onClick:AddListener(function()
		self:OnbtnRankClick()
	end)
  
	self.togDefend.onValueChanged:AddListener(function(isOn) self:OnTogDefendChange(isOn) end)
	self.togAttack.onValueChanged:AddListener(function(isOn) self:OnTogAttackChange(isOn) end)
	self.event.OpenLevelForm:AddListener(self.OnChangeUIShow,self)
	self.event.RefreshNewYearInfo:AddListener(self.RefreshView,self)
end

function AcNewYearMainForm:RemoveListeners()
  
	self.btnShop.onClick:RemoveAllListeners()
	self.btnShop.onClick:Invoke()
  
	self.btnTask.onClick:RemoveAllListeners()
	self.btnTask.onClick:Invoke()
  
	self.btnRank.onClick:RemoveAllListeners()
	self.btnRank.onClick:Invoke()

	self.togDefend.onValueChanged:RemoveAllListeners()
	self.togAttack.onValueChanged:RemoveAllListeners()
	self.event.OpenLevelForm:RemoveListener(self.OnChangeUIShow,self)
	self.event.RefreshNewYearInfo:RemoveListener(self.RefreshView,self)
end

function AcNewYearMainForm:OnbtnShopClick()
	CS.DarkBoom.ActivityShopMgr.GetInstance():UpDateActivityShopInfo(string.format("%s,%s", tostring(self.model.defendActivityId), tostring(self.model.attackActivityId)), CS.DarkBoom.ExChangeShopType.Activity)
	CS.DarkBoom.GameEntry.UI:OpenUIForm(CS.DarkBoom.UIFormId.ActivityShopForm)
end

function AcNewYearMainForm:OnbtnTaskClick()
	CS.DarkBoom.ActivityShopMgr.GetInstance():UpDateActivityShopInfo(string.format("%s,%s", tostring(self.model.defendActivityId), tostring(self.model.attackActivityId)), CS.DarkBoom.ExChangeShopType.Activity)
	CS.DarkBoom.GameEntry.UI:OpenUIForm(CS.DarkBoom.UIFormId.ActivityShopForm, 1)
end

function AcNewYearMainForm:OnbtnRankClick()
	LuaBridge.OpenUIForm(7075)
end

function AcNewYearMainForm:RefreshAttackTogStatus()
	if self.attackOpenTime == 0 then
		local activityConfig = ActivityConfig.GetConfig(self.model.attackActivityId)
		if activityConfig == nil then
			return
		end
		self.attackOpenTime = DarkBoom.DarkBoomUtility.GetTimeSpan(activityConfig.start)
	end
	self.attackOpenRemainTime = self.attackOpenTime - DarkBoomUtility.GetServerCrtTime()
	if self.attackOpenRemainTime <= 0 then
		self.attackOpenRemainTime = 0
		self.txtAttackTime.gameObject:SetActive(false)
		self.imgAttackLock.gameObject:SetActive(false)
		self.togAttack.interactable = true
	else
		self.txtAttackTime.gameObject:SetActive(true)
		self.imgAttackLock.gameObject:SetActive(true)
		self.togAttack.interactable = false
	end
end

function AcNewYearMainForm:RefreshAttackOpenRemainTime()
	self.attackOpenRemainTime = self.attackOpenTime - DarkBoomUtility.GetServerCrtTime()
	if self.attackOpenRemainTime <= 0 then
		self:RefreshAttackTogStatus()
	else
		local str = DarkBoom.DarkBoomUtility.ToDayHourMinuteSecond(self.attackOpenRemainTime)
		self.txtAttackTime.text = str
	end
end

function AcNewYearMainForm:OnTogDefendChange(isOn)
	self.traDefend.gameObject:SetActive(isOn)
	self.imgDefSelect.gameObject:SetActive(isOn)
	if isOn then
		self.togDefend.transform:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1
	else
		self.togDefend.transform:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 0.4
	end
end

function AcNewYearMainForm:OnTogAttackChange(isOn)
	self.traAttack.gameObject:SetActive(isOn)
	self.imgAtkSelect.gameObject:SetActive(isOn)
	if isOn then
		self.togAttack.transform:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1
	else
		self.togAttack.transform:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 0.4
	end
end

function AcNewYearMainForm:OnChangeUIShow(show)
	self.traUI.gameObject:SetActive(show)
end

return AcNewYearMainForm