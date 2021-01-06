local AcNewYearStagePoint  = class("AcNewYearStagePoint")

function AcNewYearStagePoint:ctor(gameObject,mask,scalex,resourceId)
   if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self.mask = mask
	self.scalex = scalex
	self.resourceId = resourceId
	self:InjectComponent()
	self:Init()
end

function AcNewYearStagePoint:InjectComponent()
	self.traSpine = self.injections.traSpine
	self.txtNameEn = self.injections.txtNameEn
	self.txtName = self.injections.txtName
	self.txtPercent = self.injections.txtPercent
	self.btnSpine = self.injections.btnSpine
end

function AcNewYearStagePoint:Init()
	self.manager  = Game:GetManager("AcNewYearManager")
	self.model    = self.manager:GetModel()
    self.event    = self.manager:GetEvent()
	self.harbourId = 0
    self.harbourInfoConfig = nil
	self.clickCallback = nil
	self.countryId = 0
	self:InitSpine()
	self:AddListeners()
end

function AcNewYearStagePoint:InitSpine()
	local spath = DarkBoom.SpineModel.GetAssetSkinPathBySkinId(self.resourceId, DarkBoom.SpineSource.None)
	if spath == nil or spath == "" then
		return
	end
	LuaBridge.LoadAysnc4Lua(spath,nil,function(assetName, asset,  userData)
		local go = GameObject.Instantiate(asset)
		go.transform:SetParent(self.btnSpine.transform)
		go.transform.localScale = Vector3(self.scalex,1,1)
		go.transform.localPosition = Vector3.zero
		go:GetComponent("RectTransform").anchoredPosition = Vector2(0,-80)
		local spine = go:AddComponent(typeof(DarkBoom.SpineModel))
		spine:PlayAnimation("Talk", true)
	end,self.mask)
end

function AcNewYearStagePoint:SetData(countryId,harbourId,harbourInfoConfig,imgCountry,clickCallback)
	self.harbourId = harbourId
    self.harbourInfoConfig = harbourInfoConfig
	self.clickCallback = clickCallback
	self.countryId = countryId
	local harbourPos = string.split(self.harbourInfoConfig.harbourpos,",")
	self.gameObject:GetComponent("RectTransform").anchoredPosition = Vector2(tonumber(harbourPos[1]),tonumber(harbourPos[2]))
	if self.countryId ~= 0 then
		self.txtNameEn.text = GetDefaultText("common_country_en_"..self.countryId)
		self.txtName.text = GetDefaultText("common_country_"..self.countryId)
		self.txtPercent.text = self.model:GetCountryProcess(self.countryId)
		-- if imgCountry ~= nil then
		-- 	DarkBoom.DarkBoomUtility.LoadCommonSprite(imgCountry,"common_1_icon_shiptatoo_10"..self.countryId,self.mask,true,function() imgCountry.gameObject:SetActive(true) end)
		-- end
	end
end


function AcNewYearStagePoint:OnRelease()
    self:RemoveListeners()
end

function AcNewYearStagePoint:AddListeners()
  
	self.btnSpine.onClick:AddListener(function()
		self:OnbtnSpineClick()
	end)

end

function AcNewYearStagePoint:RemoveListeners()
  
	self.btnSpine.onClick:RemoveAllListeners()
	self.btnSpine.onClick:Invoke()

end

function AcNewYearStagePoint:OnbtnSpineClick()
	if self.clickCallback ~= nil then
		self.clickCallback(self.harbourId,self.harbourInfoConfig)
	end
end


return AcNewYearStagePoint