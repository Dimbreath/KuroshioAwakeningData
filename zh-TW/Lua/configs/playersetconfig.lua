local PlayerSetConfig = {}

PlayerSetConfig.Values = {
	[1] = {1,"Setting.FPS",1,0,0,},
	[2] = {2,"Setting.BattleVideo",2,0,0,},
	[3] = {3,"Setting.Music",1,0,0,},
	[4] = {4,"Setting.SE",1,0,0,},
	[5] = {5,"Setting.Voice",1,0,0,},
	[6] = {6,"Setting.Push",1,0,0,},
	[7] = {7,"Setting.Expedition",1,0,0,},
	[8] = {8,"Setting.GaCha",1,0,0,},
	[9] = {9,"Setting.SelfDiscipline",1,0,0,},
	[10] = {10,"Setting.Research",1,0,0,},
	[11] = {11,"Setting.Lang",1,0,0,},
	[12] = {12,"Character_IsSpine",1,0,0,},
	[13] = {13,"{0}_help_id_{1}",2,0,0,},
	[14] = {14,"StoryAuto",2,0,0,},
	[15] = {15,"VERSION",1,0,0,},
	[16] = {16,"user_id",2,0,0,},
	[17] = {17,"display_uid",2,0,0,},
	[18] = {18,"_accountCustomIDKey",1,0,0,},
	[19] = {19,"_accountCustomPWDKey",1,0,0,},
	[20] = {20,"_serverIDKey",2,0,0,},
	[21] = {21,"SOFTGUIDELIST{0}",2,0,0,},
	[22] = {22,"ALBUM_SORT_KEY",1,1,0,},
	[23] = {23,"DOCK_SORT_TYPE",1,1,0,},
	[24] = {24,"DOCK_FILTER_TYPE",1,1,0,},
	[25] = {25,"DarkBoomCG_{0}",2,1,0,},
	[26] = {26,"BATTLE_SPEED_TYPE",2,0,0,},
	[27] = {27,"BATTLE_OPERA_TYPE",2,0,0,},
	[28] = {28,"Setting.BattleVideoDailyList",2,1,0,},
	[29] = {29,"BATTLE_QUALITY",1,0,0,},
	[30] = {30,"BattleShaderModel3",1,0,0,},
	[31] = {31,"BattleRecommondQuality",1,0,0,},
	[32] = {32,"BattleQualityInitRecord",1,0,0,},
	[33] = {33,"activity_battlematerial",2,0,0,},
	[36] = {36,"SlgRoadTip",2,1,0,},
	[37] = {37,"CharacterUnLock",1,0,0,},
}

function PlayerSetConfig.GetConfig(key)
	local tb = PlayerSetConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["key"] = 2,["type"] = 3,["is_reset"] = 4,["nazo"] = 5,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return PlayerSetConfig