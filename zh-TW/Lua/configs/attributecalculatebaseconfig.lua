local AttributeCalculateBaseConfig = {
	[1] = {1,1,1,1,1,
		[[人偶升級]],
	},
	[2] = {2,1,1,1,1,
		[[人偶強化]],
	},
	[3] = {3,1,1,1,1,
		[[人偶突破]],
	},
	[4] = {4,3,1,1,1,
		[[誓約絕對值]],
	},
	[5] = {5,2,2,2,2,
		[[誓約buff]],
	},
	[6] = {6,3,1,1,1,
		[[裝備絕對值]],
	},
	[7] = {7,2,2,2,2,
		[[裝備buff]],
	},
	[8] = {8,3,1,1,1,
		[[心情值絕對值]],
	},
	[9] = {9,4,2,2,2,
		[[心情值buff]],
	},
	[10] = {10,3,1,1,1,
		[[羈絆絕對值]],
	},
	[11] = {11,4,2,2,2,
		[[羈絆buff]],
	},
	[12] = {12,3,1,1,1,
		[[slg buff 絕對值]],
	},
	[13] = {13,4,2,2,2,
		[[slg buff 千分值]],
	},
	[14] = {14,3,1,1,1,
		[[技能絕對值]],
	},
	[15] = {15,4,2,2,2,
		[[技能buff]],
	},
	[16] = {16,1,1,1,1,
		[[GM絕對值]],
	},
	[17] = {17,2,2,2,2,
		[[GM Buff]],
	},

}
function AttributeCalculateBaseConfig.GetConfig(key)
	local Values = AttributeCalculateBaseConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["calctypecn"] = 2,["calctypetw"] = 3,["calctypeen"] = 4,["calctypejp"] = 5,["name"] = 6,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return AttributeCalculateBaseConfig