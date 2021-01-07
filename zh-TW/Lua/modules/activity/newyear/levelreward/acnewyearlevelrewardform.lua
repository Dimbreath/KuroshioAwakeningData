local AcNewYearLevelRewardForm = class("AcNewYearLevelRewardForm", BaseForm)

local HarbourInfoConfig   = require"Configs/HarbourInfoConfig"
local BattleConfig   = require"Configs/BattleConfig"
local BattleMapEnemyGroupConfig   = require"Configs/BattleMapEnemyGroupConfig"
local BattleMonsterConfig   = require"Configs/BattleMonsterConfig"
local ResourceConfig   = require"Configs/ResourceConfig"


function AcNewYearLevelRewardForm:ctor()
end

function AcNewYearLevelRewardForm:InjectComponent()
	self.AvatarGO = self.injections.AvatarGO
	self.BossLevelText = self.injections.BossLevelText
	self.BossNameText = self.injections.BossNameText
	self.CountownText = self.injections.CountownText
	self.BoseHPSlider = self.injections.BoseHPSlider
	self.HPProgressText = self.injections.HPProgressText	
	self.RewardRoot = self.injections.RewardRoot
	self.ArrangeButton = self.injections.ArrangeButton
	self.FightButton = self.injections.FightButton
	self.ItemTemplate = self.injections.ItemTemplate
	self.SpineFormationComponent = self.injections.SpineFormationComponent
	self.StationSelectComponent = self.injections.StationSelectComponent
end

function AcNewYearLevelRewardForm:LUA_OnInit(gameObject, userData)
	self.super:LUA_OnInit(gameObject, userData)
	 if IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end		
    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self.manager = Game:GetManager("AcNewYearManager")
    self.model = self.manager:GetModel()
	self.event = self.manager:GetEvent()
	self.luaUGUIForm   = gameObject:GetComponent(typeof(CS.DarkBoom.LuaUGUIForm))
	self.refMask = self.luaUGUIForm:GetMask()
    self:InjectComponent()
	self:AddListeners()
	self.ArrangeButton.gameObject:SetActive(false)--屏蔽调遣编队按钮。
end

function AcNewYearLevelRewardForm:LUA_OnOpen(userData)
	self.super:LUA_OnOpen(userData)
	if type(userData) == "table" then
		self.harbourID = userData.harbourID
	elseif type(userData) == "userdata" then
		self.harbourID = userData:get_Item("harbourID")
	else
		print_error("AcNewYearLevelRewardForm not support input param")
	end
	self.teamID = self.model:GetTeamIdByBattleType(self.harbourID,self.model.battleType.Boss)
	AcNewYearLevelRewardForm_OnStationCheckIsSelect = self.OnStationCheckIsSelect
	AcNewYearLevelRewardForm_OnStationCheckIsSelectText = self.OnStationCheckIsSelectText
	self:RefreshLeft()
	self:RefreshRight()
	if not self.model.boss_end_time then
		self.manager:ReqNewYearInfo()
	end
	DarkBoomUtility.ToBlur(self.luaUGUIForm.UIForm)
end

--更新倒计时显示
function AcNewYearLevelRewardForm:UpdateCountDown(elapseSeconds)
	if not self.elapseSeconds then
		self.elapseSeconds = 5
	else
		self.elapseSeconds = self.elapseSeconds + elapseSeconds
	end		
	if self.elapseSeconds > 1.02 then
		self.elapseSeconds = 0
		if self.model.boss_end_time ~= nil then
			local remainTime = self.model.boss_end_time - DarkBoomUtility.GetServerCrtTime()
			if remainTime < 0 then
				if not self.canClose then
					self.luaUGUIForm.gameObject:SetActive(false)
					self.canClose = true
				else
					self.luaUGUIForm:Close()
				end
				
			else
				self.CountownText.text = DarkBoomUtility.ToHourMinuteSecond(remainTime)
			end
		end
	end
end

function AcNewYearLevelRewardForm:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
	self.super:LUA_OnUpdate(elapseSeconds, realElapseSeconds)
	self:UpdateCountDown(elapseSeconds)
	
end

function AcNewYearLevelRewardForm:LUA_OnClose(userData)
	self.super:LUA_OnClose(userData)
	DarkBoomUtility.RegainBlur(self.luaUGUIForm.UIForm)
	if self.defaultFormationChanged then
		self:C2SSetBattleFormation()
	end
	self:RemoveListeners()
	self.injections = nil
    self.luaUGUIForm = nil
	self.event = nil
	self.model = nil
	self.manager = nil
	self.gameObject = nil
	if self.stationSelectParam then
		self.stationSelectParam.m_OnClickAction = nil
		self.stationSelectParam.m_OnCheckIsSelect = nil
		self.stationSelectParam.m_OnCheckIsSelectText = nil
		self.stationSelectParam.m_OnSort = nil
		self.stationSelectParam.m_OnClickSpineItem = nil
		self.stationSelectParam = nil
	end
	self.c2sSetBattleFormationCallBack = nil
	AcNewYearLevelRewardForm_OnStationCheckIsSelect = function() end--避免框架报错
	AcNewYearLevelRewardForm_OnStationCheckIsSelectText = function() end--避免框架报错
end

function AcNewYearLevelRewardForm:RefreshLeft()
	self.BossLevelText.text = ""
	self.BoseHPSlider.value = 0
	self.HPProgressText.text = ""
	self:UpdateBossInfo()
	local transform = self.RewardRoot.transform
	local count = transform.childCount - 1
	for i=0, count do
		CS.UnityEngine.Object.Destroy(transform:GetChild(i).gameObject)
	end
	
	if datas and datas.Count > 0 then 
		self.ItemTemplate:RefreshData(datas[0],mask)
		DarkBoomUtility.AddItemDetail(self.gameObject,datas[0]);
	end
		
	local harbourInfoConfig = HarbourInfoConfig.GetConfig(self.harbourID)
	if harbourInfoConfig ~= nil then
		local battleConfig = BattleConfig.GetConfig(harbourInfoConfig.harbourcontent)
		if battleConfig ~= nil then
			local battleMapEnemyGroupConfig = BattleMapEnemyGroupConfig.GetConfig(MakeJointKey(battleConfig.enemygroupid, 1))
			if battleMapEnemyGroupConfig ~= nil and battleMapEnemyGroupConfig.bossid ~= nil and battleMapEnemyGroupConfig.bossid > 0 then
				local battleMonsterConfig = BattleMonsterConfig.GetConfig(battleMapEnemyGroupConfig["charaid"..tostring(battleMapEnemyGroupConfig.bossid)])
				if battleMonsterConfig ~= nil then
					--self.BossNameText.text = "猪皮特"
					self.BossNameText.text = battleMonsterConfig.typename------
					local skinCfg = tonumber(battleMonsterConfig.skincfg)
					if skinCfg ~= nil then
						--self.AvatarGO:LoadAvatar(3019000, CS.Config.AvatarScene.None, true)------
						self.AvatarGO:LoadAvatar(skinCfg, CS.Config.AvatarScene.None, true)------
					end
				end
			end
		end
		--处理奖励展示
		
		local itemCellDataArr = DarkBoomUtility.ParseRewardString(harbourInfoConfig.salvagedropshow)
		local count = itemCellDataArr.Count - 1
		for i=0, count do
			local itemCellData = itemCellDataArr[i]
			local gameObject = CS.UnityEngine.Object.Instantiate(self.ItemTemplate.gameObject)
			gameObject.transform:SetParent(self.RewardRoot, false)
			local itemCell = gameObject:GetComponent(self.ItemTemplate:GetType())
			
			itemCell:RefreshData(itemCellData, self.refMask)
			DarkBoomUtility.AddItemDetail(gameObject, itemCellData)
		end
		---
	end	
	
end

function AcNewYearLevelRewardForm:IsDead(id)
	local result = false
	if not id or not self.model.bossInfo or not self.model.bossInfo.lost_hp_list then return result end
	for k, v in pairs(self.model.bossInfo.lost_hp_list) do
		if v.id == id then
			if v.dead > 0 then
				result = true
			end
			break
		end
	end
	return result
end

function AcNewYearLevelRewardForm:LimitByLevel(characterInfo)
	local result = false
	local limitLevel = tonumber(GetGlobalText("newYear_boss_lvmin"))
	if not characterInfo or not limitLevel then return result end
	result = characterInfo.lv < limitLevel
	return result
end

function AcNewYearLevelRewardForm:UpdateBossInfo()
	if not self.model.bossInfo then return end
	local bossInfo = self.model.bossInfo
	if bossInfo.boss_hp_max and bossInfo.boss_hp_max > 0 and bossInfo.boss_hp_lost then
		local hp_left = bossInfo.boss_hp_max - bossInfo.boss_hp_lost
		self.BoseHPSlider.value = hp_left / bossInfo.boss_hp_max
		self.HPProgressText.text = string.format("<color=#FF009199>%s</color><color=#FFFFFF99>/%s</color>", tostring(hp_left), tostring(bossInfo.boss_hp_max))
	end
	self.BossLevelText.text = tostring(bossInfo.boss_level)
end

function AcNewYearLevelRewardForm:AddListeners()
	self:RemoveListeners()
	self.ArrangeButton.onClick:AddListener(function()
		self:OnClickArrangeButton()
	end)
	self.FightButton.onClick:AddListener(function()
		self:OnClickFightButton()
	end)
	self.event.SetFormation:AddListener(self.OnSetFormationRet,self)
	self.event.UpdateBossInfo:AddListener(self.UpdateBossInfo, self)
end

function AcNewYearLevelRewardForm:RemoveListeners()
	self.ArrangeButton.onClick:RemoveAllListeners()
	self.FightButton.onClick:RemoveAllListeners()
	self.event.SetFormation:RemoveListener(self.OnSetFormationRet,self)
	self.event.UpdateBossInfo:RemoveListener(self.UpdateBossInfo, self)
end

-- 编队界面的回调
function AcNewYearLevelRewardForm.ArrangeFormCallBack(formationInfo)
	local self = AcNewYearLevelRewardForm
	self.defaultFormation = CS.DarkBoom.AtkFormationUtility.ToAtkFormationInfo(formationInfo, true)
	self:C2SSetBattleFormation()
end

--开始战斗
function AcNewYearLevelRewardForm:GoToFight()
	if not self.defaultFormation or self.defaultFormation:IsEmpty() then
		CS.DarkBoom.GameEntry.UI:OpenMsgTipsUIFormWithKey("formation_team_empty")
		return
	end
	self.manager:ReqStartBattle(self.harbourID,"")
	self.model.endBattleSwitchTog = self.model.curTog
	self.luaUGUIForm:Close()
end

--点击调遣编队按钮
function AcNewYearLevelRewardForm:OnClickArrangeButton()
	--print("OnClickArrangeButton")	
	if not CS.DarkBoom.FormationUtility.CheckAllFormationCall() then
		CS.DarkBoom.GameEntry.UI:OpenMsgTipsUIFormWithKey("confirm_dispatch_tips1")
		return
	end		
    local param = CS.DarkBoom.FormationFormParam()
	param.enterType = CS.DarkBoom.EnterFormationType.CallFormation
	param.Callback = AcNewYearLevelRewardForm.ArrangeFormCallBack
    CS.DarkBoom.FormationUtility.OpenFormationForm(param)	
end

--点击出击按钮
function AcNewYearLevelRewardForm:OnClickFightButton()
	--print("OnClickFightButton")
	if self.defaultFormationChanged then
		self:C2SSetBattleFormation(function() self:GoToFight() end)
	else
		self:GoToFight()
	end
end

-------------------------------------------------------------------------------------------------------------------------

function AcNewYearLevelRewardForm:OnSetCharacter(sortForceUpdate, sortBackToTop)
	--print("OnSetCharacter")
	self:RefreshFormation()
	self.StationSelectComponent:Refresh(sortForceUpdate, sortBackToTop)
end

function AcNewYearLevelRewardForm:RefreshFormation()
	if not self.defaultFormation then
		self.defaultFormation = CS.DarkBoom.AtkFormationDataMgr.GetInstance():GetBattleFormation(self.teamID)
		local removeTable = {}
		for k, id in pairs(self.defaultFormation.charaKeys) do
			if self:IsDead(id) then
				table.insert(removeTable, id)
			else
				local characterInfo = CS.DarkBoom.GameEntry.PlayerData.Characters:GetInfo(id)
				if self:LimitByLevel(characterInfo) then
					table.insert(removeTable, id)
				end
			end
		end
		if #removeTable > 0 then
			self.defaultFormationChanged = true
			for i, id in ipairs(removeTable) do
				self.defaultFormation:Remove(id)
				--print("删除死人")
			end
		end
	end
	if self.defaultFormation ~= nil then
		self.charDic = CS.DarkBoom.AtkFormationUtility.GetFormationCharasDict(self.defaultFormation)
	else
		self.charDic = nil
	end
	self.SpineFormationComponent:SetNoAddActive(true)
	self.SpineFormationComponent:SetData(self.charDic, self.stationSelectParam.m_OnClickSpineItem, self.stationSelectParam.m_Mask,
							   self.stationSelectParam.m_OnGetHpPer, self.stationSelectParam.m_EnemyScore, self.stationSelectParam.m_IsShowEnemyScore, self.stationSelectParam.m_HarbourId
							   , self.stationSelectParam.m_IsShowAdditoin
							   , CS.DarkBoom.ESpineFormationComponentTitleType.None)
end

--给服务器发送改变编队的协议
function AcNewYearLevelRewardForm:C2SSetBattleFormation(callBack)
	self.defaultFormationChanged = nil
	self.c2sSetBattleFormationCallBack = callBack
	
	local charaJson = DarkBoom.AtkFormationUtility.GetFormationString(self.defaultFormation)
	self.manager:ReqSetFormation(self.teamID, charaJson)
end

function AcNewYearLevelRewardForm:OnSetFormationRet(data)
	CS.DarkBoom.GameEntry.PlayerData:UpdateAtkFormations(data)
	self:RefreshRight()
	if self.c2sSetBattleFormationCallBack then
		self.c2sSetBattleFormationCallBack(self)
	end
end

-------------------------------------------------------------------------------------------------------------------------

--点击头像列表的回调
function AcNewYearLevelRewardForm:OnStationClickAction(characterInfo)
	--print("OnStationClickAction")
	if not characterInfo then return end
	if self.defaultFormation:HasCharachter(characterInfo) then
		self:OnStationClickSpineItem(characterInfo)
		return
	end
	if self.defaultFormation:IsFull() then
		GameEntry.UI:OpenMsgTipsUIFormWithKey("occupy_harbourInfo_102")--人偶数量已满
	end
	if self:IsDead(characterInfo.id) then
		GameEntry.UI:OpenMsgTipsUIFormWithKey("blitzkrieg_troop_text_05")--死人不能上阵
		return
	end
	if self:LimitByLevel(characterInfo) then
		GameEntry.UI:OpenMsgTipsUIFormWithKey("newyear_boss_lv_tips")--等级不达标
		return
	end
	
	if self.defaultFormation:AddCharacter(characterInfo.id) then
		self.defaultFormationChanged = true
		self:OnSetCharacter(true, false)
	else
	end
end


function AcNewYearLevelRewardForm.OnStationCheckIsSelect(characterInfo)
	--print("OnStationCheckIsSelect")
	local self = AcNewYearLevelRewardForm
	if self.charDic:ContainsValue(characterInfo) then
		return true
	end
	return false
end

function AcNewYearLevelRewardForm.OnStationCheckIsSelectText(characterInfo, uiText, uiIcon)
	local self = AcNewYearLevelRewardForm
	--print("OnStationCheckIsSelectText")
	if self.charDic:ContainsValue(characterInfo) then
		return false
	end
	
	if self:IsDead(characterInfo.id) then
		uiText.text = GameEntry.Localization:GetString("blitzkrieg_troop_text_04")--死人
		CS.DarkBoom.DarkBoomUtility.LoadSprite(uiIcon, "slg_1_icon_mask_6", self.refMask, "Common", "", false)
		return true
	end
	
	if self:LimitByLevel(characterInfo) then
		uiText.text = GameEntry.Localization:GetString("newyear_boss_lv")--等级不达标
		CS.DarkBoom.DarkBoomUtility.LoadSprite(uiIcon, "slg_1_icon_mask_6", self.refMask, "Common", "", false)
		return true
	end
	
	if characterInfo.status == CS.DarkBoom.FormationInfo.Status.None then
		if self.defaultFormation:Has(characterInfo.id, true) then
			uiText.text = GameEntry.Localization:GetString("occupy_harbourInfo_191")--同名卡
			CS.DarkBoom.DarkBoomUtility.LoadSprite(uiIcon, "slg_1_icon_mask_6", self.refMask, "Common", "", false)
			return true
		end
		--return false
	end
	
	return false
end

function AcNewYearLevelRewardForm:OnStationSort(characterInfoList)
	--print("OnStationSort2")
	--characterInfoList:Sort()
end

function AcNewYearLevelRewardForm:OnStationClickSpineItem(characterInfo)
	--print("OnStationClickSpineItem")
	if not characterInfo then return end
	if self.defaultFormation:Remove(characterInfo.id) then
		self.defaultFormationChanged = true
		self:OnSetCharacter(true, false)
	end
end
-------------------------------------------------------------------------------------------------------------------------



function AcNewYearLevelRewardForm:RefreshRight()
	if not self.stationSelectParam then
		self.stationSelectParam = CS.DarkBoom.StationSelectParam()
	end
	
	self.stationSelectParam.m_Type = CS.DarkBoom.StationSelectComponent.StationSelectComponentType.Formation
	self.stationSelectParam.m_Mask = self.refMask
	
	if not self.stationSelectParam.m_OnClickAction then
		self.stationSelectParam.m_OnClickAction = function(characterInfo) self:OnStationClickAction(characterInfo) end
	end
	
--[[--XLUA原因不能这么写，等委托函数加上LuaCallCSharp标签后再试
	if not self.stationSelectParam.m_OnCheckIsSelect then
		self.stationSelectParam.m_OnCheckIsSelect = function(characterInfo) return self:OnStationCheckIsSelect(characterInfo) end
	end
	
	if not self.stationSelectParam.m_OnCheckIsSelectText then
		self.stationSelectParam.m_OnCheckIsSelectText = function(characterInfo) return self:OnStationCheckIsSelectText(characterInfo, text, image) end
	end
	--]]
	
	if not self.stationSelectParam.m_OnSort then
		self.stationSelectParam.m_OnSort = function(characterInfoList) self:OnStationSort(characterInfoList) end
	end
	
	if not self.stationSelectParam.m_OnClickSpineItem then
		self.stationSelectParam.m_OnClickSpineItem = function(characterInfo) self:OnStationClickSpineItem(characterInfo) end
	end
	--local showList = CS.DarkBoom.GameEntry.PlayerData.Characters.Values:ToList()--this扩展函数不能直接调用
	local showList = CS.System.Collections.Generic.List(CS.DarkBoom.CharacterInfo)()
	local dic = CS.DarkBoom.GameEntry.PlayerData.Characters.Values
	for k, v in pairs(dic) do
		if v.typeShip ~= CS.CharacterShipType.Fodder then --素材人偶不能上阵
			showList:Add(v)
		end
	end
	self.stationSelectParam.m_InitList = showList
	self.stationSelectParam.m_OnGetHpPer = nil
	self.stationSelectParam.m_OnRender = nil
	self.stationSelectParam.m_ShowTeamWin = true
	self.stationSelectParam.m_ShowInitHp = false
	self.stationSelectParam.m_ShowSelectHp = false
	
	self.StationSelectComponent:Init(self.stationSelectParam)
	self:RefreshFormation()
	self.StationSelectComponent:Refresh(false, false)
end

return AcNewYearLevelRewardForm