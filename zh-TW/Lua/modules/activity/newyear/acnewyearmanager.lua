local AcNewYearManager   = class("AcNewYearManager",BaseManager)
local AcNewYearModel     = require("Modules/Activity/NewYear/AcNewYearModel")
local AcNewYearEvent     = require("Modules/Activity/NewYear/AcNewYearEvent")
local TaskConfig = require"Configs/TaskConfig"

local INDEX = "/newYearActivity/index"
local STARTBATTLE = "/newYearActivity/startBattle"
local ENDBATTLE = "/newYearActivity/endBattle"
local SETFORMATION = "/Formation/setAtkFormation"
local TRUNINRESOURCE = "/newYearActivity/turnInResource"
local GETRANKLIST = "/newYearActivity/getRankList"
local GETBOSSINFO = "/newYearActivity/getBossInfo"
local GETATTACKAWARD = "/newYearActivity/drawAttackAward"
local GETREWARDNPC = "/newYearActivity/rewardNpc"
local GETTASK_FOR_REDPOINT = "/newYearActivity/getTask"--真正的任务协议在c#中Interpret。lua代码访问不到

function AcNewYearManager:Logout()
    if self.model ~= nil then
        self.model.event = nil
    end
    self.model = nil
    self.event = nil
end

function AcNewYearManager:GetModel()
    return self.model
end

function AcNewYearManager:GetEvent()
    return self.event
end

function AcNewYearManager:Login()
    print("AcNewYearManager:Login")
    self.model = AcNewYearModel.new()
    self.event = AcNewYearEvent.new()
    self.model.event = self.event
    --self:ReqNewYearInfo()
end

function AcNewYearManager:ReqNewYearInfo(success)
    local form = CS.UnityEngine.WWWForm()
    WebRequest.SendRequest(INDEX,form,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        self.model:SetInfos(data)
        self.event.RefreshNewYearInfo:Invoke()
        if success ~= nil then
            success()
        end
    end)
end

function AcNewYearManager:ReqTaskForRedPoint(success)-- 1.9版本不用这样处理
	if CS.DarkBoom.ActivityShopMgr.GetInstance().RedPoint > 0 then 
		--print("~~有红点，不再请求~~")
		return
	end 
    local form = CS.UnityEngine.WWWForm()
    WebRequest.SendRequest(GETTASK_FOR_REDPOINT,form,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
		local taskArr = data.achievements
		local hasRedPoint = false
		for i, task in ipairs(taskArr) do
			local taskConfig = TaskConfig.GetConfig(task.id)
			if taskConfig and task.progress >= taskConfig.taskcompleteconditionnum and task.isFinished <= 0 then
				hasRedPoint = true
				break
			end
		end
		if hasRedPoint then
			CS.DarkBoom.ActivityShopMgr.GetInstance():UpDateRedPoint(hasRedPoint and 1 or 0)
			self.event.RefreshTaskRedPoint:Invoke()
		end
    end)
end

function AcNewYearManager:ReqStartBattle(harbour_id,buff)
    local request = function()
        local form = CS.UnityEngine.WWWForm()
        form:AddField("harbour_id", harbour_id)
        form:AddField("buff", buff)
        WebRequest.SendRequest(STARTBATTLE,form,function(serverdata)
            local data = JsonDecode(serverdata.rawData)
            print("----ReqStartBattle") 
            LuaBridge.StartBattle(nil,data.battle_info,data.battle_id)
            local battleManager = Game:GetManager("BattleManager")
            battleManager:SetEndBattleCallback(function()
                self:DoAfterLuaBattle()
            end,
            function(battleResult, battleEndDataMsg, jsonStr)
                self:ReqEndBattle(harbour_id, battleResult, battleEndDataMsg, jsonStr)
            end)
        end)
    end
    local harbourInfoConfig = self.model:GetHarbourInfo(harbour_id)
    if harbourInfoConfig == nil then return end
    if not self.model:IsHarbourAnyDifficultyClear(harbour_id) then
        self.model.endBattleHarbourId = harbour_id
    end
    if harbourInfoConfig.startstory ~= '' and not self.model:IsHarbourAnyDifficultyClear(harbour_id) then
        DarkBoom.LuaBridge.PlayStory(harbourInfoConfig.startstory,request)
    else
        request()
    end

end

function AcNewYearManager:ReqEndBattle(harbour_id,win,battleEndDataMsg,battle_result)
    local form = CS.UnityEngine.WWWForm()
    form:AddField("harbour_id", harbour_id)
    form:AddField("win", win)
    form:AddField("battle_result", battle_result)
    self.model.endBattleResult = win
    WebRequest.SendRequest(ENDBATTLE,form,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        print("----ReqEndBattle")
        local procedureBattle = GameEntry.Procedure.CurrentProcedure
        -- data.battle_reward:GetUICellShowDatas()
        procedureBattle:ShowSettlementForm(serverdata.user, data.battle_reward,
            win, battleEndDataMsg, data.fetter_info)
        self.model.endBattleData = data
        if data.user_harbour ~= nil then
            local harbourData = {}
            harbourData.harbour_id = data.user_harbour.harbour_id
            harbourData.first_clear_time = data.user_harbour.first_clear_time
            DarkBoom.LuaActivityBridge.ReservedFunc8(harbourData)
        end
    end)
end

function AcNewYearManager:GetNewCharacters(data)
    local timestamp = data.timestamp
    local list = {}
    if data.battle_reward ~= nil and data.battle_reward.characters ~= nil then
        for k,v in pairs(data.battle_reward.characters) do
            if v.get_time == timestamp then
                table.insert(list,v.id)
            end
        end
    end
    return list
end

function AcNewYearManager:DoAfterLuaBattle()
    local onCloseBack = function()
        local request = function()
            local id = 0
            local activityConfig = self.model:GetCurActivityConfig()
            if activityConfig ~= nil then
                id = tonumber(activityConfig.parameter_2)
            end
            CS.DarkBoom.WorldMapUtility.GoToWorldMap(id,0,DarkBoom.EnterWorldMapAction.None,function()
                CS.DarkBoom.LoadingHelper:CloseLoadingForm() 
            end)
            
        end
        if self.model.endBattleHarbourId == 0 then
            request()
            return
        end
        local harbourInfoConfig = self.model:GetHarbourInfo(self.model.endBattleHarbourId)
        if harbourInfoConfig == nil then
            request()
            return 
        end
        if harbourInfoConfig.endstory ~= '' and self.model.endBattleResult ~= nil and self.model.endBattleResult == 1 then
            DarkBoom.LuaBridge.PlayStory(harbourInfoConfig.endstory,request)
        else
            request()
        end
        self.model.endBattleHarbourId = 0
    end
    if self.model.endBattleData ~= nil then
        local charaList = self:GetNewCharacters(self.model.endBattleData)
        local boatList = {}
        for i,v in ipairs(charaList) do
            table.insert(boatList,GameEntry.PlayerData.Characters:GetInfo(v))
        end
        if #boatList > 0 then
            local gachaResultData = DarkBoom.GachaResultData()
            gachaResultData.characterList = boatList
            gachaResultData.isBlur = false
            gachaResultData.onCloseBack = onCloseBack
            GameEntry.UI:OpenUIForm(DarkBoom.UIFormId.GachaResultForm, gachaResultData)
        else
            onCloseBack()
        end
        self.model.endBattleData = nil
    end
    -- self.model.endBattleResult = 0
end

function AcNewYearManager:ReqSetFormation(team_id,user_chara_ids)
    local form = CS.UnityEngine.WWWForm()
    form:AddField("team_id", team_id)
    form:AddField("user_chara_ids", user_chara_ids)
    WebRequest.SendRequest(SETFORMATION,form,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        print_r(data)
		CS.DarkBoom.GameEntry.PlayerData:UpdateAtkFormations(data)
        self.event.SetFormation:Invoke(data)
    end)
end

function AcNewYearManager:ReqTurnInResource(res)
	local wwwForm = CS.UnityEngine.WWWForm()
	--上缴物品 [{‘item_id’:1,’num’:2},..]
	wwwForm:AddField("resource", res)
	WebRequest.SendRequest(TRUNINRESOURCE,wwwForm,function(serverdata)
	    local data = JsonDecode(serverdata.rawData)
	    self.model:RefreshMorale(data)
	    self.model:RefreshIntegral(data)
        self.event.TurnInResourceFinish:Invoke(serverdata)
    end,function(str1,str2)	    
        self.event.TurnInResourceError:Invoke(str1,str2)
    end) 
end

function AcNewYearManager:ReqGetRankInfo()
    local wwwForm = CS.UnityEngine.WWWForm()
    WebRequest.SendRequest(GETRANKLIST,wwwForm,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        self.model:RefreshRankList(data)
        self.model:RefreshRewardCd(data)
        self.event.RefreshRankList:Invoke()
        self.event.RefreshAwardCd:Invoke()
    end) 
end

function AcNewYearManager:ReqBossInfo(harbourId, succCallback)
    local wwwForm = CS.UnityEngine.WWWForm()
	wwwForm:AddField("harbour_id", harbourId)
    WebRequest.SendRequest(GETBOSSINFO,wwwForm,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        self.model:UpdateBossInfo(data)
		if succCallback then
			succCallback(data)
		end
    end)
end


function AcNewYearManager:ReqGetAttackReward(type)
    local wwwForm = CS.UnityEngine.WWWForm()
    wwwForm:AddField("type", type)
    WebRequest.SendRequest(GETATTACKAWARD,wwwForm,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        if type == 1 then 
            self.model.can_draw_personal = 2
        elseif type ==2 then
            self.model.can_draw_server = 2
        end
        DarkBoomUtility.ShowRewardUIForm(serverdata.user)
        self.event.GetFinalReward:Invoke()
    end)
end

function AcNewYearManager:ReqRewardNpc(success)
    local wwwForm = CS.UnityEngine.WWWForm()
    WebRequest.SendRequest(GETREWARDNPC,wwwForm,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        self.model.reward_npc = data.reward_npc
        DarkBoomUtility.ShowRewardUIForm(serverdata.user)
        if success ~= nil then
            success()
        end
    end)
end

function AcNewYearManager:OpenAcNewYearLevelRewardForm(harbourId)
	self:ReqBossInfo(harbourId, function()
		GameEntry.UI:OpenUIForm(7070, {harbourID=harbourId})
	end)
end

return AcNewYearManager