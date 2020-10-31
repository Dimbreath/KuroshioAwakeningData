local BattleMapBuffConfig = {
	[1] = {1,9,"3,1",2,15,"battle_1_icon_buff_2002","9,2,150",
	},
	[2] = {2,8,"3,1",2,15,"battle_1_icon_buff_2005","8,2,150",
	},
	[3] = {3,2,"3,1",2,10,"battle_1_icon_buff_2001","2,2,100",
	},
	[4] = {4,2,"3,1",2,10,"battle_1_icon_buff_2001","2,2,100",
	},
	[5] = {5,2,"3,1",2,10,"battle_1_icon_buff_2001","2,2,100",
	},
	[6] = {6,28,"3,1",2,15,"battle_1_icon_buff_2003","28,2,150",
	},
	[7] = {7,8,"3,1",2,15,"battle_1_icon_buff_2005","8,2,150",
	},
	[8] = {8,2,"3,1",2,10,"battle_1_icon_buff_2001","2,2,100",
	},
	[9] = {9,8,"3,1",2,10,"battle_1_icon_buff_2005","8,2,100",
	},
	[10] = {10,2,"3,1",2,10,"battle_1_icon_buff_2001","2,2,100",
	},
	[11] = {11,9,"3,1",2,20,"battle_1_icon_buff_2002","9,2,200",
	},
	[12] = {12,8,"3,1",2,20,"battle_1_icon_buff_2005","8,2,200",
	},
	[13] = {13,2,"3,1",2,15,"battle_1_icon_buff_2001","2,2,150",
	},

}
function BattleMapBuffConfig.GetConfig(key)
	local Values = BattleMapBuffConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["bufftype"] = 2,["target"] = 3,["numtype"] = 4,["num"] = 5,["icon"] = 6,["buffeffect"] = 7,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return BattleMapBuffConfig