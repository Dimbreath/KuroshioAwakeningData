local BattleManager = class("BattleManager",BaseManager)

function BattleManager:Logout()
    self.afterLuaBattleCallback = nil
    self.battleEndCallback = nil
end

function BattleManager:Login()
    self.afterLuaBattleCallback = nil
    self.battleEndCallback = nil
end

function BattleManager:SetEndBattleCallback(afterLuaBattle,battleEnd)
    self.afterLuaBattleCallback = afterLuaBattle
    self.battleEndCallback = battleEnd
    SetLuaBattleMark(true)
end

function BattleManager:DoAfterLuaBattle()
    if self.afterLuaBattleCallback == nil then
        print_error("can`t find after lua battle callback!")
    end
    self.afterLuaBattleCallback()
    self.afterLuaBattleCallback = nil
    SetLuaBattleMark(false)
end

function BattleManager:DoBattleEnd(battleResult, battleEndDataMsg, jsonStr)
    if self.battleEndCallback == nil then
        print_error("can`t find battle end callback!")
    end
    self.battleEndCallback(battleResult, battleEndDataMsg, jsonStr)
    self.battleEndCallback = nil
end

return BattleManager