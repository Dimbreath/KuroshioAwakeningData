local util = require 'xlua/util'
local DarkBoom = CS.DarkBoom
local UnityEngine = CS.UnityEngine

local GameEntry = DarkBoom.GameEntry

xlua.private_accessible(DarkBoom.SettlementForm)

util.hotfix_ex(DarkBoom.SettlementForm, 'ShowReward',
function(self, obj)
	self:ShowReward(obj)
	if self.m_GetBoats.Count ~= 0 then
        local gachaResultData = DarkBoom.GachaResultData()
        gachaResultData.characterList = self.m_GetBoats
        gachaResultData.isBlur = true
		gachaResultData.onCloseBack = function()
			self:PlayAnim()
		end
		DarkBoom.UIExtension.OpenUIForm(GameEntry.UI,DarkBoom.UIFormId.GachaResultForm,gachaResultData)
	end
end
)