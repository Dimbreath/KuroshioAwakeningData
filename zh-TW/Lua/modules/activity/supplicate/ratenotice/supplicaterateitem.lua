local SupplicateRateItem  = class("SupplicateRateItem")

function SupplicateRateItem:ctor(gameObject)
   if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:InitView()
end

function SupplicateRateItem:InjectComponent()
	self.ItemTemplate = self.injections.ItemTemplate
end

function SupplicateRateItem:InitView()
	self:AddListeners()
end

function SupplicateRateItem:SetData(data,mask)
	local datas = DarkBoomUtility.ParseRewardString(data.reward)
	
	if datas and datas.Count > 0 then 
		self.ItemTemplate:RefreshData(datas[0],mask)
		DarkBoomUtility.AddItemDetail(self.gameObject,datas[0]);
	end
end

function SupplicateRateItem:OnRelease()
    self:RemoveListeners()
end

function SupplicateRateItem:AddListeners()
  
	-- self.ItemTemplate.onClick:AddListener(function()
	-- 	self:OnItemTemplateClick()
	-- end)

end

function SupplicateRateItem:RemoveListeners()
  
	-- self.ItemTemplate.onClick:RemoveListeners()
	-- self.ItemTemplate.onClick:Invoke()

end

function SupplicateRateItem:OnItemTemplateClick()

end


return SupplicateRateItem