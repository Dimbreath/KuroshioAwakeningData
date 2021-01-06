local AcNewYearBuffComponentItem  = class("AcNewYearBuffComponentItem")
local BuffConfig = require "Configs/BuffConfig"

function AcNewYearBuffComponentItem:ctor(gameObject)
	self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:InitView()
end

function AcNewYearBuffComponentItem:InjectComponent()
	self.Icon = self.injections.Icon
	self.CanvasGroup = self.injections.CanvasGroup
end

function AcNewYearBuffComponentItem:InitView()
	
end

function AcNewYearBuffComponentItem:OnRelease()
    
end

function AcNewYearBuffComponentItem:SetData(config, mask, contain)
    -- Icon
    local assetPath = string.format("Assets/GameMain/UI/UISprites/BattleBuff/%s.png",config.icon)
            LuaBridge.LoadAysnc4Lua(assetPath,typeof(CS.UnityEngine.Sprite),
	        function(assetName, asset, userData)
		        self.Icon.sprite = asset
		        self.Icon.gameObject:SetActive(true)
	        end, mask)

	 if contain then
	 	self.CanvasGroup.alpha = 1
	 else
	 	self.CanvasGroup.alpha = 0.4
	 end

end

return AcNewYearBuffComponentItem
