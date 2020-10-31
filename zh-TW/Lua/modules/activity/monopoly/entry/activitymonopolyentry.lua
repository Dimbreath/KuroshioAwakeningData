local ActivityBase = require"Modules/Activity/ActivityBase"
local ActivityMonopolyEntry  = class("ActivityMonopolyEntry", ActivityBase)

function ActivityMonopolyEntry:OnInit(gameObject,mask)
	self.super:OnInit(gameObject,mask)
	self:InjectComponent()
	self:Init(mask)
end

function ActivityMonopolyEntry:InjectComponent()
	self.ActContent = self.injections.ActContent
	self.Time = self.injections.Time
	self.BtnGo = self.injections.BtnGo
	self.BtnRedPoint = self.injections.RedPoint
end

function ActivityMonopolyEntry:Init(mask)
	self.manager = Game:GetManager("MonopolyManager")
    self.model = self.manager:GetModel()
    self.event = self.manager:GetEvent()
	self.model.resMask = mask
	
	self.manager:GetMonopolyInfo()

    self.BtnGo.onClick:AddListener(function()
		-- if not self.model.openStatus then return end

		self.model:PlayStory("monopoly_story_start",function()
			LuaBridge.OpenUIForm(5520)
		end)
    end)
end

function ActivityMonopolyEntry:OnOpen(tagId)
	self.super:OnOpen(tagId)
	self.model.tagId = tagId
    self.model:UpdateActivityConfig()
	local config    = self.model.activityConfig
	local redPoint  = self.manager:HaveRedPoint()
	self.BtnRedPoint.gameObject:SetActive(redPoint)
	self.ActContent.text = GetDefaultText("mono_iu_08")
	-- self.Time.text = string.format( "%s--%s",config.show,config.disappear)
	self.Time.text = CS.DarkBoom.LuaActivityBridge.GetActivityTime(tagId)
end

function ActivityMonopolyEntry:RefreshUI()
   
end

function ActivityMonopolyEntry:OnRelease()
	self.BtnGo.onClick:RemoveAllListeners()
    self.BtnGo.onClick:Invoke()
end

function ActivityMonopolyEntry:SetActive(show)
    self.super:SetActive(show)
end

return ActivityMonopolyEntry
