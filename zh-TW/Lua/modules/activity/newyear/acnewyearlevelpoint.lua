local AcNewYearLevelPoint = class("AcNewYearLevelPoint")

function AcNewYearLevelPoint:ctor(gameObject)
    if IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:Init()
end

function AcNewYearLevelPoint:InjectComponent()
    self.btnLevelPoint = self.injections.btnLevelPoint
    self.txtName = self.injections.txtName
    self.imgBattle = self.injections.imgBattle
    self.imgStory = self.injections.imgStory
    self.imgIcon1 = self.injections.imgIcon1
    self.imgIcon2 = self.injections.imgIcon2
    self.imgIcon3 = self.injections.imgIcon3
    self.txtBattleEn = self.injections.txtBattleEn
    self.txtStoryEn = self.injections.txtStoryEn
    self.imgLock = self.injections.imgLock
end

function AcNewYearLevelPoint:Init()
	self.manager  = Game:GetManager("AcNewYearManager")
	self.model    = self.manager:GetModel()
    self.event    = self.manager:GetEvent()
    self.harbourId = 0
    self.harbourInfoConfig = nil
    self.clickCallback = nil
    self:AddListeners()
end

function AcNewYearLevelPoint:SetData(harbourId,harbourInfoConfig,clickCallback)
    self.harbourId = harbourId
    self.harbourInfoConfig = harbourInfoConfig
    self.clickCallback = clickCallback
    local harbourPos = string.split(self.harbourInfoConfig.harbourpos,",")
    self.gameObject:GetComponent("RectTransform").anchoredPosition = Vector2(tonumber(harbourPos[1]),tonumber(harbourPos[2]))
    self.txtName.text = self.harbourInfoConfig.name
    self:RefreshStatus()
end

function AcNewYearLevelPoint:SetActive(show)
    self.gameObject:SetActive(show)
end

function AcNewYearLevelPoint:IsActive()
    return self.gameObject.activeSelf
end

function AcNewYearLevelPoint:RefreshStatus()
    local status = self.model:GetHarbourStatus(self.harbourId)
    self.imgIcon1.gameObject:SetActive(status == self.model.harbourStatus.Open)
    self.imgIcon2.gameObject:SetActive(status == self.model.harbourStatus.Clear)
    self.imgIcon3.gameObject:SetActive(status == self.model.harbourStatus.Lock)
    self.txtBattleEn.gameObject:SetActive(self.harbourInfoConfig.type ~= self.model.harbourType.Story)
    self.txtStoryEn.gameObject:SetActive(self.harbourInfoConfig.type == self.model.harbourType.Story)
    self.imgLock.gameObject:SetActive(status == self.model.harbourStatus.Lock)
    self.imgBattle.gameObject:SetActive(self.harbourInfoConfig.type ~= self.model.harbourType.Story and status ~= self.model.harbourStatus.Lock)
    self.imgStory.gameObject:SetActive(self.harbourInfoConfig.type == self.model.harbourType.Story and status ~= self.model.harbourStatus.Lock )
    if status == self.model.harbourStatus.Lock then
		self.gameObject.transform:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 0.6
	else
		self.gameObject.transform:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1
	end
end

function AcNewYearLevelPoint:AddListeners()
	self.btnLevelPoint.onClick:AddListener(function()
        if self.clickCallback ~= nil then
            self.clickCallback(self.harbourId,self.harbourInfoConfig)
        end
	end)
end

function AcNewYearLevelPoint:RemoveListeners()
	self.btnLevelPoint.onClick:RemoveAllListeners()
	self.btnLevelPoint.onClick:Invoke()
end

function AcNewYearLevelPoint:OnRelease()
    self:RemoveListeners()
end


return AcNewYearLevelPoint