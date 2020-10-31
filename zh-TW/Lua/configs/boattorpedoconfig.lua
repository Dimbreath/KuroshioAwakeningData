local BoatTorpedoConfig = {
	[1] = {1,
		[[航母]],
	},
	[2] = {2,
		[[輕航]],
	},
	[3] = {3,
		[[輕巡]],
	},
	[4] = {4,
		[[重巡]],
	},
	[5] = {5,
		[[驅逐]],
	},
	[6] = {6,
		[[戰艦]],
	},
	[7] = {7,
		[[其他]],
	},
	[8] = {8,
		[[暫留]],
	},

}
function BoatTorpedoConfig.GetConfig(key)
	local Values = BoatTorpedoConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["name"] = 2,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return BoatTorpedoConfig