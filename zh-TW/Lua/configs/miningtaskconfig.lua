local MiningTaskConfig = {
	[1] = {1,2,1,"0","30501,30502,30503,30504,30505,30506,30507,30508,30509,30510",
		[[高級任務]],
	},
	[2] = {2,1,2,"0","30001,30002,30003",
		[[每日任務]],
	},
	[3] = {3,1,3,"1","30101,30102,30103",
		[[第一週]],
	},
	[4] = {4,1,3,"2","30201,30202,30203",
		[[第二週]],
	},
	[5] = {5,1,3,"3","30301,30302,30303",
		[[第三週]],
	},
	[6] = {6,1,3,"4","30401,30402,30403",
		[[第四週]],
	},

}
function MiningTaskConfig.GetConfig(key)
	local Values = MiningTaskConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["paytask"] = 2,["type"] = 3,["parameter"] = 4,["task"] = 5,["name"] = 6,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return MiningTaskConfig