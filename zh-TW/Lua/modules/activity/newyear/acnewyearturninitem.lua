local AcNewYearTurnInItem  = class("AcNewYearTurnInItem")
local ItemConfig = require("Configs/ItemConfig")
function AcNewYearTurnInItem:ctor(gameObject)
   if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
    self:InjectComponent()
end

function AcNewYearTurnInItem:InjectComponent()
	self.imgResIcon = self.injections.imgResIcon
	self.txtResNum = self.injections.txtResNum
end

function AcNewYearTurnInItem:SetData(itemId,mask)
    local itemModel = GameEntry.PlayerData.Items:GetItemById(itemId)
    local num = 0
    if itemModel ~= nil then
        num = itemModel.num
    end
    self.txtResNum.text = num

    local itemConfig = ItemConfig.GetConfig(itemId)
    if itemConfig ~= nil then
        local iconName = itemConfig.icon_small
        DarkBoom.DarkBoomUtility.LoadIconSprite(self.imgResIcon,iconName,mask,false,function() self.imgResIcon.gameObject:SetActive(true) end)
    end
end

function AcNewYearTurnInItem:OnRelease()
    
end

return AcNewYearTurnInItem