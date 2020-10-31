local WorldMapConfig = {
	[1] = {1,0.2,0,0,0,1,1,0,1,1,0,2,2,2,2,0,0,1,
	},
	[2] = {2,0.5,0,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,
	},
	[3] = {3,0,1,1,1,1,1,1,1,1,0,1,1,1,1,0,1,1,
	},

}
function WorldMapConfig.GetConfig(key)
	local Values = WorldMapConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["continentid"] = 1,["mapratio"] = 2,["uibutton1"] = 3,["uibutton2"] = 4,["uibutton3"] = 5,["uibutton4"] = 6,["uibutton5"] = 7,["uibutton6"] = 8,["uibutton7"] = 9,["uibutton8"] = 10,["continent1"] = 11,["continent2"] = 12,["continent4"] = 13,["continent5"] = 14,["continent6"] = 15,["landtag"] = 16,["harbourtag"] = 17,["menulist"] = 18,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return WorldMapConfig