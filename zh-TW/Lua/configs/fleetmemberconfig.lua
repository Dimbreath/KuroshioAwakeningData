local FleetMemberConfig = {}

FleetMemberConfig.Values = {
	[1] = {1,[[司令]],1,1,1,0,},
	[2] = {2,[[副司令]],2,0,1,0,},
	[3] = {3,[[精英]],5,0,0,0,},
	[4] = {4,[[普通成員]],29,0,0,0,},
}

function FleetMemberConfig.GetConfig(key)
	local tb = FleetMemberConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["title"] = 2,["membermax"] = 3,["admininfo"] = 4,["adminmember"] = 5,["nazo"] = 6,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return FleetMemberConfig