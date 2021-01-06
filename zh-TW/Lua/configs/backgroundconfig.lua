local BackGroundConfig = {}

BackGroundConfig.Values = {
	[1] = {1,[[港口基地]],1,1,'',1,1,"lobby_bg_01","lobby_bg_sl_001",0,},
	[2] = {2,[[港口基地-秋日]],0,0,[[暫無獲取途徑]],0,2,"bg_1_battle_003","bg_1_battle_003",0,},
	[3] = {3,[[港口基地-春分]],0,0,[[暫無獲取途徑]],0,1,"lobby_bg_01","bg_1_battle_003",0,},
	[4] = {4,[[港口基地-夏至]],0,0,[[暫無獲取途徑]],0,2,"bg_1_battle_004","bg_1_battle_004",0,},
	[5] = {5,[[黑鋒重工]],0,0,[[暫無獲取途徑]],0,1,"lobby_bg_05","lobby_bg_sl_005",0,},
	[6] = {6,[[薔薇帝國]],0,1,[[黑石商店兌換]],0,1,"lobby_bg_06","lobby_bg_sl_006",0,},
	[7] = {7,[[神代會社]],0,1,[[黑石商店兌換]],0,1,"lobby_bg_07","lobby_bg_sl_007",0,},
	[8] = {8,[[銀翼財團]],0,1,[[追念之井限時禮包獲取]],0,1,"lobby_bg_08","lobby_bg_sl_008",0,},
	[9] = {9,[[公共休息室-聖誕]],0,1,[[聖誕限時禮包獲取]],0,1,"lobby_bg_09","lobby_bg_sl_009",0,},
}

function BackGroundConfig.GetConfig(key)
	local tb = BackGroundConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["backgroundname"] = 2,["unlocking"] = 3,["display"] = 4,["tips"] = 5,["default"] = 6,["backgroundtype"] = 7,["backgroundres"] = 8,["thumbnail"] = 9,["nazo"] = 10,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return BackGroundConfig