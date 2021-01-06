local ActivitySupplicateEntry  = class("ActivitySupplicateEntry")
local RewardItem = require"Modules/Activity/Supplicate/AcSupplicateRewardItem"
local BehaviorItem = require"Modules/Activity/Supplicate/AcSupplicateBehaviorItem"
function ActivitySupplicateEntry:OnInit(gameObject,mask)
	self.injections = ParseInjections(gameObject)
    self.mask = mask
	self.gameObject = gameObject
	self.deepJumpId = 103
	self.strokeJumpId = 1000
	self:InjectComponent()
	self:Init(mask)
end

function ActivitySupplicateEntry:InjectComponent()
	self.btnSupplicate = self.injections.btnSupplicate
	self.imgSupplicateAnime = self.injections.imgSupplicateAnime
	self.txtSupplicateCost = self.injections.txtSupplicateCost
	self.traReward = self.injections.traReward
	self.rewardItem = self.injections.rewardItem
	self.btnTotal = self.injections.btnTotal
	self.avatar = self.injections.avatar
	self.txtRemainTime = self.injections.txtRemainTime
	self.traBehaviorContent = self.injections.traBehaviorContent
	self.behaviorItem = self.injections.behaviorItem
	self.togDeep = self.injections.togDeep
	self.togStroke = self.injections.togStroke
	self.canvasTogDeep = self.injections.canvasTogDeep
	self.canvasTogStroke = self.injections.canvasTogStroke
	self.btnGo = self.injections.btnGo
end

function ActivitySupplicateEntry:Init(mask)
	self.manager = Game:GetManager("AcSupplicateMgr")
    self.model = self.manager:GetModel()
    self.event = self.manager:GetEvent()
	self.model.resMask = mask
	self:AddListeners()
	self.behaviorItemList = {}
	self.rewardItemList = {}
	self.init = false
	self.timeDelta = 0
end

function ActivitySupplicateEntry:AddListeners()
	self.btnSupplicate.onClick:AddListener(function()
			self:PlayClickAnime()
		end)
	self.btnTotal.onClick:AddListener(function()
		LuaBridge.OpenUIForm(230)
	end)
	self.togDeep.onValueChanged:AddListener(function(isOn) self:OnDeepTogChange(isOn) end)
	self.togStroke.onValueChanged:AddListener(function(isOn) self:OnStrokeTogChange(isOn) end)
	self.btnGo.onClick:AddListener(function()
		self:OnGo()
		local uiForm = DarkBoom.GameEntry.UI:GetUIForm(5040)
		DarkBoom.GameEntry.UI:CloseUIForm(uiForm)
	end)
	self.event.SupplicateInfoEvent:AddListener(self.OnSupplicateInfoEvent,self)
	self.event.GetRandRewardEvent:AddListener(self.OnSupplicateEvent,self)
	UpdateEvent:AddListener(self.Update,self)
end

function ActivitySupplicateEntry:RemoveListeners()
	self.btnSupplicate.onClick:RemoveAllListeners()
	self.btnSupplicate.onClick:Invoke()
	self.btnTotal.onClick:RemoveAllListeners()
	self.btnTotal.onClick:Invoke()
	self.btnGo.onClick:RemoveAllListeners()
	self.btnGo.onClick:Invoke()
	self.togDeep.onValueChanged:RemoveAllListeners()
	self.togStroke.onValueChanged:RemoveAllListeners()
	self.event.SupplicateInfoEvent:RemoveListener(self.OnSupplicateInfoEvent,self)
	self.event.GetRandRewardEvent:RemoveListener(self.OnSupplicateEvent,self)
	UpdateEvent:RemoveListener(self.Update,self)
end

function ActivitySupplicateEntry:OnOpen(tagId)
	self.tagId = tagId
	self.model:SetTagId(tagId)
	self.manager:ReqSupplicateInfo(tagId)
	if self.init == false then
		local resourceId = self.model:GetResourceId()
		self.avatar:LoadAvatar(resourceId,CS.Config.AvatarScene.None,true)
		self:RefreshBehaviorInfo()
		self.init = true
	end
end

function ActivitySupplicateEntry:Update()
	self.timeDelta = self.timeDelta + Time.deltaTime
	if self.timeDelta > 1 then
		self.timeDelta = 0
		local curTime = DarkBoomUtility.GetServerCrtTime()
		local endTime = self.model.countDown
		if type(endTime) ~= "number" then return end
		local remainTime = endTime - curTime
		if remainTime <= 0 then
			remainTime = 0
		end
		self.txtRemainTime.text = GetDefaultText("activity_new_text_09")..DarkBoomUtility.ToDayHourMinuteSecond(remainTime)
	end
end

function ActivitySupplicateEntry:OnSupplicateInfoEvent()
	self:RefreshRewardInfo()
	self:RefreshScoreInfo()
end

function ActivitySupplicateEntry:OnSupplicateEvent()
	self:RefreshRewardInfo()
	self:RefreshScoreInfo()
end

function ActivitySupplicateEntry:OnGo()
	if self.togDeep.isOn then
		CS.CommonTranslater.TranslateBySourceId(self.deepJumpId)
	elseif self.togStroke.isOn then
		CS.CommonTranslater.TranslateBySourceId(self.strokeJumpId)
	end
end

function ActivitySupplicateEntry:OnClickSupplicate()
	if not self.model:CanSupplicate() then
		local itemName = self.model:GetScoreName()
		local notEnough = string.gsub(GetDefaultText("common_resource_not_enough"),"{0}","")
		GameEntry.UI:OpenMsgTipsUIForm(itemName..notEnough, CS.DarkBoom.SoundEffectType.Tips)
		return
	end
	local actId = self.model:GetTagId()
	if actId == 0 then return end
	self.manager:ReqSupplicate(actId)
end

function ActivitySupplicateEntry:PlayClickAnime()
	self.btnSupplicate.enabled = false
	self.imgSupplicateAnime:Play("activity_supplicate",-1,0)
	CS.DG.Tweening.DOVirtual.DelayedCall(0.5, function()
		self:OnClickSupplicate()
		self.btnSupplicate.enabled = true
	end, false)
end

function ActivitySupplicateEntry:RefreshScoreInfo()
	local curScore = self.model:GetCurScore()
	local costScore = self.model:GetCostScore()
	if curScore >= costScore then
		self.txtSupplicateCost.text = string.format("<color=#00FFFF>%s</color><color=#FFFFFF>/%s</color>",curScore,costScore)
	else
		self.txtSupplicateCost.text = string.format("<color=#FF64A5>%s</color><color=#FFFFFF>/%s</color>",curScore,costScore)
	end
end

function ActivitySupplicateEntry:RefreshRewardInfo()
	local showList = self.model:GetShowRewardList()
	for i,v in ipairs(showList) do
		if self.rewardItemList[v.id] == nil then
			local go = GameObject.Instantiate(self.rewardItem.gameObject,self.traReward.transform)
			go:SetActive(true)
			go.transform.localScale = Vector3.one
			local grid = RewardItem.new(go)
			self.rewardItemList[v.id] = grid
		end
		local status = self.model:GetRewardStatus(v.id)
		self.rewardItemList[v.id]:SetData(v.reward,status,self.mask)
	end
end

function ActivitySupplicateEntry:OnDeepTogChange(isOn)
	if isOn then
		self.canvasTogDeep.alpha = 1
		self:RefreshBehaviorInfo()
	else
		self.canvasTogDeep.alpha = 0.5
	end
end

function ActivitySupplicateEntry:OnStrokeTogChange(isOn)
	if isOn then
		self.canvasTogStroke.alpha = 1
		self:RefreshBehaviorInfo()
	else
		self.canvasTogStroke.alpha = 0.5
	end
end

function ActivitySupplicateEntry:RefreshBehaviorInfo()
	local behaviorList = {}
	if self.togDeep.isOn then
		behaviorList = self.model:GetDeepBehaviorList()
	elseif self.togStroke.isOn then
		behaviorList = self.model:GetStrokeBehaviorList()
	end
	for i,v in ipairs(self.behaviorItemList) do
		v:SetActive(false)
	end
	for i,v in ipairs(behaviorList) do
		if self.behaviorItemList[i] == nil then
			local go = GameObject.Instantiate(self.behaviorItem.gameObject,self.traBehaviorContent.transform)
			go.transform.localScale = Vector3.one
			local grid = BehaviorItem.new(go)
			self.behaviorItemList[i] = grid
		end
		self.behaviorItemList[i]:SetActive(true)
		self.behaviorItemList[i]:SetData(v.desc,v.getScore)
	end
end

function ActivitySupplicateEntry:RefreshUI()
   
end

function ActivitySupplicateEntry:OnRelease()
	self:RemoveListeners()

	for k,v in pairs(self.rewardItemList) do
		v:OnRelease()
	end
	self.rewardItemList = nil
	self.behaviorItemList = nil
	self.injections = {}
	self.injections = nil

	self.manager = nil
	self.event = nil
	self.model = nil
end

function ActivitySupplicateEntry:SetActive(show)
    self.gameObject:SetActive(show)
end

return ActivitySupplicateEntry