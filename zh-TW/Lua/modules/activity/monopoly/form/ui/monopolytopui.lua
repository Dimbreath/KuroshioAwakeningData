local MonopolyTopUI  = class("MonopolyTopUI")
local SelectDicePoint = require "Modules/Activity/Monopoly/Form/UI/SelectDicePoint"

function MonopolyTopUI:ctor(gameObject)
   if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:Init()
end

function MonopolyTopUI:InjectComponent()
	self.NumsContainer = self.injections.NumsContainer
	self.NumPrefab = self.injections.NumPrefab
	self.SelectDiceBtn = self.injections.SelectDiceBtn
	self.SelectDiceView = self.injections.SelectDiceView
	self.DiceAnimPoint = self.injections.DiceAnimPoint
	self.DiceAnimSkeleton = self.injections.DiceAnimSkeleton
	self.AnimContainer = self.injections.AnimContainer
end

function MonopolyTopUI:Init()
	self.pointList = {}
	self.dicAnimPointList = {}
	self.manager = Game:GetManager("MonopolyManager")
	self.model = self.manager:GetModel()
	self.event = self.manager:GetEvent()
	
	self:AddListeners()
end

function MonopolyTopUI:AddListeners()
	self.SelectDiceBtn.onClick:AddListener(function() 
		if self.SelectDiceView then
			self.SelectDiceView.gameObject:SetActive(false)
		end
	end)
	
	self.event.MonopolyDiceEvent:AddListener(self.OnMonopolyDiceEvent,self)
	self.event.SpecifyStepClickEvent:AddListener(self.OnSpecifyStepClickEvent,self)
end

function MonopolyTopUI:RemoveListeners()
	self.SelectDiceBtn.onClick:RemoveAllListeners()
	self.SelectDiceBtn.onClick:Invoke()

	self.event.MonopolyDiceEvent:RemoveListener(self.OnMonopolyDiceEvent,self)
	self.event.SpecifyStepClickEvent:RemoveListener(self.OnSpecifyStepClickEvent,self)
end

function MonopolyTopUI:OnSpecifyStepClickEvent(isopen)
	self.SelectDiceView.gameObject:SetActive(isopen)
end

function MonopolyTopUI:UpdateData()
	self:CreatePoints()
	self.AnimContainer.gameObject:SetActive(false)
	self.SelectDiceView.gameObject:SetActive(false)
end

function MonopolyTopUI:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
	if self.trackEntry ~= nil and self.trackEntry.IsComplete then
		self:PlayDiceAnimComplete()
	end

	if self.IsPlayNextDiceAnim then
		self:PlayDiceAnimNext()
	end
	
	if self.IsDiceAnimComplete and self.diceAimDisappearTime > 0 then
		self.diceAimDisappearTime = self.diceAimDisappearTime - Time.deltaTime
		if self.diceAimDisappearTime <= 0 then
			self:PlayDiceAnimEnd()
		end
	end
end

function MonopolyTopUI:PlayDiceAnimComplete()
	if #self.dicAnimPointList <= 0 then return end

	self.trackEntry = nil
	self.DiceAnimPoint.gameObject:SetActive(true)
	table.remove(self.dicAnimPointList,1)
	self.IsPlayNextDiceAnim  = #self.dicAnimPointList > 0
	self.IsDiceAnimComplete  = #self.dicAnimPointList <= 0
end

function MonopolyTopUI:PlayDiceAnimNext()
	self.playDiceAnimInterval = self.playDiceAnimInterval - Time.deltaTime
	if self.playDiceAnimInterval > 0 then return end
	self:PlayDiceAnim(self.dicAnimPointList[1])
end

function MonopolyTopUI:PlayDiceAnimEnd()
	self.dicAnimPointList = {}
	self.IsDiceAnimComplete = false
	self.AnimContainer.gameObject:SetActive(false)
	self.event.StartMoveEvent:Invoke(self.stepList)
end

function MonopolyTopUI:PlayDiceAnim(point)
	self.IsPlayNextDiceAnim = false
	self.DiceAnimPoint.gameObject:SetActive(false)
	local assetPath = self.model:GetDicePointPath(point)

	LuaBridge.LoadAysnc4Lua(assetPath,typeof(CS.UnityEngine.Sprite),
		function(assetName, asset, userData)
			self.DiceAnimPoint.sprite = asset
			self.trackEntry = self.DiceAnimSkeleton.AnimationState:SetAnimation(0, "loop", false)
		end,self.model.resMask)
end

function MonopolyTopUI:CreatePoints()
	for i= 1,6 do
        local go = GameObject.Instantiate(self.NumPrefab.gameObject,self.NumsContainer.transform)
        go:SetActive(true)
		go.transform.localScale  = Vector3.one
		local point = SelectDicePoint.new(go,i)
		table.insert(self.pointList,i,point)
	end
end

function MonopolyTopUI:OnMonopolyDiceEvent(stepList,diceType)
	self.dicAnimPointList = {}

	--单次投掷
	if TableLength(stepList) <= 0 then
		return
	end
	
	if diceType == self.model.diceType.Specify then return end
	
	self.playDiceAnimInterval = tonumber(GetGlobalText("monopoly_dice_anim_interval"))
	self.diceAimDisappearTime = tonumber(GetGlobalText("monopoly_dice_disappear_time"))
	self.IsPlayNextDiceAnim = false
	self.IsDiceAnimComplete = false
	
	self.stepList = stepList
	for i,v in ipairs(stepList) do
		table.insert(self.dicAnimPointList,v.point)
	end

	self:PlayDiceAnim(self.dicAnimPointList[1])
	self.AnimContainer.gameObject:SetActive(true)
end

function MonopolyTopUI:OnRelease()
	self:RemoveListeners()
	self.IsPlayNextDiceAnim = false
	self.IsDiceAnimComplete = false
	self.dicAnimPointList = {}

	for i,v in ipairs(self.pointList) do
       v:OnRelease()
	end

	self.pointList = {}
end

return MonopolyTopUI
