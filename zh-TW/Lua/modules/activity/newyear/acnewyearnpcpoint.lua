local AcNewYearNpcPoint  = class("AcNewYearNpcPoint")
local VoiceTxtCfgConfig = require"Configs/VoiceTxtCfgConfig"
function AcNewYearNpcPoint:ctor(gameObject,mask)
   if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self.mask = mask
	self:InjectComponent()
	self:Init()
end

function AcNewYearNpcPoint:InjectComponent()
	self.btnLevelPoint = self.injections.btnLevelPoint
	self.aniDialog = self.injections.aniDialog
	self.txtVoice = self.injections.txtVoice
	self.imgHead = self.injections.imgHead
	self.traDialog = self.injections.traDialog
end

function AcNewYearNpcPoint:Init()
	self.manager  = Game:GetManager("AcNewYearManager")
	self.model    = self.manager:GetModel()
	self.event    = self.manager:GetEvent()
	self.isShowText = false
	self:AddListeners()
end

function AcNewYearNpcPoint:SetData(boatId,newYearMapConfig)
	self.boatId = boatId
	self.newYearMapConfig = newYearMapConfig
	local coordinate = string.split(self.newYearMapConfig.coordinate,",")
	self.gameObject:GetComponent("RectTransform").anchoredPosition = Vector2(tonumber(coordinate[1]),tonumber(coordinate[2]))
	local resourceId = DarkBoom.BoatAssetUtility.GetDefaultResourceIdByReceId(self.boatId)
	local iconName = GameEntry.PreResourceManager.charactersConfig:GetIconName(resourceId)
	DarkBoom.DarkBoomUtility.LoadIconSprite(self.imgHead,iconName, self.mask, false, function() self.imgHead:SetAlpha(1) end)
	self.traDialog.alpha = 0
end

function AcNewYearNpcPoint:OnRelease()
    self:RemoveListeners()
end

function AcNewYearNpcPoint:AddListeners()
  
	self.btnLevelPoint.onClick:AddListener(function()
		self:OnbtnLevelPointClick()
	end)

end

function AcNewYearNpcPoint:RemoveListeners()
  
	self.btnLevelPoint.onClick:RemoveAllListeners()
	self.btnLevelPoint.onClick:Invoke()

end

function AcNewYearNpcPoint:OnbtnLevelPointClick()
	if self.model.reward_npc ~= 0 then
		local weight = self.newYearMapConfig.weight
		local random = math.random(1,100)
		if random <= weight then
			self.manager:ReqRewardNpc()
		end
	end
	self:ShowVoiceText()
end

function AcNewYearNpcPoint:ShowVoiceText()
	if self.isShowText then return end
	local voiceTxtCfg = VoiceTxtCfgConfig.GetConfig(self.newYearMapConfig.voicetxt)
	if voiceTxtCfg ~= nil then
		self.isShowText = true
		self.traDialog.alpha = 1
		self:PlayTextAni("Overview_dialog_show")	
		self.txtVoice.text = voiceTxtCfg.words
		CS.DG.Tweening.DOVirtual.DelayedCall(2,
		function() 
			self:PlayTextAni("Overview_dialog_hide") 
			self.isShowText = false
		end)
	end
end

function AcNewYearNpcPoint:PlayTextAni(name)
	local state = self.aniDialog:get_Item(name)
	state.time = 0
	state.speed = 1
	print(state.name)
	self.aniDialog:Play(state.name)
end

return AcNewYearNpcPoint