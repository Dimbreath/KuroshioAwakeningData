local util = require 'xluautil'

local DarkBoom = CS.DarkBoom
local BattleManager = CS.BattleManager
local AIManager = CS.AIManager
local BATTLE_STATE = CS.BATTLE_STATE
local BATTLE_RESULT = CS.BATTLE_RESULT

xlua.hotfix(CS.BattleManager, 'CheckBattleState',
function(self)
    if (BattleManager:GetInstance().BattleState == BATTLE_STATE.RUNNING) then
        if (AIManager:getInst():IsAllHeroDeath()) then
            BattleManager:GetInstance():GameOver(BATTLE_RESULT.LOSE);
            return;
		end
        if (AIManager:getInst():IsAllEnemyDeath()) then
            BattleManager:GetInstance():GameOver(BATTLE_RESULT.WIN);
            return;
        end
	end
end)