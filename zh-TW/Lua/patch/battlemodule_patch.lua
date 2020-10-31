local util = require 'xluautil'

local BattleNew = CS.BattleNew
local BattleModule = BattleNew.BattleModule
local PostProcessVolume = CS.UnityEngine.Rendering.PostProcessing.PostProcessVolume
local GameObject = CS.UnityEngine.GameObject
local BattleUtility = BattleNew.BattleUtility
local BattleResult = BattleNew.BattleResult

xlua.private_accessible(BattleModule)

xlua.hotfix(BattleModule, 'InitAndStartBattle',
function(self,battleData,battleDataVO,randomSeed,editormode)
	BattleUtility.PlayBGM(BattleUtility.BattleBGMName)
    self.currentWave = 0
    self.battleResult = BattleResult.None
    self:InitData(battleData, randomSeed, battleDataVO)
    self.editorMode = editormode
    if  editormode == true then
        self.autoProcceed = false
        self:InitBattleRegion(false, nil)
    else
        self.autoProcceed = true              
       --[[ self:InitBattleRegion(true, function()
									local processVolume = GameObject.Find("WaterContainer/PostProcessing"):GetComponent("PostProcessVolume")
										if processVolume == nil then
										   return
										end
									local postpProcessLst = processVolume.profile.settings
										for k,v in pairs(postpProcessLst) do
											v.active = true
											v.enabled.value = true
											v.enabled.overrideState = true
										end
								    end)]]
	   self:InitBattleRegion(true, nil)
    end
end)
