local AcNewYearManager   = class("AcNewYearManager",BaseManager)
local AcNewYearModel     = require("Modules/Activity/NewYear/AcNewYearModel")
local AcNewYearEvent     = require("Modules/Activity/NewYear/AcNewYearEvent")

local INDEX = "/newYearActivity/index"
local STARTBATTLE = "/newYearActivity/startBattle"
local ENDBATTLE = "/newYearActivity/endBattle"
local SETFORMATION = "/Formation/setAtkFormation"
local TRUNINRESOURCE = "/newYearActivity/turnInResource"
local GETRANKLIST = "/newYearActivity/getRankList"
local GETBOSSINFO = "/newYearActivity/getBossInfo"
local GETATTACKAWARD = "/newYearActivity/drawAttackAward"
local GETREWARDNPC = "/newYearActivity/rewardNpc"

function AcNewYearManager:Logout()
	self.model.event = nil
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

function AcNewYearManager:ReqNewYearInfo()
    local form = CS.UnityEngine.WWWForm()
    WebRequest.SendRequest(INDEX,form,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        self.model:SetInfos(data)
        self.event.RefreshNewYearInfo:Invoke()
    end)
end

function AcNewYearManager:ReqStartBattle(harbour_id,buff)
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

function AcNewYearManager:ReqEndBattle(harbour_id,win,battleEndDataMsg,battle_result)
    local form = CS.UnityEngine.WWWForm()
    form:AddField("harbour_id", harbour_id)
    form:AddField("win", win)
    form:AddField("battle_result", battle_result)
    WebRequest.SendRequest(ENDBATTLE,form,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        print("----ReqEndBattle")
        local procedureBattle = GameEntry.Procedure.CurrentProcedure
        procedureBattle:ShowSettlementForm(data.user, data.battle_reward,
            win, battleEndDataMsg, data.fetter_info)
        if data.user_harbour ~= nil then
            local harbourData = {}
            harbourData.harbour_id = data.user_harbour.harbour_id
            harbourData.first_clear_time = data.user_harbour.first_clear_time
            DarkBoom.LuaActivityBridge.ReservedFunc8(harbourData)
        end
    end)
end

function AcNewYearManager:DoAfterLuaBattle()
    local id = 0
    local activityConfig = self.model:GetCurActivityConfig()
    if activityConfig ~= nil then
        id = tonumber(activityConfig.parameter_2)
    end
    CS.DarkBoom.WorldMapUtility.GoToWorldMap(id)
    CS.DarkBoom.LoadingHelper:CloseLoadingForm() 
end

function AcNewYearManager:ReqSetFormation(team_id,user_chara_ids)
    local form = CS.UnityEngine.WWWForm()
    form:AddField("team_id", team_id)
    form:AddField("user_chara_ids", user_chara_ids)
    WebRequest.SendRequest(SETFORMATION,form,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        print_r(data)
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

function AcNewYearManager:ReqRewardNpc()
    local wwwForm = CS.UnityEngine.WWWForm()
    WebRequest.SendRequest(GETREWARDNPC,wwwForm,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        self.model.reward_npc = data.reward_npc
        DarkBoomUtility.ShowRewardUIForm(serverdata.user)
    end)
end

function AcNewYearManager:OpenAcNewYearLevelRewardForm(harbourId)
	self:ReqBossInfo(harbourId, function()
		GameEntry.UI:OpenUIForm(7070, {harbourID=harbourId})
	end)
end

return AcNewYearManager