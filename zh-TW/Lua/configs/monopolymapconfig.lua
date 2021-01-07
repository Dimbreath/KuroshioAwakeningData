local MonopolyMapConfig = {}

MonopolyMapConfig.Values = {
	[1] = {1,20,"6,6","1,2,100000",2,"common_3019100","8102,8103",0,},
	[2] = {2,24,"6,6","1,3,100",2,"common_5003000","8104,8105,8106",0,},
	[3] = {3,28,"7,7","1,240206,1",2,"common_5043000","8107,8108,8109,8110",0,},
}

function MonopolyMapConfig.GetConfig(key)
	local tb = MonopolyMapConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["floorid"] = 1,["pointcount"] = 2,["wh"] = 3,["reward"] = 4,["currency"] = 5,["spineasset"] = 6,["plot"] = 7,["nazo"] = 8,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return MonopolyMapConfig