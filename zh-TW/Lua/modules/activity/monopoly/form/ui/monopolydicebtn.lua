local MonopolyDiceBtn  = class("MonopolyDiceBtn")
local ItemConfig       = require "Configs/ItemConfig"

function MonopolyDiceBtn:ctor(gameObject,index)
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

function MonopolyDiceBtn:InjectComponent()
	self.DiceBtn = self.injections.DiceBtn
	self.OwnNum = self.injections.OwnNum
	self.DiceIcon = self.injections.DiceIcon
	self.BuyItemIcon = self.injections.BuyItemIcon
	self.BuyItemNum = self.injections.BuyItemNum
    self.BuyItemContainer = self.injections.BuyItemContainer
end

function MonopolyDiceBtn:Init()
    self.manager = Game:GetManager("MonopolyManager")
	self.model = self.manager:GetModel()
    self.event = self.manager:GetEvent()
    self:AddListeners()
end

function MonopolyDiceBtn:AddListeners()
    self.DiceBtn.onClick:AddListener(function()
        self:OnButtonClick()
    end)

    ItemChangeEvent:AddListener(self.OnItemChangeEvent,self)
end

function MonopolyDiceBtn:RemoveListeners()
	self.DiceBtn.onClick:RemoveAllListeners()
	self.DiceBtn.onClick:Invoke()
	ItemChangeEvent:RemoveListener(self.OnItemChangeEvent,self)
end

function MonopolyDiceBtn:OnItemChangeEvent()
    self:UpdateBtnInfo()
end

function MonopolyDiceBtn:OnButtonClick()
    local diceItemName, diceItemNum =  self:GetItemInfo(self.diceItemId)
    if diceItemNum <= 0 then 
        local shopType = self.model.shopId
        local commodityId = self.subShopId
        LuaBridge.OnQuickBuyCommodity4Lua(shopType,commodityId)
        return 
    end

    self:DoClick()
end

function MonopolyDiceBtn:DoClick()
	local singlediceName, singleDiceNum =  self.model:GetItemInfo(self.model.diceItemId)

	if singleDiceNum <= 0  then
		local tipStr = GetDefaultText("mono_tips_01")
		GameEntry.UI:OpenMsgTipsUIForm(tipStr);
		return
	end

    if self.index == self.model.diceType.Specify then
        self.event.SpecifyStepClickEvent:Invoke(true)
    elseif self.index == self.model.diceType.Double then
        self.manager:Dice(1,self.model.doubleDiceItemId,0,self.model.diceType.Double)
    end
end

function MonopolyDiceBtn:UpdateBtn()
    if self.index == self.model.diceType.Specify then 
        self.subShopId  = self.model.specifyStepCostShopId
        self.diceItemId = self.model.specifyStepItemId
    elseif self.index == self.model.diceType.Double then
        self.subShopId  = self.model.doubleDiceCostShopId
        self.diceItemId = self.model.doubleDiceItemId
    end

    self:UpdateBtnInfo()
end

function MonopolyDiceBtn:UpdateBtnInfo()
    local diceItemName, diceItemNum =  self:GetItemInfo(self.diceItemId)
    self.BuyItemContainer.gameObject:SetActive(diceItemNum <= 0)
	self.OwnNum.text = tostring(diceItemNum)
	
	if diceItemNum <= 0 then
		self.DiceIcon.color = Color(255,255,255,0.3)
	else
		self.DiceIcon.color = Color(255,255,255,1)
	end

	local shopid = MakeJointKey(self.model.shopId,self.subShopId)
	local config = self.model:GetCommodityConfig(shopid)
	-- print(config.commodityname)

	if config == nil then 
		return
	end

	local costItemConfig = ItemConfig.GetConfig(tonumber(config.costkind))

	if costItemConfig == nil then
		print_error("costItemConfig = nil, id = ",config.costkind)
		return 
	end
	
	self.BuyItemNum.text = config.costqty

	if costItemConfig.icon_small == "" then return end

	local assetPath = string.format("Assets/GameMain/UI/UIImages/Icons/%s.png",costItemConfig.icon_small)

	LuaBridge.LoadAysnc4Lua(assetPath,typeof(CS.UnityEngine.Sprite),
	function(assetName, asset, userData)
		self.BuyItemIcon.sprite = asset
		self.BuyItemIcon.gameObject:SetActive(true)
	end,self.model.resMask)
end

function MonopolyDiceBtn:GetItemInfo(itemId)
	local itemName = ""
	local itemNum  = 0
	local config   = ItemConfig.GetConfig(itemId)

	if config == nil then
		--print_error("config = nil, itemId = ",itemId)
		return itemName,itemNum
	end

	itemName = config.name

	if itemId == 1 then
		--钻石
		itemNum = GameEntry.PlayerData.Diamond.Value
		return itemName,itemNum
	end

	local itemModel = GameEntry.PlayerData.Items:GetItemById(itemId)

	if itemModel == nil then
		--print_error("itemModel = nil",itemId)
		return itemName,itemNum
	end
	
	itemNum = itemModel.num
	return itemName,itemNum
end

function MonopolyDiceBtn:OnRelease()
	self:RemoveListeners()
end

return MonopolyDiceBtn
