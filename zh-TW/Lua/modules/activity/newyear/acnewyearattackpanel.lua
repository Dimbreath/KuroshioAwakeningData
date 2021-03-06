local AcNewYearAttackPanel = class("AcNewYearAttackPanel")
local StagePoint = require"Modules/Activity/NewYear/AcNewYearStagePoint"
function AcNewYearAttackPanel:ctor(gameObject,mask)
    if IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
    self.gameObject = gameObject
    self.mask = mask
	self:InjectComponent()
	self:Init()
end

function AcNewYearAttackPanel:InjectComponent()
	self.traStage = self.injections.traStage
	CS.SafeAreaUtility.SafeAreaToBlack(self.traStage:GetComponent("RectTransform"), true)
	self.stagePoint = self.injections.stagePoint
	self.imgCountryList =
	{
		self.injections.imgCountry1,
		self.injections.imgCountry2,
		self.injections.imgCountry3,
		self.injections.imgCountry4,
	}
	self.traRightBottom = self.injections.traRightBottom
	self.btnFinalRwd = self.injections.btnFinalRwd
	self.imgFinalProgressList =
	{
		self.injections.imgFinalProgress1,
		self.injections.imgFinalProgress2,
		self.injections.imgFinalProgress3,
		self.injections.imgFinalProgress4,
	}
	self.imgHasGet = self.injections.imgHasGet
end

function AcNewYearAttackPanel:Init()
	self.manager  = Game:GetManager("AcNewYearManager")
	self.model    = self.manager:GetModel()
    self.event    = self.manager:GetEvent()
    self.stagePointList = {}
    self:AddListeners()
end

function AcNewYearAttackPanel:AddListeners()
	self.btnFinalRwd.onClick:AddListener(function()
		self:OnbtnFinalRwdClick()
	end)
	self.event.OpenLevelForm:AddListener(self.OnChangeUIShow,self)
	self.event.GetFinalReward:AddListener(self.RefreshFinalRwdProcess,self)
end

function AcNewYearAttackPanel:RemoveListeners()
    self.btnFinalRwd.onClick:RemoveAllListeners()
    self.btnFinalRwd.onClick:Invoke()
	self.event.OpenLevelForm:RemoveListener(self.OnChangeUIShow,self)
	self.event.GetFinalReward:RemoveListener(self.RefreshFinalRwdProcess,self)
end

function AcNewYearAttackPanel:RefreshView()
	self:RefreshStagePoint()
	self:RefreshFinalRwdProcess()
end

function AcNewYearAttackPanel:RefreshStagePoint()
	local harbourList = self.model:GetHarbourList(self.model.attackActivityId)
	local index = 1
	local scaleList = {-1,1,1,-1}
	for k,v in pairs(harbourList) do
		local countryId = self.model:GetAttackHarbourCountryId(k)
		if self.stagePointList[k] == nil then
			local go = GameObject.Instantiate(self.stagePoint.gameObject,self.traStage.transform)
            go:SetActive(true)
			go.transform.localScale = Vector3.one
			local scalex = 1
			if scaleList[index] then
				scalex = scaleList[index]
			end
			local resourceId = tonumber(GetGlobalText("newYear_boss_"..countryId)) 
            local stagePoint = StagePoint.new(go,self.mask,scalex,resourceId)
            self.stagePointList[k] = stagePoint
		end
		self.stagePointList[k]:SetData(countryId,k,v,self.imgCountryList[index],function(harbourId,harbourInfoConfig) self:OnStagePointClick(harbourId,harbourInfoConfig) end)
		index = index + 1
	end
end

function AcNewYearAttackPanel:RefreshFinalRwdProcess()
	local process,maxProcess = self.model:GetAttackProcess()
	for i,v in ipairs(self.imgFinalProgressList) do
		v.gameObject:SetActive(i <= process)
	end
	self.imgHasGet.gameObject:SetActive(self.model.can_draw_personal == 2)
end

function AcNewYearAttackPanel:OnStagePointClick(harbourId,harbourInfoConfig)
    self.event.OpenLevelForm:Invoke(false)
    local userData = {}
    userData.harbourId =  harbourId
    userData.harbourInfoConfig = harbourInfoConfig
    GameEntry.UI:OpenUIForm(7073,userData)
end

function AcNewYearAttackPanel:OnbtnFinalRwdClick()
	if self.model.can_draw_personal == 0 then
		GameEntry.UI:OpenMsgTipsUIForm(GetDefaultText("newyear_reward_tips"),DarkBoom.SoundEffectType.None)
	elseif self.model.can_draw_personal == 1 then
		self.manager:ReqGetAttackReward(1)
	elseif self.model.can_draw_personal == 2 then
		GameEntry.UI:OpenMsgTipsUIForm(GetDefaultText("firstcharge_text_03"),DarkBoom.SoundEffectType.None)
	end
end

function AcNewYearAttackPanel:OnChangeUIShow(show)
	self.traRightBottom.gameObject:SetActive(show)
end

function AcNewYearAttackPanel:OnRelease()
	for k,v in pairs(self.stagePointList) do
		v:OnRelease()
	end
	self.stagePointList = {}
    self:RemoveListeners()
end

return AcNewYearAttackPanel