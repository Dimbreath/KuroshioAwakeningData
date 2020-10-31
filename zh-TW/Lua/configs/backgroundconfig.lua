local BackGroundConfig = {
	[1] = {1,1,1,1,1,"lobby_bg_01","lobby_bg_sl_001",
		[[港口基地]],
		[[]],
	},
	[2] = {2,0,0,0,2,"bg_1_battle_003","bg_1_battle_003",
		[[港口基地-秋日]],
		[[暫無獲取途徑]],
	},
	[3] = {3,0,0,0,1,"lobby_bg_01","bg_1_battle_003",
		[[港口基地-春分]],
		[[暫無獲取途徑]],
	},
	[4] = {4,0,0,0,2,"bg_1_battle_004","bg_1_battle_004",
		[[港口基地-夏至]],
		[[暫無獲取途徑]],
	},
	[5] = {5,0,0,0,1,"lobby_bg_05","lobby_bg_sl_005",
		[[黑鋒重工]],
		[[暫無獲取途徑]],
	},
	[6] = {6,0,0,0,1,"lobby_bg_06","lobby_bg_sl_006",
		[[薔薇帝國]],
		[[暫無獲取途徑]],
	},
	[7] = {7,0,0,0,1,"lobby_bg_07","lobby_bg_sl_007",
		[[神代會社]],
		[[暫無獲取途徑]],
	},
	[8] = {8,0,1,0,1,"lobby_bg_08","lobby_bg_sl_008",
		[[銀翼財團]],
		[[追念之井限時禮包獲取]],
	},

}
function BackGroundConfig.GetConfig(key)
	local Values = BackGroundConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["unlocking"] = 2,["display"] = 3,["default"] = 4,["backgroundtype"] = 5,["backgroundres"] = 6,["thumbnail"] = 7,["backgroundname"] = 8,["tips"] = 9,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return BackGroundConfig