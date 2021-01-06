local AcNewYearBuffComponent  = class("AcNewYearBuffComponent")
local AcNewYearBuffComponentItem = require"Modules/Activity/NewYear/AcNewYearBuffComponentItem"
local BuffConfig = require "Configs/BuffConfig"
local TableHelper = require "Core/TableHelper"

function AcNewYearBuffComponent:ctor(gameObject)
	if self.gameObject == nil then
		self.injections = ParseInjections(gameObject)
		self.gameObject = gameObject
		self:InjectComponent()
	end
end

function AcNewYearBuffComponent:LUA_Init(gameObject)
	if self.gameObject == nil then
		self.injections = ParseInjections(gameObject)
		self.gameObject = gameObject
		self:InjectComponent()
	end
end

function AcNewYearBuffComponent:InjectComponent()
	self.Title = self.injections.Title
	self.EditBtn = self.injections.EditBtn
	self.LeftBtn = self.injections.LeftBtn
	self.RightBtn = self.injections.RightBtn
	self.ScrollList = self.injections.ScrollList
	self.ItemTemplate = self.injections.ItemTemplate
	self.manager  = Game:GetManager("AcNewYearManager")
	self.model    = self.manager:GetModel()
	self.event    = self.manager:GetEvent()
end

function AcNewYearBuffComponent:LUA_SetData(mask)
	self.manager  = Game:GetManager("AcNewYearManager")
	self.model    = self.manager:GetModel()
	self.event    = self.manager:GetEvent()
	self.AllBuffs = {}
	self:AddListeners()
	if self.model.isOwnBuff then
		self:SetBuffData(self.model.buffType.Our, mask)
	else
		self:SetBuffData(self.model.buffType.Enemy, mask)
	end
end

function AcNewYearBuffComponent:LUA_Destroy()
    self:RemoveListeners()
end

function AcNewYearBuffComponent:AddListeners()
  
	self.EditBtn.onClick:AddListener(function()
		self:OnEditBtnClick()
	end)
  
	self.LeftBtn.onClick:AddListener(function()
		self:OnLeftBtnClick()
	end)
  
	self.RightBtn.onClick:AddListener(function()
		self:OnRightBtnClick()
	end)
	self.event.RefreshBuff:AddListener(self.RefreshView,self)
end

function AcNewYearBuffComponent:RemoveListeners()
  
	self.EditBtn.onClick:RemoveAllListeners()
	self.EditBtn.onClick:Invoke()
  
	self.LeftBtn.onClick:RemoveAllListeners()
	self.LeftBtn.onClick:Invoke()
  
	self.RightBtn.onClick:RemoveAllListeners()
	self.RightBtn.onClick:Invoke()
	self.event.RefreshBuff:RemoveListener(self.RefreshView,self)
end

function AcNewYearBuffComponent:OnEditBtnClick()
	local userData = {}
    userData.isEnemy = self.IsEnemy
	LuaBridge.OpenUIForm(7077, userData)
end

function AcNewYearBuffComponent:OnLeftBtnClick()
	self.ScrollList:LeftMoveCellPos()
end

function AcNewYearBuffComponent:OnRightBtnClick()
	self.ScrollList:RightMoveCellPos()
end


function AcNewYearBuffComponent:OnOpen(tagId)

end

function AcNewYearBuffComponent:RefreshUI()
   
end

function AcNewYearBuffComponent:SetActive(show)

end

function AcNewYearBuffComponent:SetBuffData(target, mask)
	self.Mask = mask
    self.IsEnemy = target ~= self.model.buffType.Our
    self.AllBuffs = {}

    local buffIds = {}
    if self.IsEnemy then
    	buffIds = self.model:GetEnemyBuffList()
    else
    	buffIds = self.model:GetOurBuffList()
    end

    for k,v in pairs(buffIds) do    	
		local config = BuffConfig.GetConfig(v)
    	table.insert(self.AllBuffs, config)
    end

    self:RefreshView()
end

function AcNewYearBuffComponent:RefreshView()
	self:SetBaseInfo()
    self:InitScrollList()
end

-- 设置信息
function AcNewYearBuffComponent:SetBaseInfo()
	if self.IsEnemy then
		self.Title.text = string.format(GetDefaultText("NewYear_Port_tips_01").."  %s", self.model:GetBuffValue(self.IsEnemy))
	else
		self.Title.text = GetDefaultText("NewYear_Buff_tips_02")
	end
end

function AcNewYearBuffComponent:InitScrollList()

	local OnRenderBuffItem = function(index, child)
        local buffItem = AcNewYearBuffComponentItem.new(child)
        local config  = self.AllBuffs[index + 1]

        local contain = self.model:IsSelectBuff(config.id)

        buffItem:SetData(config, self.Mask, contain)
    end

	self.ScrollList.Child = self.ItemTemplate.gameObject
	self.ScrollList.MaxPerLine = 1
	--self.ScrollList.columuSpace = 10
	self.ScrollList.ChildCount = TableLength(self.AllBuffs)
	self.ScrollList.onItemRender = OnRenderBuffItem
	self.ScrollList:ReBuild()
end



return AcNewYearBuffComponent
