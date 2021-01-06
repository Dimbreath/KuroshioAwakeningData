local AcNewYearBuffForm  = class("AcNewYearBuffForm", BaseForm)
local AcNewYearBuffItem = require"Modules/Activity/NewYear/AcNewYearBuffItem"
function AcNewYearBuffForm:LUA_OnInit(gameObject,userParamData)
    self.super:LUA_OnInit(gameObject,userParamData)
	self.injections = ParseInjections(gameObject)
	self.uguiForm   = gameObject:GetComponent(typeof(CS.DarkBoom.LuaUGUIForm))
	self.mask = self.uguiForm:GetMask()
    self:InjectComponent()
    self:Init()
    self:RefreshBuffList()
end

function AcNewYearBuffForm:InjectComponent()
    self.txtTitle = self.injections.txtTitle
    self.traOurs = self.injections.traOurs
    self.txtCost = self.injections.txtCost
    self.traEnemy = self.injections.traEnemy
    self.txtDifficulty = self.injections.txtDifficulty
	self.traContent = self.injections.traContent
    self.buffItem = self.injections.buffItem
    self.btnClose = self.injections.btnClose
    self.btnEnsure = self.injections.btnEnsure
end

function AcNewYearBuffForm:Init()
	self.manager  = Game:GetManager("AcNewYearManager")
	self.model    = self.manager:GetModel()
    self.event    = self.manager:GetEvent()
    self.showBuffList = {}
    self.isEnemy = false
    self.buffItemList = {}
    self.buffValue = 0
    self.maxBuffCost = self.model:GetMaxBuffCost()
    self:AddListeners()
end

function AcNewYearBuffForm:LUA_OnOpen(userData)
    self.isEnemy = userData.isEnemy
    if self.isEnemy then
        self.showBuffList = self.model:GetEnemyBuffList()
        self.txtTitle.text = GetDefaultText("NewYear_Buff_tips_01")
    else
        self.showBuffList = self.model:GetOurBuffList()
        self.txtTitle.text = GetDefaultText("NewYear_Buff_tips_02")
    end
    self.traOurs.gameObject:SetActive(not self.isEnemy)
    self.traEnemy.gameObject:SetActive(self.isEnemy)
    self:RefreshBuffList()
    self:RefreshBuffValue()
end

function AcNewYearBuffForm:RefreshBuffList()
    for k,v in pairs(self.showBuffList) do
        local go = GameObject.Instantiate(self.buffItem.gameObject,self.traContent.transform)
        go:SetActive(true)
        go.transform.localScale = Vector3.one
        local buffItem = AcNewYearBuffItem.new(go)
        local isSelect = self.model:IsSelectBuff(v)
        buffItem:SetData(v,isSelect,function(item) self:OnSelectBuff(item) end,self.mask)
        self.buffItemList[v] = buffItem
        if isSelect then
            self.buffValue = self.buffValue + buffItem:GetBuffValue()
        end
    end
end

function AcNewYearBuffForm:OnSelectBuff(buffItem)
    local select = buffItem:IsSelect()
    select = not select
    local buffValue = buffItem:GetBuffValue()
    if not select then
        buffValue = 0 - buffValue
    end
    if self.isEnemy then
        self.buffValue = self.buffValue + buffValue
    else
        if self.buffValue + buffValue > self.maxBuffCost then
            GameEntry.UI:OpenMsgTipsUIFormWithKey("newyear_coin_lose")
            return
        else
            self.buffValue = self.buffValue + buffValue
        end
    end
    self:RefreshBuffValue()
    buffItem:SetSelect(select)
end

function AcNewYearBuffForm:RefreshBuffValue()
    if self.isEnemy then
        self.txtDifficulty.text = GetDefaultText("NewYear_Port_tips_01")..string.format("<color=#e63580>  %s</color>",self.buffValue)
    else
        self.txtCost.text = GetDefaultText("NewYear_Buff_tips_03")..string.format("<color=#00ffff>%s</color>",self.buffValue).."/"..self.maxBuffCost
    end
end

function AcNewYearBuffForm:OnEnsureBuff()
    local selectBuffList = {}
    for k,v in pairs(self.buffItemList) do
        if v:IsSelect() then
            table.insert(selectBuffList,v:GetBuffId())
        end
    end
    self.model:AddSelectBuff(selectBuffList,self.isEnemy)
    self.event.RefreshBuff:Invoke()
    self:OnClose(self.uguiForm)
end

function AcNewYearBuffForm:AddListeners()
	self.btnClose.onClick:AddListener(function()
		self:OnClose(self.uguiForm)
    end)
    self.btnEnsure.onClick:AddListener(function()
        self:OnEnsureBuff()
    end)
end

function AcNewYearBuffForm:RemoveListeners()
	self.btnClose.onClick:RemoveAllListeners()
	self.btnClose.onClick:Invoke()
end

function AcNewYearBuffForm:LUA_OnClose()
    for k,v in pairs(self.buffItemList) do
        v:OnRelease()
    end
    self.buffItemList = {}
    self:RemoveListeners()
end

return AcNewYearBuffForm