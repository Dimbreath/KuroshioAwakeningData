local MiningTaskConfig = {}

MiningTaskConfig.Values = {
	[1] = {1,[[高級任務]],2,1,"0","30501,30502,30503,30504,30505,30506,30507,30508,30509,30510",0,},
	[2] = {2,[[每日任務]],1,2,"0","30001,30002,30003",0,},
	[3] = {3,[[第一週]],1,3,"1","30101,30102,30103",0,},
	[4] = {4,[[第二週]],1,3,"2","30201,30202,30203",0,},
	[5] = {5,[[第三週]],1,3,"3","30301,30302,30303",0,},
	[6] = {6,[[第四週]],1,3,"4","30401,30402,30403",0,},
}

function MiningTaskConfig.GetConfig(key)
	local tb = MiningTaskConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["name"] = 2,["paytask"] = 3,["type"] = 4,["parameter"] = 5,["task"] = 6,["nazo"] = 7,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return MiningTaskConfig