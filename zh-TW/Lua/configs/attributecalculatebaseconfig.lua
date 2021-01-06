local AttributeCalculateBaseConfig = {}

AttributeCalculateBaseConfig.Values = {
	[1] = {1,[[人偶升級]],1,1,1,1,0,},
	[2] = {2,[[人偶強化]],1,1,1,1,0,},
	[3] = {3,[[人偶突破]],1,1,1,1,0,},
	[4] = {4,[[誓約絕對值]],3,1,1,1,0,},
	[5] = {5,[[誓約buff]],2,2,2,2,0,},
	[6] = {6,[[裝備絕對值]],3,1,1,1,0,},
	[7] = {7,[[裝備buff]],2,2,2,2,0,},
	[8] = {8,[[心情值絕對值]],3,1,1,1,0,},
	[9] = {9,[[心情值buff]],4,2,2,2,0,},
	[10] = {10,[[羈絆絕對值]],3,1,1,1,0,},
	[11] = {11,[[羈絆buff]],4,2,2,2,0,},
	[12] = {12,[[slg buff 絕對值]],3,1,1,1,0,},
	[13] = {13,[[slg buff 千分值]],4,2,2,2,0,},
	[14] = {14,[[技能絕對值]],3,1,1,1,0,},
	[15] = {15,[[技能buff]],4,2,2,2,0,},
	[16] = {16,[[GM絕對值]],1,1,1,1,0,},
	[17] = {17,"GM Buff",2,2,2,2,0,},
}

function AttributeCalculateBaseConfig.GetConfig(key)
	local tb = AttributeCalculateBaseConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["name"] = 2,["calctypecn"] = 3,["calctypetw"] = 4,["calctypeen"] = 5,["calctypejp"] = 6,["nazo"] = 7,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return AttributeCalculateBaseConfig