local AcNewYearBuffItem  = class("AcNewYearBuffItem")
local BuffConfig = require"Configs/BuffConfig"
function AcNewYearBuffItem:ctor(gameObject)
   if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
    self.gameObject = gameObject
    self.manager  = Game:GetManager("AcNewYearManager")
	self.model    = self.manager:GetModel()
    self.event    = self.manager:GetEvent()
    self:InjectComponent()
    self.buffId = 0
    self.select = false
    self.selectCallBack = nil
    self.buffConfig = nil
    self.canvasGroup = self.gameObject:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    self:AddListener()
end

function AcNewYearBuffItem:InjectComponent()
	self.imgBuffIcon = self.injections.imgBuffIcon
    self.txtDesc = self.injections.txtDesc
    self.traOurs = self.injections.traOurs
    self.txtCost = self.injections.txtCost
    self.traEnemy = self.injections.traEnemy
    self.txtDifficulty = self.injections.txtDifficulty
    self.imgSelect = self.injections.imgSelect
    self.imgLock = self.injections.imgLock
    self.btnSelect = self.injections.btnSelect
end

function AcNewYearBuffItem:AddListener()
    self.btnSelect.onClick:AddListener(function()
        if self.selectCallBack ~= nil then
            self.selectCallBack(self)
        end
    end)
end

function AcNewYearBuffItem:RemoveListener()
    self.btnSelect.onClick:RemoveAllListeners()
    self.btnSelect.onClick:Invoke()
end

function AcNewYearBuffItem:SetData(buffId,select,selectCallBack,mask)
    self.buffId = buffId
    self.selectCallBack = selectCallBack
    self.buffConfig = BuffConfig.GetConfig(self.buffId)
    if self.buffConfig == nil then
        print_error("can`t find buff config with id: "..self.buffId)
        return
    end

    -- Icon
    local assetPath = string.format("Assets/GameMain/UI/UISprites/BattleBuff/%s.png", self.buffConfig.icon)
    LuaBridge.LoadAysnc4Lua(assetPath,typeof(CS.UnityEngine.Sprite),
    function(assetName, asset, userData)
        self.imgBuffIcon.sprite = asset
        self.imgBuffIcon.gameObject:SetActive(true)
    end, mask)
    self.txtDesc.text = self.buffConfig.dec

    self.traOurs.gameObject:SetActive(false)
    self.traEnemy.gameObject:SetActive(false)
    if not self.model:IsActiveBuff(self.buffId) then
        self.canvasGroup.alpha = 0.5
        self.imgLock.gameObject:SetActive(true)
        self:SetSelect(false)
    else
        self.canvasGroup.alpha = 1
        self.imgLock.gameObject:SetActive(false)
        self:SetSelect(select)
        if self.buffConfig.target == self.model.buffType.Our then
            self.traOurs.gameObject:SetActive(true)
            self.txtCost.text = GetDefaultText("NewYear_Buff_tips_03")..self.buffConfig.value
        elseif self.buffConfig.target == self.model.buffType.Enemy then
            self.traEnemy.gameObject:SetActive(true)
            self.txtDifficulty.text = string.format("<color=#e63580>%s</color>",self.buffConfig.value)
        end
    end
end

function AcNewYearBuffItem:SetSelect(select)
    self.imgSelect.gameObject:SetActive(select)
    self.select = select
end

function AcNewYearBuffItem:IsSelect()
    return self.select
end

function AcNewYearBuffItem:GetBuffValue()
    return self.buffConfig.value
end

function AcNewYearBuffItem:GetBuffId()
    return self.buffId
end

function AcNewYearBuffItem:GetBuffConfig()
    return self.buffConfig
end

function AcNewYearBuffItem:OnRelease()
    self:RemoveListener()
end

return AcNewYearBuffItem