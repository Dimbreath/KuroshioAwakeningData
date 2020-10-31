local util = require 'xluautil'

local DarkBoom = CS.DarkBoom
local GameEntry = DarkBoom.GameEntry

xlua.hotfix(CS.AIManager, 'CanGetVisionEnemy',
function(self, CharID)
	local enemyID = self:GetNearestEnemy(CharID);
    local mGameEntity = CS.EcsUtil.GetCharEnityById(CharID);
    local enemyEntity = CS.EcsUtil.GetCharEnityById(enemyID);
	
	if enemyEntity == nil then
		return false
	end
	
    local dis = CS.BattleAreaManager.CaclHexCellDisBySearch(mGameEntity.hexCell.hexCell, enemyEntity.hexCell.hexCell)
    if dis < 15 then
        return true
	end
    return false
end)