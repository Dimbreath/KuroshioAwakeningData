local SoundConfigConfig = {}

SoundConfigConfig.Values = {
	["Click"] = {"Click","001_click",0,},
	["Close"] = {"Close","002_close",0,},
	["Switch"] = {"Switch","003_switch",0,},
	["Add"] = {"Add","004_add",0,},
	["Lock"] = {"Lock","005_lock",0,},
	["TipHard"] = {"TipHard","006_tips",0,},
	["Congratulate"] = {"Congratulate","007_congratulate",0,},
	["Notice"] = {"Notice","008_notice",0,},
	["Message"] = {"Message","009_message",0,},
	["Open"] = {"Open","010_open",0,},
	["Gacha"] = {"Gacha","011_gacha",0,},
	["Up"] = {"Up","012_up",0,},
	["Rotate"] = {"Rotate","013_rotate",0,},
	["Equip"] = {"Equip","014_equip",0,},
	["Mapzoom"] = {"Mapzoom","015_mapzoom",0,},
	["Shop"] = {"Shop","015_shop",0,},
	["Fight"] = {"Fight","016_fight",0,},
	["Setoff"] = {"Setoff","016_setoff",0,},
	["Map"] = {"Map","017_map",0,},
	["SlgAreaUnlock"] = {"SlgAreaUnlock","017_slgareaunlock",0,},
	["SlgRadar"] = {"SlgRadar","018_slgradar",0,},
	["SlgBattle"] = {"SlgBattle","019_slgbattle",0,},
	["SlgWarn"] = {"SlgWarn","020_slgwarn",0,},
	["Round"] = {"Round","021_round",0,},
	["Win"] = {"Win","022_win",0,},
	["Lose"] = {"Lose","023_lose",0,},
	["Marry"] = {"Marry","024_marry",0,},
	["SLGAttack"] = {"SLGAttack","025_slgattack",0,},
	["SLGAppear"] = {"SLGAppear","026_slgappear",0,},
	["SLGAreaUnlock"] = {"SLGAreaUnlock","027_slgareaunlock",0,},
	["Breakthrough"] = {"Breakthrough","028_breakthrough",0,},
	["Christmasclick"] = {"Christmasclick","058_Christmasclick",0,},
	["Christmastouch"] = {"Christmastouch","059_Christmastouch",0,},
	["Darken"] = {"Darken","029_darken",0,},
	["BattleWin"] = {"BattleWin","030_battlewin",0,},
	["LvUse"] = {"LvUse","031_lv_use",0,},
	["slgwarntip"] = {"slgwarntip","031_slgwarntip",0,},
	["Tips"] = {"Tips","032_tips",0,},
	["Depth"] = {"Depth","033_depth",0,},
	["Depth1"] = {"Depth1","033_depth_1",0,},
	["LevHabour"] = {"LevHabour","034_levhabour",0,},
	["Load"] = {"Load","035_load",0,},
	["UnLoad"] = {"UnLoad","036_unload",0,},
	["Player1"] = {"Player1","037_player1",0,},
	["Player2"] = {"Player2","038_player2",0,},
	["Boss"] = {"Boss","039_boss",0,},
	["StoryMap"] = {"StoryMap","040_storymap",0,},
	["BattleEnd"] = {"BattleEnd","041_battleend",0,},
	["LevelUp"] = {"LevelUp","042_levelup",0,},
	["SLG1"] = {"SLG1","043_slg1",0,},
	["SLG3"] = {"SLG3","045_slg3",0,},
	["SLG4"] = {"SLG4","046_slg4",0,},
	["SLG5"] = {"SLG5","047_slg5",0,},
	["SLG6"] = {"SLG6","048_slg6",0,},
	["SLG8"] = {"SLG8","050_slg8",0,},
	["SLG9"] = {"SLG9","051_slg9",0,},
	["SLG10"] = {"SLG10","052_slg10",0,},
	["IDCard1"] = {"IDCard1","053_idcard1",0,},
	["IDCard2"] = {"IDCard2","054_idcard2",0,},
	["SSRget"] = {"SSRget","055_ssrget",0,},
	["OccupyTip"] = {"OccupyTip","057_occupy_tip",0,},
	["ACF"] = {"ACF","Darkboom_adx2",0,},
	["LobbyBgm"] = {"LobbyBgm","lobby_main",0,},
	["LoginBgm"] = {"LoginBgm","login_main",0,},
	["SLGBgm"] = {"SLGBgm","slg_main",0,},
	["WorldMapBgm"] = {"WorldMapBgm","worldmap_main",0,},
	["StoryMapBgm"] = {"StoryMapBgm","storymap_main",0,},
	["UISECuesheet"] = {"UISECuesheet","UISE",0,},
	["StorySECuesheet"] = {"StorySECuesheet","StorySE",0,},
	["BattleSECuesheet"] = {"BattleSECuesheet","BattleSE",0,},
	["Battlevictory"] = {"Battlevictory","victory",0,},
	["Battledefeat"] = {"Battledefeat","defeat",0,},
}

function SoundConfigConfig.GetConfig(key)
	local tb = SoundConfigConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["key"] = 1,["value"] = 2,["nazo"] = 3,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return SoundConfigConfig