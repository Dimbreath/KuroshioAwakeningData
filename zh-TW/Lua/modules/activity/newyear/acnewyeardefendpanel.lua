local AcNewYearDefendPanel = class("AcNewYearDefendPanel")
local LevelPoint = require"Modules/Activity/NewYear/AcNewYearLevelPoint"
local NpcPoint = require"Modules/Activity/NewYear/AcNewYearNpcPoint"
local AcNewYearTurnInItem = require"Modules/Activity/NewYear/AcNewYearTurnInItem"
function AcNewYearDefendPanel:ctor(gameObject,mask)
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

function AcNewYearDefendPanel:InjectComponent()
    self.levelPoint = self.injections.levelPoint
    self.npcPoint = self.injections.npcPoint
    self.traMapRoot = self.injections.traMapRoot
    self.traRightTop = self.injections.traRightTop
    self.imgProgress = self.injections.imgProgress
	self.imgProgressBg = self.injections.imgProgressBg
	self.layoutResource = self.injections.layoutResource
    self.btnTurnIn = self.injections.btnTurnIn
    self.txtMaxMorale = self.injections.txtMaxMorale
	self.txtCurMorale = self.injections.txtCurMorale
	self.traResItem = self.injections.traResItem
end

function AcNewYearDefendPanel:Init()
	self.manager  = Game:GetManager("AcNewYearManager")
	self.model    = self.manager:GetModel()
    self.event    = self.manager:GetEvent()
    self.levelPointList = {}
    self.npcPointList = {}
    self.turnInItemList = {}
    self.bossLevelPoint = nil
    self:AddListeners()
end

function AcNewYearDefendPanel:Update()
    if self.model:IsBossLevelOpen() then
        self:RefreshMoraleProcess()
    elseif self.bossLevelPoint ~= nil and self.bossLevelPoint:IsActive() then
        self:RefreshBossLevelInfo()
    end
end

function AcNewYearDefendPanel:RefreshBossLevelInfo()
    if self.bossLevelPoint == nil then
        return
    end
    self.bossLevelPoint:SetActive(self.model:IsBossLevelOpen())
    self.btnTurnIn.gameObject:SetActive(not self.model:IsBossLevelOpen())
end

function AcNewYearDefendPanel:AddListeners()
    self.btnTurnIn.onClick:AddListener(function()
		self:OnbtnTurnInClick()
    end)
    self.event.OpenLevelForm:AddListener(self.OnChangeUIShow,self)
    self.event.TurnInResourceFinish:AddListener(self.RefreshMorale,self)
end

function AcNewYearDefendPanel:RemoveListeners()
    self.btnTurnIn.onClick:RemoveAllListeners()
    self.btnTurnIn.onClick:Invoke()
    self.event.OpenLevelForm:RemoveListener(self.OnChangeUIShow,self)
    self.event.TurnInResourceFinish:RemoveListener(self.RefreshMorale,self)
end

function AcNewYearDefendPanel:RefreshView()
    self:RefreshLevelPoint(function(harbourId,harbourInfoConfig)
        if harbourInfoConfig.type == self.model.harbourType.Reward then
            self:OnRewardPointClick(harbourId,harbourInfoConfig)
        else
            self:OnLevelPointClick(harbourId,harbourInfoConfig)
        end
    end)
    self:RefreshNpcPoint()
    self:RefreshMorale()
end

function AcNewYearDefendPanel:RefreshLevelPoint(clickCallback)
    local harbourList =  self.model:GetHarbourList(self.model.defendActivityId)
    for k,v in pairs(harbourList) do
        if self.levelPointList[k] == nil then
            local go = GameObject.Instantiate(self.levelPoint.gameObject,self.traMapRoot.transform)
            go:SetActive(true)
            go.transform.localScale = Vector3.one
            local levelPoint = LevelPoint.new(go)
            self.levelPointList[k] = levelPoint
            if v.type == self.model.harbourType.Reward then
                self.bossLevelPoint = levelPoint
            end
        end
        self.levelPointList[k]:SetData(k,v,clickCallback)
    end
end

function AcNewYearDefendPanel:RefreshNpcPoint()
    local npcList =  self.model:GetNpcList()
    for k,v in pairs(npcList) do
        if self.npcPointList[k] == nil then
            local go = GameObject.Instantiate(self.npcPoint.gameObject,self.traMapRoot.transform)
            go:SetActive(true)
            go.transform.localScale = Vector3.one
            local npcPoint = NpcPoint.new(go,self.mask)
            self.npcPointList[k] = npcPoint
        end
        self.npcPointList[k]:SetData(k,v)
    end 
end

function AcNewYearDefendPanel:OnLevelPointClick(harbourId,harbourInfoConfig)
    self.event.OpenLevelForm:Invoke(false)
    local userData = {}
    userData.harbourId =  harbourId
    userData.harbourInfoConfig = harbourInfoConfig
    GameEntry.UI:OpenUIForm(7073,userData)
end

function AcNewYearDefendPanel:OnRewardPointClick(harbourId,harbourInfoConfig)
	self.manager:OpenAcNewYearLevelRewardForm(harbourId)
end

function AcNewYearDefendPanel:OnbtnTurnInClick()
    LuaBridge.OpenUIForm(7076)
end

function AcNewYearDefendPanel:RefreshMorale()
	local itemList = {self.model.primaryResItemId,self.model.middleResItemId,self.model.highResItemId}
	for i,v in ipairs(itemList) do
        if self.turnInItemList[v] == nil then
            local go = GameObject.Instantiate(self.traResItem.gameObject,self.layoutResource.transform)
            go:SetActive(true)
            go.transform.localScale = Vector3.one
            local item = AcNewYearTurnInItem.new(go)
            self.turnInItemList[v] = item
        end
        self.turnInItemList[v]:SetData(v,self.mask)
    end
    self.btnTurnIn.gameObject:SetActive(not self.model:IsBossLevelOpen())
    self:RefreshMoraleProcess()
end

function AcNewYearDefendPanel:RefreshMoraleProcess()
    local curMorale = self.model:GetCurMorale()
	self.txtMaxMorale.text = self.model.maxMorale
	self.txtCurMorale.text = curMorale
	if self.model.maxMorale ~= 0 then
		local bgSize = self.imgProgressBg.sizeDelta
		local progress = curMorale/self.model.maxMorale
		if progress > 1 then
			progress = 1
		end
		self.imgProgress.sizeDelta = Vector2(bgSize.x * progress,bgSize.y)
	end
end

function AcNewYearDefendPanel:OnChangeUIShow(show)
	self.traRightTop.gameObject:SetActive(show)
end

function AcNewYearDefendPanel:OnRelease()
    for k,v in pairs(self.levelPointList) do
        v:OnRelease()
    end
    for k,v in pairs(self.npcPointList) do
        v:OnRelease()
    end
    self.levelPointList = {}
    self.npcPointList = {}
    self:RemoveListeners()
end


return AcNewYearDefendPanel