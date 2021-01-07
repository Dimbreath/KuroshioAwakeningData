local InitialAwardsConfig = {}

InitialAwardsConfig.Values = {
	[1] = {1,"2,90011,1",48,0,},
}

function InitialAwardsConfig.GetConfig(key)
	local tb = InitialAwardsConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["rewards"] = 2,["countdown"] = 3,["nazo"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return InitialAwardsConfig