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
    self.isOpened = false
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
    self.btnBossLevel = self.injections.btnBossLevel
    self.imgBossLevel = self.injections.imgBossLevel
    self.scrollMap = self.injections.scrollMap
    CS.SafeAreaUtility.SafeAreaToBlack(self.scrollMap:GetComponent("RectTransform"), true)
    self.aniDirector = self.injections.aniDirector.gameObject:GetComponent(typeof(CS.DarkBoom.BackHouseNew.Animator.AnimatorDirector))
    self.aniMove = self.injections.move_Root.gameObject:GetComponent(typeof(CS.DarkBoom.BackHouseNew.Animator.AnimationMove))
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
    if self.model.endBattleScrollPos ~= nil then
        self.traMapRoot:GetComponent("RectTransform").anchoredPosition = self.model.endBattleScrollPos
        self.model.endBattleScrollPos = nil
    end
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
    local isOpen = self.model:IsBossLevelOpen()
    self.bossLevelPoint:SetActive(isOpen)
    self.btnTurnIn.gameObject:SetActive(not isOpen)
    self.layoutResource.gameObject:SetActive(not isOpen)
    self.btnBossLevel.gameObject:SetActive(isOpen)
    self.imgBossLevel.gameObject:SetActive(isOpen)
end

function AcNewYearDefendPanel:AddListeners()
    self.btnTurnIn.onClick:AddListener(function()
		self:OnbtnTurnInClick()
    end)
    self.btnBossLevel.onClick:AddListener(function()
		self:OnbtnBossLevelClick()
    end)
    self.event.OpenLevelForm:AddListener(self.OnChangeUIShow,self)
    self.event.TurnInResourceFinish:AddListener(self.RefreshMorale,self)
end

function AcNewYearDefendPanel:RemoveListeners()
    self.btnTurnIn.onClick:RemoveAllListeners()
    self.btnTurnIn.onClick:Invoke()
    self.btnBossLevel.onClick:RemoveAllListeners()
    self.btnBossLevel.onClick:Invoke()
    self.event.OpenLevelForm:RemoveListener(self.OnChangeUIShow,self)
    self.event.TurnInResourceFinish:RemoveListener(self.RefreshMorale,self)
end

--- 打开调用此函数
function AcNewYearDefendPanel:OnOpen()
    self:MoveToDefault()
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
    if  not self.isOpened  then
        self:OnOpen()
        self.isOpened = true
    end
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
    if self.bossLevelPoint ~= nil then
        self.bossLevelPoint.gameObject:GetComponent("RectTransform").anchoredPosition = Vector2(9999,9999)--boss关卡旧逻辑保留，防止策划又要
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
    --local callBack = clickCallback
    --clickCallback = function(harbourId,harbourInfoConfig)
    --    self.MoveTo(levelPoint.transform.position,function()
    --        if callBack ~= nil then
    --            callBack(harbourId,harbourInfoConfig)
    --        end
    --    end)
    --end
    local point = self.levelPointList[harbourId]
    local position = - point.gameObject:GetComponent("RectTransform").anchoredPosition3D;
    position.x =  position.x - 220
    self:MoveTo(position,nil)
    self.manager:ReqNewYearInfo(function()
        self.event.OpenLevelForm:Invoke(false)
        local userData = {}
        userData.harbourId =  harbourId
        userData.harbourInfoConfig = harbourInfoConfig
        GameEntry.UI:OpenUIForm(7073,userData)
        self.model.endBattleScrollPos = self.traMapRoot:GetComponent("RectTransform").anchoredPosition
    end)
end

function AcNewYearDefendPanel:MoveToDefault()
    local harbourId = self:GetDefaultMoveHarbourID()
    local point = self.levelPointList[harbourId]
    if point~=nil then
        local position = - point.gameObject:GetComponent("RectTransform").anchoredPosition3D;
        position.x =  position.x
        self:MoveTo(position,nil)
    end
    --self.manager:ReqNewYearInfo(function()
    --    self.event.OpenLevelForm:Invoke(false)
    --    local userData = {}
    --    userData.harbourId =  harbourId
    --    userData.harbourInfoConfig = harbourInfoConfig
    --    GameEntry.UI:OpenUIForm(7073,userData)
    --    self.model.endBattleScrollPos = self.traMapRoot:GetComponent("RectTransform").anchoredPosition
    --end)
end


function AcNewYearDefendPanel:MoveTo(targetPos,callBack)
    self.aniMove.TargetPosition = targetPos
    self.aniDirector:Play(callBack)
end

function AcNewYearDefendPanel:GetDefaultMoveHarbourID()
    local harbourList = self.model:GetHarbourList(self.model.defendActivityId)
    local id  = 999999999
    ---TODO 这里取第一个未解锁值
    for k,v in pairs(harbourList) do
        if k< id then
            id = k
        end
    end
    return id
end

---@param harbourId number
---@harbourInfoConfig  harbourInfoConfig  HarbourInfoConfig
function AcNewYearDefendPanel:OnRewardPointClick(harbourId,harbourInfoConfig)
	self.manager:OpenAcNewYearLevelRewardForm(harbourId)
end

function AcNewYearDefendPanel:OnbtnBossLevelClick()
    if self.bossLevelPoint == nil then
        return
    end
    self.manager:OpenAcNewYearLevelRewardForm(self.bossLevelPoint.harbourId)
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
    self:RefreshBossLevelInfo()
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
    --if not self.gameObject:IsActive() and show then
    --    self:OnOpen()
    --end
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
    self.turnInItemList = {}
    self.bossLevelPoint = nil
    self:RemoveListeners()
end


return AcNewYearDefendPanel