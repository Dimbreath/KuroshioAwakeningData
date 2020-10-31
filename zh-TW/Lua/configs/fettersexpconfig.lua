local FettersExpConfig = {
	[1] = {1,500,1000,
	},
	[2] = {2,700,1100,
	},
	[3] = {3,900,1200,
	},
	[4] = {4,1100,1300,
	},
	[5] = {5,1300,1400,
	},
	[6] = {6,1500,1500,
	},
	[7] = {7,2500,1600,
	},
	[8] = {8,3000,1700,
	},
	[9] = {9,3500,1800,
	},
	[10] = {10,0,2000,
	},

}
function FettersExpConfig.GetConfig(key)
	local Values = FettersExpConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["fetterslevel"] = 1,["exptonextlevel"] = 2,["attrcoefficient"] = 3,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return FettersExpConfig