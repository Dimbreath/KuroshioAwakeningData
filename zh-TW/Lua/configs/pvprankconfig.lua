local PvpRankConfig = {
	[1] = {1,0,100,"common_1_pvprank_1","1",
		[[二等兵]],
	},
	[2] = {2,101,200,"common_1_pvprank_2","1.1",
		[[上等兵]],
	},
	[3] = {3,201,300,"common_1_pvprank_3","1.2",
		[[士官]],
	},
	[4] = {4,301,600,"common_1_pvprank_4","1.3",
		[[少尉]],
	},
	[5] = {5,601,900,"common_1_pvprank_5","1.4",
		[[中尉]],
	},
	[6] = {6,901,1200,"common_1_pvprank_6","1.5",
		[[上尉]],
	},
	[7] = {7,1201,1600,"common_1_pvprank_7","1.6",
		[[少校]],
	},
	[8] = {8,1601,2000,"common_1_pvprank_8","1.7",
		[[中校]],
	},
	[9] = {9,2001,2400,"common_1_pvprank_9","1.8",
		[[大校]],
	},
	[10] = {10,2401,3600,"common_1_pvprank_10","1.9",
		[[少將]],
	},
	[11] = {11,3601,4800,"common_1_pvprank_11","2",
		[[中將]],
	},
	[12] = {12,4801,15000,"common_1_pvprank_12","2.1",
		[[上將]],
	},

}
function PvpRankConfig.GetConfig(key)
	local Values = PvpRankConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["rankupcondition_min"] = 2,["rankupcondition_max"] = 3,["icon"] = 4,["exp_pro"] = 5,["name"] = 6,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return PvpRankConfig