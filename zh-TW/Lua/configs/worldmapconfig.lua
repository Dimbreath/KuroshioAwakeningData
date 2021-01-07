local WorldMapConfig = {}

WorldMapConfig.Values = {
	[1] = {1,0.2,0,0,0,1,1,0,1,1,0,2,2,2,2,0,0,1,0,},
	[2] = {2,0.5,0,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,0,},
	[3] = {3,0,1,1,1,1,1,1,1,1,0,1,1,1,1,0,1,1,0,},
}

function WorldMapConfig.GetConfig(key)
	local tb = WorldMapConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["continentid"] = 1,["mapratio"] = 2,["uibutton1"] = 3,["uibutton2"] = 4,["uibutton3"] = 5,["uibutton4"] = 6,["uibutton5"] = 7,["uibutton6"] = 8,["uibutton7"] = 9,["uibutton8"] = 10,["continent1"] = 11,["continent2"] = 12,["continent4"] = 13,["continent5"] = 14,["continent6"] = 15,["landtag"] = 16,["harbourtag"] = 17,["menulist"] = 18,["nazo"] = 19,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return WorldMapConfig