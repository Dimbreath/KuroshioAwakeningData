--C# 调用的全局函数定义在这个文件

function Update()
--    print("Update")
   UpdateEvent:Invoke()
end

function LateUpdate()
    -- print("LateUpdate")
end

function FixedUpdate()
    -- print("FixedUpdate")
end

function LuaGC()
    collectgarbage("collect")
end

function OnApplicationPause(pause)
    -- print("Lua4CSharp -> OnApplicationPause",pause)
end

function OnItemChange()
    ItemChangeEvent:Invoke()
    --print("OnItemChange")
end

function Login()
    -- print("Lua4CSharp -> Login")
    Game:Login()
end

function RestartGame()
    -- print("Lua4CSharp -> RestartGame")
    Game:Logout()
    isLuaBattle = false
end

function HaveRedPoint()
    local ActivityType = 
    {
        None = 0,
        TasteRevolution = 20,
        Monopoly = 25,
        Supplicate = 99,
        BellDeer = 40
    }

    local tb = {}
    
    local monopolyManager = Game:GetManager("MonopolyManager")
    if monopolyManager:HaveRedPoint() then table.insert(tb,ActivityType.Monopoly) end
    
    local acSupplicateMgr = Game:GetManager("AcSupplicateMgr")
    if acSupplicateMgr:HaveRedPoint() then table.insert(tb,ActivityType.Supplicate) end

    local bellDeerMgr = Game:GetManager("BellDeerManager")
    if bellDeerMgr:HaveRedPoint() then
        table.insert(tb, ActivityType.BellDeer)
    end
    
    return tb
end

function GetInstance(name)
    return LuaActivityBridge.ReservedFunc14({name = name})
end
isLuaBattle = false

function TestStartBattle()
    local manager = Game:GetManager("SimulateManager")
    manager:RequestStoryBattle()
    isLuaBattle = true
end

function IsLuaBattle()
    --print("----IsLuaBattle")
    return isLuaBattle
end

function SetLuaBattleMark(value)
    isLuaBattle = value
end

function DoAfterLuaBattle()
    -- print("----DoAfterLuaBattle")
    local battleManager = Game:GetManager("BattleManager")
    battleManager:DoAfterLuaBattle()
end

function DoBattleEnd(battleResult, battleEndDataMsg, jsonStr)
    -- print("----DoBattleEnd")
    local battleManager = Game:GetManager("BattleManager")
    battleManager:DoBattleEnd(battleResult, battleEndDataMsg, jsonStr)
end

function NewYearWebSocketMessage()
    -- print("----NewYearWebSocketMessage")
    local newYearManager = Game:GetManager("AcNewYearManager")
    newYearManager:ReqNewYearInfo()
end

function NewYearInfoRefresh()
    -- print("----NewYearInfoRefresh")
    local newYearManager = Game:GetManager("AcNewYearManager")
    newYearManager:ReqNewYearInfo()
end

function NewYearTaskRedPoint()
    print("----NewYearInfoRefresh")
    local newYearManager = Game:GetManager("AcNewYearManager")
    local event = newYearManager:GetEvent()
    event.RefreshTaskRedPoint:Invoke()
end

AcNewYearLevelRewardForm_OnStationCheckIsSelect = function() end--避免框架报错
AcNewYearLevelRewardForm_OnStationCheckIsSelectText = function() end--避免框架报错
