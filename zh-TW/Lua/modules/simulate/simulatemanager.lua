local SimulateManager   = class("SimulateManager",BaseManager)

function SimulateManager:Logout()
  
end

local JsonDecode = JsonDecode
local WebRequest = WebRequest
local START_BATTLE = "/arena/startBattle"
local START_STORY_BATTLE = "/storyMission/startBattle"
local END_STORY_BATTLE = "/storyMission/endBattle"

function SimulateManager:ReuqestBattle()
  
    local uid = 1000011478
    local team_id  = 1
    local chara_properties = ""

    local form = CS.UnityEngine.WWWForm()
    form:AddField("uid", uid)
    form:AddField("team_id", team_id)
    form:AddField("chara_properties",chara_properties)
    
    --第一种进入战斗的方式
    WebRequest.SendRequest(START_BATTLE,form,function(serverdata)
        local model = LuaBridge.TransJsonData(serverdata.rawData,typeof(CS.DarkBoom.ArenaResponseModel))
        LuaBridge.StartBattle(nil,model.battle_info,model.battle_id)
        local battleManager = Game:GetManager("BattleManager")
        battleManager:SetEndBattleCallback(function()
            self:DoAfterLuaBattle()
        end,
        function(battleResult, battleEndDataMsg, jsonStr)
            self:DoBattleEnd(battleResult, battleEndDataMsg, jsonStr)
        end)
    end)

    --第二种进入战斗的方式
    -- WebRequest.SendRequest(START_BATTLE,form,function(serverdata)
    --     local data = JsonDecode(serverdata.rawData)
    --     LuaBridge.StartBattle(nil,data.battle_info,data.battle_id)
    -- end)
end 

function SimulateManager:RequestStoryBattle()
    local harbour_id = 5003
    local team_id = 11
    local chara_list = ""
    local chara_properties = ""

    local form = CS.UnityEngine.WWWForm()
    form:AddField("harbour_id", harbour_id)
    form:AddField("team_id", team_id)
    form:AddField("chara_list", chara_list)
    form:AddField("chara_properties", chara_properties)

    WebRequest.SendRequest(START_STORY_BATTLE, form, function(serverdata)
        local jsonData = JsonDecode(serverdata.rawData)
        LuaBridge.StartBattle(nil, jsonData.battle_info, jsonData.battle_id,
                              false, self.bot, nil)
    end)
end

function SimulateManager:DoBattleEnd(battleResult, battleEndDataMsg, jsonStr)
    local harbour_id = 5003
    local win = battleResult
    local battle_result = jsonStr

    local form = CS.UnityEngine.WWWForm()
    form:AddField("harbour_id", harbour_id)
    form:AddField("win", win)
    form:AddField("battle_result", battle_result)

    WebRequest.SendRequest(END_STORY_BATTLE, form, function(serverdata)
        local jsonData = JsonDecode(serverdata.rawData)
        local procedureBattle = GameEntry.Procedure.CurrentProcedure
        print("-------------ShowSettlementForm")
        procedureBattle:ShowSettlementForm(jsonData.user, jsonData.battle_reward,
                                battleResult, battleEndDataMsg,
                                jsonData.fetter_info)
    end)
end

function SimulateManager:DoAfterLuaBattle()
    local function OpenLobbyForm()
        local LobbyForm = 100
        GameEntry.UI:OpenUIForm(LobbyForm)
    end
    
    local function CloseMapLoadingForm() 
        CS.DarkBoom.LoadingHelper:CloseLoadingForm() 
    end
    OpenLobbyForm()
    CloseMapLoadingForm() 
end


return SimulateManager