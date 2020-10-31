local ActivityDelicious  = class("ActivityDelicious")

function ActivityDelicious:OnInit(gameObject,mask)
	self.injections = ParseInjections(gameObject)
    self.mask = mask
	self.gameObject = gameObject
	
	self:InjectComponent()
	self:Init(mask)
end

function ActivityDelicious:InjectComponent()
	self.BtnGo = self.injections.BtnGo
end

function ActivityDelicious:Init(mask)
    self.BtnGo.onClick:AddListener(function()
		LuaBridge.TranslateBySourceId(62)
    end)
end

function ActivityDelicious:OnOpen(tagId)
	self.tagId = tagId
end

function ActivityDelicious:RefreshUI()
   
end

function ActivityDelicious:OnRelease()
	self.BtnGo.onClick:RemoveAllListeners()
	self.BtnGo.onClick:Invoke()
	
	self.injections = {}
	self.injections = nil
end

function ActivityDelicious:SetActive(show)
	self.gameObject:SetActive(show);
end

return ActivityDelicious
