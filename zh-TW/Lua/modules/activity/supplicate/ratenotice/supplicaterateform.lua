local SupplicateRateForm  = class("SupplicateRateForm", BaseForm)
local LottoRewardConfig   = require"Configs/LottoRewardConfig"
local SupplicateRateItem  = require"Modules/Activity/Supplicate/RateNotice/SupplicateRateItem"

local DarkBoomUtility = DarkBoomUtility
function SupplicateRateForm:LUA_OnInit(gameObject,userParamData)
	self.super:LUA_OnInit(gameObject,userParamData)
	self:InjectComponent()
    self:Init()
end

function SupplicateRateForm:InjectComponent()
	self.ItemPrefab = self.injections.ItemPrefab
	self.SpecialContainer = self.injections.SpecialContainer
	self.NormalContainer = self.injections.NormalContainer
	self.CloseButton = self.injections.CloseButton
end

function SupplicateRateForm:LUA_OnOpen(userData)
	self.configs = {}
	for i,v in ipairs(LottoRewardConfig) do
		local config = LottoRewardConfig.GetConfig(i)
		local itemType = config.type

		if not self.configs[itemType] then
			self.configs[itemType] = {}
		end
		
		table.insert( self.configs[itemType],config)
	end

	local mask = self:GetMask()

	for i,v in ipairs(self.configs) do
		for _,k in ipairs(v) do
			local go = nil
			if i == 1 then 
				go = GameObject.Instantiate(self.ItemPrefab.gameObject,self.SpecialContainer.transform)
			else
				go = GameObject.Instantiate(self.ItemPrefab.gameObject,self.NormalContainer.transform)
			end
			
			go.gameObject:SetActive(true)
			local item = SupplicateRateItem.new(go)
			item:SetData(k,mask)
		end
	end

	DarkBoomUtility.ToBlur(self.uguiForm.UIForm);
end

function SupplicateRateForm:Init()
	self:AddListeners()
end

function SupplicateRateForm:LUA_OnClose()
	self:RemoveListeners()
	self.configs = {}
	self.configs = nil
	DarkBoomUtility.RegainBlur(self.uguiForm.UIForm);
end

function SupplicateRateForm:AddListeners()
  
	self.CloseButton.onClick:AddListener(function()
		self:OnCloseButtonClick()
	end)

end

function SupplicateRateForm:RemoveListeners()
  
	self.CloseButton.onClick:RemoveAllListeners()
	self.CloseButton.onClick:Invoke()

end

function SupplicateRateForm:OnCloseButtonClick()
	self:OnClose()
end

return SupplicateRateForm