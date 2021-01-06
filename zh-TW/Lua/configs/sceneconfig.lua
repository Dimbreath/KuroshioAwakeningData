local SceneConfig = {}

SceneConfig.Values = {
	[1] = {1,"Login","1",0,},
	[2] = {2,"Lobby","2",0,},
	[3] = {3,"SLG","3",0,},
	[4] = {4,"Battle","4",0,},
	[5] = {5,"BattleAutoTest","4",0,},
}

function SceneConfig.GetConfig(key)
	local tb = SceneConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["assetname"] = 2,["backgroundmusicid"] = 3,["nazo"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return SceneConfig