local util = require 'xluautil'

local DarkBoom = CS.DarkBoom

xlua.hotfix(CS.BattleCharHead, 'OnActiveSkill',
function(self, obj)
    if CS.BattleManager:GetInstance().BattleState ~= CS.BATTLE_STATE.RUNNING then
		return
	end
    local gameEntity = CS.EcsUtil.GetCharEnityById(self.charID)

    if CS.BattleManager:GetInstance().BattleOperaState == CS.BATTLE_OPERA_TYPE.AUTO then
		return
	end
    if CS.AIManager:getInst():CheckActiveSkillCD(gameEntity) then
		if  CS.AIManager:getInst():CheckActiveOrder() then
			CS.AIManager:getInst():AddToActiveSkillList(gameEntity)
		else
			DarkBoom.UIExtension.OpenMsgTipsUIForm(GameEntry.UI, '能量点不足', DarkBoom.SoundEffectType.Tips)
		end
    end

end)