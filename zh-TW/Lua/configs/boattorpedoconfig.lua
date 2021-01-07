local BoatTorpedoConfig = {}

BoatTorpedoConfig.Values = {
	[1] = {1,[[航母]],0,},
	[2] = {2,[[輕航]],0,},
	[3] = {3,[[輕巡]],0,},
	[4] = {4,[[重巡]],0,},
	[5] = {5,[[驅逐]],0,},
	[6] = {6,[[戰艦]],0,},
	[7] = {7,[[其他]],0,},
	[8] = {8,[[暫留]],0,},
}

function BoatTorpedoConfig.GetConfig(key)
	local tb = BoatTorpedoConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["name"] = 2,["nazo"] = 3,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return BoatTorpedoConfig