local MonopolyUIView  = class("MonopolyUIView")
local ItemConfig      = require "Configs/ItemConfig"
local MonopolyDiceBtn = require "Modules/Activity/Monopoly/Form/UI/MonopolyDiceBtn"

function MonopolyUIView:ctor(gameObject)
   if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:Init()
end

function MonopolyUIView:InjectComponent()
	self.DiceBtn = self.injections.DiceBtn
	self.RemainDiceNum = self.injections.RemainDiceNum
	self.BuyDiceBtn      = self.injections.BuyDiceBtn
	self.NumPrefab 		 = self.injections.NumPrefab
	self.DoubleDice  	 = self.injections.DoubleDice
	self.SpecifyStep     = self.injections.SpecifyStep
	self.ExchangeShopBtn = self.injections.ExchangeShopBtn
	self.SelectDiceView  = self.injections.SelectDiceView
	self.Anim            = self.injections.Anim
	self.DiceBgGrey      = self.injections.DiceBgGrey
	self.DiceBgNormal    = self.injections.DiceBgNormal
	self.NumsContainer   = self.injections.NumsContainer
	self.DiceAnimSequence = self.injections.DiceAnimSequence
end

function MonopolyUIView:Init()
	self.manager = Game:GetManager("MonopolyManager")
	self.model = self.manager:GetModel()
	self.event = self.manager:GetEvent()

	self.SpecifyStepBtn = MonopolyDiceBtn.new(self.SpecifyStep,self.model.diceType.Specify)
	self.DoubleDiceBtn  = MonopolyDiceBtn.new(self.DoubleDice,self.model.diceType.Double)
	self:AddListeners()
end

function MonopolyUIView:AddListeners()
	self.ExchangeShopBtn.onClick:AddListener(function()
		CS.DarkBoom.LuaActivityBridge.OpenActivityShop(tostring(self.model.tagId))
	end)

	self.DiceBtn.onClick:AddListener(function()
		self:OnDiceBtnClick()
	end)

	self.BuyDiceBtn.onClick:AddListener(function() 
		self:OnBuyDiceBtn() 
	end)

	ItemChangeEvent:AddListener(self.OnItemChangeEvent,self)
end

function MonopolyUIView:RemoveListeners()
	self.BuyDiceBtn.onClick:RemoveAllListeners()
	self.BuyDiceBtn.onClick:Invoke()

	self.DiceBtn.onClick:RemoveAllListeners()
	self.DiceBtn.onClick:Invoke()

	self.ExchangeShopBtn.onClick:RemoveAllListeners()
	self.ExchangeShopBtn.onClick:Invoke()

	ItemChangeEvent:RemoveListener(self.OnItemChangeEvent,self)
end

function MonopolyUIView:OnBuyDiceBtn()
	local shopType = self.model.shopId
	local commodityId = self.model.diceCostShopId
	LuaBridge.OnQuickBuyCommodity4Lua(shopType,commodityId)
end

function MonopolyUIView:OnItemChangeEvent()
	self:UpdateItems()
end

function MonopolyUIView:UpdateData()
	self.SpecifyStepBtn:UpdateBtn()
	self.DoubleDiceBtn:UpdateBtn()
	self:UpdateItems()
end

function MonopolyUIView:OnDiceBtnClick ()
	local diceItemName, diceItemNum =  self.model:GetItemInfo(self.model.diceItemId)

	if diceItemNum > 0 then
		self.manager:Dice(2,0,0,self.model.diceType.Single)
	else
		self:OnBuyDiceBtn()
	end
end

function MonopolyUIView:UpdateItems()
	local diceItemName, diceItemNum =  self.model:GetItemInfo(self.model.diceItemId)
	self.RemainDiceNum.text = tostring(diceItemNum)
	self.DiceBgGrey.gameObject:SetActive(diceItemNum <= 0)
	self.DiceBgNormal.gameObject:SetActive(diceItemNum > 0)
end
------------------------------------------------------------------
function MonopolyUIView:OnRelease()
	self.Anim = nil
	self.pointList = {}
	self.SelectDiceView = nil
	self:RemoveListeners()
	self.SpecifyStepBtn:OnRelease()
	self.DoubleDiceBtn:OnRelease()
end

return MonopolyUIView
