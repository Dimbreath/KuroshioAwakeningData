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
	self.btnAttackLock = self.injections.btnAttackLock

	self.traDefend = self.injections.traDefend
	self.traAttack = self.injections.traAttack
	self.traUI = self.injections.traUI
	self.imgDefSelect = self.injections.imgDefSelect
	self.imgAtkSelect = self.injections.imgAtkSelect
	self.txtAttackTime = self.injections.txtAttackTime
	self.imgAttackLock = self.injections.imgAttackLock

	self.ChapterActivityBuffHead = self.injections.ChapterActivityBuffHead
	self.traBuffInfo = self.injections.traBuffInfo
	self.layoutBuff = self.injections.layoutBuff
	self.btnShowBuff = self.injections.btnShowBuff
	self.imgBuffArrow = self.injections.imgBuffArrow
	self.traTaskRedPoint = self.injections.traTaskRedPoint
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
	self.buffItemList = {}
	self.isInit = false
	self:AddListeners()
end

function AcNewYearMainForm:LUA_OnOpen(userData)
	self.manager:ReqNewYearInfo()
	self.manager:ReqTaskForRedPoint()
	self.multiTouchEnabled = CS.UnityEngine.Input.multiTouchEnabled
	CS.UnityEngine.Input.multiTouchEnabled = false
	if self.model.endBattleResult ~= nil and self.model.endBattleResult ~= 1 then
		GameEntry.UI:OpenUIForm(DarkBoom.UIFormId.LoseUIForm)
	end
	self.model.endBattleResult = nil
end

function AcNewYearMainForm:RefreshView()
	self.defendPanel:RefreshView()
	self.attackPanel:RefreshView()
	self:RefreshAttackTogStatus()
	self:RefreshRedPoint()
	if not self.isInit then
		self.isInit = true
		if self.model.endBattleSwitchTog == 2 then			
			self.togAttack.isOn = true
		elseif self.model.endBattleSwitchTog == 1 then
			self:OnTogDefendChange(true)
		else
			if self.attackOpenRemainTime <= 0 then
				self.togAttack.isOn = true
			else
				self:OnTogDefendChange(true)
			end
		end
		self.model.endBattleSwitchTog = 0
	end
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
	self.buffItemList = nil
	if self.multiTouchEnabled ~= nil then
		CS.UnityEngine.Input.multiTouchEnabled = self.multiTouchEnabled
	end
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

	self.btnShowBuff.onClick:AddListener(function()
		self:OnbtnShowBuffClick()
	end)

	self.btnAttackLock.onClick:AddListener(function()
		self:OnbtnAttackLockClick()
	end)
  
	self.togDefend.onValueChanged:AddListener(function(isOn) self:OnTogDefendChange(isOn) end)
	self.togAttack.onValueChanged:AddListener(function(isOn) self:OnTogAttackChange(isOn) end)
	self.event.OpenLevelForm:AddListener(self.OnChangeUIShow,self)
	self.event.RefreshNewYearInfo:AddListener(self.RefreshView,self)
	self.event.RefreshTaskRedPoint:AddListener(self.RefreshRedPoint,self)
	self.event.TurnInResourceFinish:AddListener(self.TurnInResourceFinish,self)
end

function AcNewYearMainForm:RemoveListeners()
  
	self.btnShop.onClick:RemoveAllListeners()
	self.btnShop.onClick:Invoke()
  
	self.btnTask.onClick:RemoveAllListeners()
	self.btnTask.onClick:Invoke()
  
	self.btnRank.onClick:RemoveAllListeners()
	self.btnRank.onClick:Invoke()

	self.btnShowBuff.onClick:RemoveAllListeners()
	self.btnShowBuff.onClick:Invoke()

	self.btnAttackLock.onClick:RemoveAllListeners()
	self.btnAttackLock.onClick:Invoke()

	self.togDefend.onValueChanged:RemoveAllListeners()
	self.togDefend.onValueChanged:Invoke()
	self.togAttack.onValueChanged:RemoveAllListeners()
	self.togAttack.onValueChanged:Invoke()
	self.event.OpenLevelForm:RemoveListener(self.OnChangeUIShow,self)
	self.event.RefreshNewYearInfo:RemoveListener(self.RefreshView,self)
	self.event.RefreshTaskRedPoint:RemoveListener(self.RefreshRedPoint,self)
	self.event.TurnInResourceFinish:RemoveListener(self.TurnInResourceFinish,self)
end

function AcNewYearMainForm:TurnInResourceFinish()
	--�Ͻɳɹ����Ը��º�㡣
	self.manager:ReqTaskForRedPoint()
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
		local date = DarkBoom.DarkBoomUtility.GetDateTime(activityConfig.start)
		self.attackOpenTime = DarkBoom.DarkBoomUtility.ToUnixTime(date)
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
		self.model.curTog = 1
		local config = DarkBoom.ActivitiesMgr.GetInstance():GetActivityConfigData(self.model.defendActivityId)
		if config ~= nil then
			self:RefreshBuffInfo(tonumber(config.parameter_2))
		end
		self.togDefend.transform:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1
	else
		self.togDefend.transform:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 0.4
	end
end

function AcNewYearMainForm:OnTogAttackChange(isOn)
	self.traAttack.gameObject:SetActive(isOn)
	self.imgAtkSelect.gameObject:SetActive(isOn)
	if isOn then
		self.model.curTog = 2
		local config = DarkBoom.ActivitiesMgr.GetInstance():GetActivityConfigData(self.model.attackActivityId)
		if config ~= nil then
			self:RefreshBuffInfo(tonumber(config.parameter_2))
		end
		self.togAttack.transform:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1
	else
		self.togAttack.transform:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 0.4
	end
end

function AcNewYearMainForm:RefreshBuffInfo(intercontinentalId)
	local cfg = DarkBoom.MapConfigMgr.GetWorldIntercontinentalCfg(intercontinentalId)
	local boatBuffList = cfg:GetCoinBoatBuffs()
	local attrBuffBoats = cfg:GetAttrBoatBuffs()
	if attrBuffBoats ~= nil then
		boatBuffList:Add(attrBuffBoats)
	end

	for k,v in pairs(self.buffItemList or {}) do
		v.gameObject:SetActive(false)
	end
	local index = 1
	for k,v in pairs(boatBuffList or {}) do
		if self.buffItemList[index] == nil then
			local go = GameObject.Instantiate(self.ChapterActivityBuffHead.gameObject,self.layoutBuff)
            go.transform.localScale = Vector3.one
			local item = go.transform:GetComponent(typeof(DarkBoom.WorldmapActivityBuffBoatItem))
			self.buffItemList[index] = item
		end
		self.buffItemList[index]:SetData(v, self.mask)
		self.buffItemList[index].gameObject:SetActive(true)
		index = index + 1
	end

end

function AcNewYearMainForm:OnbtnShowBuffClick()
	local show = self.traBuffInfo.gameObject.activeSelf
	self.traBuffInfo.gameObject:SetActive(not show)
	if show then
		self.imgBuffArrow.transform.localScale = Vector3(1,-1,1)
	else
		self.imgBuffArrow.transform.localScale = Vector3.one
	end
end

function AcNewYearMainForm:OnbtnAttackLockClick()
	GameEntry.UI:OpenMsgTipsUIForm(string.gsub(GetDefaultText("activity_stage_tips_01"),"{0}",self.txtAttackTime.text),DarkBoom.SoundEffectType.None)
end

function AcNewYearMainForm:OnChangeUIShow(show)
	--self.traUI.gameObject:SetActive(show)
end

function AcNewYearMainForm:RefreshRedPoint()
	local redPoint = DarkBoom.ActivityShopMgr.GetInstance().RedPoint
	self.traTaskRedPoint.gameObject:SetActive(not (redPoint == 0))
end

return AcNewYearMainForm