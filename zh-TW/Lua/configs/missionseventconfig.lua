local MissionsEventConfig = {
	[1] = {1,1,9002,"23001;23011",
	},
	[2] = {2,1,9003,"23002;23021",
	},
	[3] = {3,1,9004,"23003;23031",
	},
	[4] = {4,1,9005,"23004;23041",
	},
	[5] = {5,1,9006,"23005;23051",
	},
	[6] = {6,1,9007,"23006;23061",
	},
	[7] = {7,1,9008,"23007;23071",
	},

}
function MissionsEventConfig.GetConfig(key)
	local Values = MissionsEventConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["batch"] = 2,["storygroupid"] = 3,["taskid"] = 4,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return MissionsEventConfig