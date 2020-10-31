local ExpeditionSiteConfig = {
	[1] = {1,298,371,
	},
	[2] = {2,342,617,
	},
	[3] = {3,640,440,
	},
	[4] = {4,713,181,
	},
	[5] = {5,791,783,
	},
	[6] = {6,1033,551,
	},
	[7] = {7,1056,246,
	},
	[8] = {8,1070,722,
	},

}
function ExpeditionSiteConfig.GetConfig(key)
	local Values = ExpeditionSiteConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["siteid"] = 1,["x"] = 2,["y"] = 3,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return ExpeditionSiteConfig