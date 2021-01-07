local ProspectCoinConfig = {}

ProspectCoinConfig.Values = {
	[1] = {1,9999,1,1,"1,17,30",0,},
	[2] = {2,9999,2,1,"1,17,10",0,},
	[3] = {3,9999,3,1,"1,17,1",0,},
	[4] = {4,9999,4,60,"1,17,10",0,},
}

function ProspectCoinConfig.GetConfig(key)
	local tb = ProspectCoinConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["activity_id"] = 2,["channel"] = 3,["company"] = 4,["reward"] = 5,["nazo"] = 6,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return ProspectCoinConfig