local MissionsEventConfig = {}

MissionsEventConfig.Values = {
	[1] = {1,1,9002,"23001;23011",0,},
	[2] = {2,1,9003,"23002;23021",0,},
	[3] = {3,1,9004,"23003;23031",0,},
	[4] = {4,1,9005,"23004;23041",0,},
	[5] = {5,1,9006,"23005;23051",0,},
	[6] = {6,1,9007,"23006;23061",0,},
	[7] = {7,1,9008,"23007;23071",0,},
}

function MissionsEventConfig.GetConfig(key)
	local tb = MissionsEventConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["batch"] = 2,["storygroupid"] = 3,["taskid"] = 4,["nazo"] = 5,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return MissionsEventConfig