local ActivityBase = require"Modules/Activity/ActivityBase"
local AcNewYearEntry  = class("AcNewYearEntry")

function AcNewYearEntry:OnInit(gameObject,mask)
    self.mask = mask
	self.gameObject = gameObject
	self.injections = ParseInjections(gameObject)
	self:InjectComponent()
	self:Init()
end

function AcNewYearEntry:InjectComponent()
	self.btnGo = self.injections.btnGo
	self.txtDesc = self.injections.txtDesc
	self.txtTime = self.injections.txtTime
end

function AcNewYearEntry:Init()
	self.manager  = Game:GetManager("AcNewYearManager")
	self.model    = self.manager:GetModel()
	self.event    = self.manager:GetEvent()
	self.tagId = 0
	self:AddListeners()
end

function AcNewYearEntry:OnRelease()
    self:RemoveListeners()
end

function AcNewYearEntry:AddListeners()
  
	self.btnGo.onClick:AddListener(function()
		self:OnbtnGoClick()
	end)

end

function AcNewYearEntry:RemoveListeners()
  
	self.btnGo.onClick:RemoveAllListeners()
	self.btnGo.onClick:Invoke()

end

function AcNewYearEntry:OnbtnGoClick()
    local id = 0
    local activityConfig = DarkBoom.ActivitiesMgr.GetInstance():GetActivityConfigData(self.tagId)
	if activityConfig ~= nil then
		if DarkBoom.ActivityExtension.IsActivityInTime(activityConfig,DarkBoom.ActivityTimeType.Start,DarkBoom.ActivityTimeType.Disapper) then
			id = tonumber(activityConfig.parameter_2)
			local _,continentalConfig = CS.Config.WorldIntercontinentalCfgList.getInst():TryGetValue(id)
			if continentalConfig ~= nil and DarkBoom.CondiUtility.CheckCondition(continentalConfig.Precondi,nil,true) then				
				CS.DarkBoom.WorldMapUtility.GoToWorldMap(id)
			end	
		else
			GameEntry.UI:OpenMsgTipsUIFormWithKey("activity_map_tips_01")
		end
	else
		GameEntry.UI:OpenMsgTipsUIFormWithKey("activity_map_tips_01")
    end
    
end


function AcNewYearEntry:OnOpen(tagId)
	self.tagId = tagId
	self.txtTime.text = CS.DarkBoom.LuaActivityBridge.GetActivityTime(78)
	--self.txtDesc.text = GetDefaultText("newyear_activity_dec")
end

function AcNewYearEntry:RefreshUI()
   
end

function AcNewYearEntry:SetActive(show)
	self.gameObject:SetActive(show)
end

return AcNewYearEntry
