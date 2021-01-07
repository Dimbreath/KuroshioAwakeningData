local AcNewYearMoralePayItem  = class("AcNewYearMoralePayItem")
local AcNewYearPersistentPress = require"Modules/Activity/NewYear/MoralePay/AcNewYearPersistentPress"

function AcNewYearMoralePayItem:ctor(gameObject)
   if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:Init()
end

function AcNewYearMoralePayItem:InjectComponent()
	self.MinBtn = self.injections.MinBtn	
	self.AddBtn = self.injections.AddBtn
	self.SubBtn = self.injections.SubBtn
	self.MaxBtn = self.injections.MaxBtn
	self.MaxNum = self.injections.MaxNum
	self.InputField = self.injections.InputField
	self.ItemCell = self.injections.ItemCell
	self.curPayNum = 0
	self.maxPayNum = 0
end

function AcNewYearMoralePayItem:Init()
	self.manager = Game:GetManager("AcNewYearManager")
	self.model = self.manager:GetModel()
	self.event = self.manager:GetEvent()
	self.addBtnPress = AcNewYearPersistentPress.new(self.AddBtn)
	self.subBtnPress = AcNewYearPersistentPress.new(self.SubBtn)
	self.addBtnPress:SetPressFunc(function()
        self:OnAddBtnPress()
    end)	
	self.subBtnPress:SetPressFunc(function()
        self:OnSubBtnPress()
    end)	
	self:AddListeners()
end

function AcNewYearMoralePayItem:AddListeners()
	self.MinBtn.onClick:AddListener(function()
		self:OnMinBtnClick()
	end)
	self.AddBtn.onClick:AddListener(function()
		self:OnAddBtnClick()
	end)
	self.SubBtn.onClick:AddListener(function()
		self:OnSubBtnClick()
	end)
	self.MaxBtn.onClick:AddListener(function()
		self:OnMaxBtnClick()
	end)	
	self.InputField.onValueChanged:AddListener(function(value)
		self:OnPayInputValueChange(value)
	end)
end

function AcNewYearMoralePayItem:OnAddBtnPress()
	DarkBoomUtility.PlayClick(DarkBoom.SoundEffectType.Add)
	self:OnAddBtnClick()
end

function AcNewYearMoralePayItem:OnSubBtnPress()
	DarkBoomUtility.PlayClick(DarkBoom.SoundEffectType.Close)
	self:OnSubBtnClick()
end

function AcNewYearMoralePayItem:OnMinBtnClick()
	self.curPayNum = 0
	self:UpdatePayNum()
end

function AcNewYearMoralePayItem:OnAddBtnClick()
	if self.curPayNum < self.maxPayNum then
	   self.curPayNum = self.curPayNum + 1
	   self:UpdatePayNum()
	else
	   DarkBoom.GameEntry.UI:OpenMsgTipsUIForm(DarkBoom.GameEntry.Localization:GetString("buy_tips_max"))
	end
end

function AcNewYearMoralePayItem:OnSubBtnClick()
	if self.curPayNum >= 1 then
	   self.curPayNum = self.curPayNum - 1
	   self:UpdatePayNum()
	else
	   DarkBoom.GameEntry.UI:OpenMsgTipsUIForm(DarkBoom.GameEntry.Localization:GetString("buy_tips_min"))
	end
end

function AcNewYearMoralePayItem:OnMaxBtnClick()
	self.curPayNum = self.maxPayNum
	self:UpdatePayNum()
end

function AcNewYearMoralePayItem:OnPayInputValueChange(value)
	local inputV = DarkBoomUtility.TryIntParse(value)
	self.curPayNum = CS.UnityEngine.Mathf.Clamp(inputV,0,self.maxPayNum) 
	self.event.MoralePayBtnSateRefresh:Invoke(true)
end

function AcNewYearMoralePayItem:UpdatePayNum()	
	self.curPayNum = CS.UnityEngine.Mathf.CeilToInt(self.curPayNum)
	self.InputField.text = self.curPayNum
end

function AcNewYearMoralePayItem:UpdateItem(itemId)
	self.itemId = itemId
    local itemNum = self.model:GetItemInfo(itemId)    
    self.ItemCell:RefreshDataLua(self.itemId,itemNum,1,self.model.moralePayFormMask)
    self.ItemCell:SetItemSize(DarkBoom.ItemSize.Size_0_7)
    DarkBoomUtility.AddItemDetail(self.ItemCell.gameObject, itemId, DarkBoom.ItemCellType.Item)
    self:SetMaxPayNum(itemNum)
    self.MaxNum.text = '/'..self.maxPayNum 
    self.InputField.text = self.curPayNum
end

function AcNewYearMoralePayItem:SetMaxPayNum(itemRealNum)
	if self.model.resItemMaxPayNum < itemRealNum then
    	self.maxPayNum = self.model.resItemMaxPayNum
    else
		self.maxPayNum = itemRealNum
    end
end

function AcNewYearMoralePayItem:ResetItem()
	self.curPayNum = 0
	local itemNum = self.model:GetItemInfo(self.itemId)	     	
	self.ItemCell:RefreshDataLua(self.itemId,itemNum,1,self.model.moralePayFormMask)
	self:SetMaxPayNum(itemNum)
	self.MaxNum.text = '/'..self.maxPayNum 
	self.InputField.text = self.curPayNum
end

function AcNewYearMoralePayItem:RemoveListeners()
	self.MinBtn.onClick:RemoveAllListeners()
	self.MinBtn.onClick:Invoke()

	self.AddBtn.onClick:RemoveAllListeners()
	self.AddBtn.onClick:Invoke()

	self.SubBtn.onClick:RemoveAllListeners()
	self.SubBtn.onClick:Invoke()

	self.MaxBtn.onClick:RemoveAllListeners()
	self.MaxBtn.onClick:Invoke()

	self.InputField.onValueChanged:RemoveAllListeners()
	self.InputField.onValueChanged:Invoke()
end


function AcNewYearMoralePayItem:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
	self.addBtnPress:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
	self.subBtnPress:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
end

function AcNewYearMoralePayItem:OnRelease()
	self.injections = {}
    self.injections = nil
	self:RemoveListeners()
	self.addBtnPress:OnRelease()
	self.subBtnPress:OnRelease()

	self.MinBtn = nil
	self.AddBtn = nil
	self.SubBtn = nil
	self.MaxBtn = nil
	self.MaxNum = nil
	self.InputField = nil
	self.ItemCell = nil

	self.manager = nil
	self.model = nil
	self.event = nil	
end

return AcNewYearMoralePayItem
