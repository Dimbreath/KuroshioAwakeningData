local SelectDicePoint  = class("SelectDicePoint")

function SelectDicePoint:ctor(gameObject,index)
   if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.index = index
    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
    self:InjectComponent()
    self:Init()
end

function SelectDicePoint:InjectComponent()
    self.NumBtn    = self.injections.NumBtn
	self.NumPrefab = self.injections.NumPrefab
end

function SelectDicePoint:Init()
    self.manager  = Game:GetManager("MonopolyManager")
    self.event    = self.manager:GetEvent()
    self.model    = self.manager:GetModel()
    self:AddListeners()
    self:LoadImage()
end

function SelectDicePoint:AddListeners()
    self.NumBtn.onClick:AddListener(function()
        self.model.selectPoint = self.index
        self.event.SpecifyStepClickEvent:Invoke(false)
        self.manager:Dice(1,self.model.specifyStepItemId,self.index,self.model.diceType.Specify)
        self.event.SelectPointEvent:Invoke(self.index)
    end)
    
    self.event.SelectPointEvent:AddListener(self.SetSelectColor,self)
end

function SelectDicePoint:LoadImage( ... )
    local assetPath = self.model:GetDicePointPath_Two(self.index)

	LuaBridge.LoadAysnc4Lua(assetPath,typeof(CS.UnityEngine.Sprite),
	function(assetName, asset, userData)
		self.NumPrefab.sprite = asset
	end,self.model.resMask)
end

function SelectDicePoint:SetSelectColor(index)
    -- if self.index == index then
    --     self.NumPrefab.color = Color(0,255,255)
    -- else
    --     self.NumPrefab.color = Color.white
    -- end
end

function SelectDicePoint:OnRelease ()
    self.NumBtn.onClick:RemoveAllListeners()
    self.NumBtn.onClick:Invoke()
    self.event.SelectPointEvent:RemoveListener(self.SetSelectColor,self)
end

return SelectDicePoint
