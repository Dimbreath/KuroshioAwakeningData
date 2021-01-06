local AcNewYearLevelForm  = class("AcNewYearLevelForm", BaseForm)
local AcNewYearBuffComponent = require"Modules/Activity/NewYear/AcNewYearBuffComponent"

function AcNewYearLevelForm:LUA_OnInit(gameObject,userParamData)
	self.super:LUA_OnInit(gameObject,userParamData)
	self.injections = ParseInjections(gameObject)
	self.uguiForm   = gameObject:GetComponent(typeof(CS.DarkBoom.LuaUGUIForm))
	self.mask = self.uguiForm:GetMask()
	self:InjectComponent()
    self:Init()
end

function AcNewYearLevelForm:InjectComponent()
	self.btnBg = self.injections.btnBg
	self.btnGo = self.injections.btnGo
	self.harbourDescComponent = self.injections.harbourDescComponent
	self.enemyStageComponent = self.injections.enemyStageComponent
	self.harbourRewardComponent = self.injections.harbourRewardComponent
	self.traBattlePanel = self.injections.activityBattleLevelPanel
	self.traStoryPanel = self.injections.activityStoryLevelPanel
	self.activityHarbourNoBattleForm = self.injections.activityHarbourNoBattleForm
	self.resourceBase = self.injections.resourceBase
	self.harbourBuffComponent = self.injections.HarbourBuffComponent
	self.traOpenCon2 = self.injections.traOpenCon2
	self.traOpenCon = self.injections.traOpenCon
	self.traBtns = self.injections.traBtns
	self.txtOpenConText = self.injections.txtOpenConText
end

function AcNewYearLevelForm:LUA_OnOpen(userData)
	self.harbourId = userData.harbourId
	self.harbourInfoConfig = userData.harbourInfoConfig
	self.teamId = self.model:GetTeamIdByBattleType(self.harbourId,self.model.battleType.Normal)
	self.model.isOwnBuff = false
	self.model.harbourId = self.harbourId
	if self.harbourInfoConfig.type == self.model.harbourType.Story then
		self:RefreshStoryView()
	else
		self:RefreshBattleView()
		local buffComponent = AcNewYearBuffComponent.new(self.harbourBuffComponent.gameObject)
		buffComponent:LUA_SetData(self.mask)
	end
end

function AcNewYearLevelForm:Init()
	self.manager  = Game:GetManager("AcNewYearManager")
	self.model    = self.manager:GetModel()
	self.event    = self.manager:GetEvent()
	self.difficultyId = -1
	self:AddListeners() 
end

function AcNewYearLevelForm:RefreshBattleView()
	self.traBattlePanel.gameObject:SetActive(true)
	self.traStoryPanel.gameObject:SetActive(false)
	self.harbourDescComponent:SetData(self.harbourId)
	self:RefreshDifficultyInfo()
	self:UpdateLockState()
end

function AcNewYearLevelForm:RefreshDifficultyInfo()
	local curDifficultyId = self.model:GetBuffValue(true)
	if self.difficultyId == curDifficultyId then
		return
	end
	self.difficultyId = curDifficultyId
	-- 生成敌人信息（如果可以，希望有生之年看到好心人把这段代码改成通用）
	local battleYearNewConfig = self.model:GetNewYearHarbour(self.harbourId,self.difficultyId)
	if battleYearNewConfig == nil then return end
	local monstersList = DarkBoom.CounterAttackUtility.GetBattleMonstersList(battleYearNewConfig.battleid, nil)
	local enemyStageData = {}
	for k,v in pairs(monstersList) do
		enemyStageData[k + 1] = self:SetUIStageData(k + 1, v)
	end
	self.enemyStageComponent:GetData().stageList = enemyStageData
	self.enemyStageComponent:GetData().mask = self.mask
	self.enemyStageComponent:Open()

	-- 生成奖励信息
	local isClear = self.model:IsHarbourClear(self.harbourId,self.difficultyId)
	local rewardStr = battleYearNewConfig.dropshow
	if isClear then
		rewardStr = battleYearNewConfig.salvagedropshow
	end
	self.harbourRewardComponent:SetData(self.mask, DarkBoom.DarkBoomUtility.ParseRewardString(rewardStr), GameEntry.Localization:GetString("occupy_harbourInfo_12"))

	local parameter = DarkBoom.CommonSidebarExtraParameter()
	parameter.areaExtraNumber = self.harbourId
	parameter.areaExtraParam = battleYearNewConfig.battleid
	self.resourceBase:SetResource(parameter)
end

function AcNewYearLevelForm:UpdateLockState()
	local status = self.model:GetHarbourStatus(self.harbourId)
	self.traBtns.gameObject:SetActive(status ~= self.model.harbourStatus.Lock)
	if status == self.model.harbourStatus.Lock then
		local unlocktexts = {}
		local precondi = self.harbourInfoConfig.precondi
		for i,v in ipairs(precondi) do
			table.insert(unlocktexts,DarkBoom.CondiUtility.GetSingleCindiTips(v))
		end
		self.traOpenCon2.gameObject:SetActive(#unlocktexts > 1)
		self.traOpenCon.gameObject:SetActive(#unlocktexts == 1)
		if #unlocktexts == 1 then
			self.txtOpenConText.text = unlocktexts[1]
		elseif #unlocktexts > 1 then
			local list = self.traOpenCon2.transform:GetChildComponents(typeof(CS.UnityEngine.RectTransform))
			local index = 1
			for k,v in pairs(list) do
				v:GetChild(0):GetComponent(typeof(CS.UnityEngine.UI.Text)).text = unlocktexts[index]
				index = index + 1
			end
		end
	else
		self.traOpenCon2.gameObject:SetActive(false)
		self.traOpenCon.gameObject:SetActive(false)
	end
end

function AcNewYearLevelForm:RefreshStoryView()
	self.traBattlePanel.gameObject:SetActive(false)
	self.traStoryPanel.gameObject:SetActive(true)
	self.activityHarbourNoBattleForm:Init(nil)
	self.activityHarbourNoBattleForm:Open(self.harbourId,self.mask)
end

function AcNewYearLevelForm:GetProItems(allItems,isClear)
	local list = {}
	local info = self.harbourInfoConfig
	local dolls = info.Specialcommondoll
	if isClear then
		dolls = info.Specialfirstdoll
	end
	local dollList = {}
	for k,v in pairs(dolls or {}) do
		local data = DarkBoom.ItemCellData(v)
		dollList[data.id] = true
	end

	for k,v in pairs(allItems) do
		local wmItem = DarkBoom.WorldMapItemData(v.id, v.num, v.itemCellType, v.isGetted,v.maxNum)
		wmItem.IsSpecial = dollList[v.id] or false
		table.insert(list,wmItem)
	end

	return list
end

function AcNewYearLevelForm:SetUIStageData(stage, enemyList)
	local stageTemp = {}
	stageTemp.enemyList = {}
	for k,v in pairs(enemyList) do
		stageTemp.title = self:GetStageString(stage)
		stageTemp.enemyList[k + 1] = self:SetUIEnemyData(v)
	end
	return stageTemp
end

function AcNewYearLevelForm:GetStageString(index)
	local result = ""
	if index == 1 then
			result = "map_enemy_round_01"
	elseif index == 2 then
			result = "map_enemy_round_02"
	elseif index == 3 then
			result = "map_enemy_round_03"
	end
	if not string.IsNullOrEmpty(result) then
		result = GameEntry.Localization:GetString(result)
	end
	return result;
end

function AcNewYearLevelForm:SetUIEnemyData(data)
	local enemyTemp = {}
	enemyTemp.level = data.lvl
	enemyTemp.id = data.monster.Id
	return enemyTemp
end

function AcNewYearLevelForm:LUA_OnClose()
	self.event.OpenLevelForm:Invoke(true)
    self:RemoveListeners()
end

function AcNewYearLevelForm:AddListeners()
  
	self.btnBg.onClick:AddListener(function()
		self:OnClose(self.uguiForm)
	end)
	self.btnGo.onClick:AddListener(function()
		self:OnbtnGoClick()
	end)
	self.event.SetFormation:AddListener(self.OnSetFormationRet,self)
	self.event.RefreshBuff:AddListener(self.RefreshDifficultyInfo,self)
end

function AcNewYearLevelForm:RemoveListeners()
  
	self.btnBg.onClick:RemoveAllListeners()
	self.btnBg.onClick:Invoke()

	self.btnGo.onClick:RemoveAllListeners()
	self.btnGo.onClick:Invoke()

	self.event.SetFormation:RemoveListener(self.OnSetFormationRet,self)
	self.event.RefreshBuff:RemoveListener(self.RefreshDifficultyInfo,self)
end

function AcNewYearLevelForm:OnbtnGoClick()
	local formationInfo = DarkBoom.CounterAttackUtility.TransToFormationInfo(CS.SLGManager.GetInstance():GetTeamByTeamID(self.teamId))
	local charList = GameEntry.PlayerData.Characters.Values
	local showList = {}
	for k,v in pairs(charList) do
		if tostring(v.typeShip) ~= "Fodder: 10" then
			table.insert(showList,v)
		end
	end
	local par = DarkBoom.StationSelectParam()
	par.m_HarbourId = self.harbourId
	par.m_curFormatonInfo = formationInfo
	par.m_InitList = showList
	par.m_OnClickOk = function(info) self:OnFormationEnsure(info) end
	self.model.isOwnBuff = true
	GameEntry.UI:OpenUIForm(CS.DarkBoom.UIFormId.CharSelectForm,par)
end

function AcNewYearLevelForm:OnFormationEnsure(formationInfo)
	local charalist = formationInfo:GetCharacterList(true)
	CS.SLGManager.GetInstance():UpdateSLGNewTeamData(self.teamId, charalist)
	local formationInfo = GameEntry.PlayerData.AtkFormations:GetInfo(self.teamId)
	local charaJson = DarkBoom.AtkFormationUtility.GetFormationString(formationInfo)
	self.manager:ReqSetFormation(self.teamId, charaJson)
end

function AcNewYearLevelForm:OnSetFormationRet(data)
	print("----OnSetFormationRet,buff:"..self.model:GetSelectBuffJson())
	self.manager:ReqStartBattle(self.harbourId,self.model:GetSelectBuffJson())
end


return AcNewYearLevelForm