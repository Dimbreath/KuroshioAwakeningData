local OccupyOutputadditionConfig = {}

OccupyOutputadditionConfig.Values = {
	[1] = {1,1,"1,10",0,},
	[2] = {2,2,"1,0;3,0;4,0;5,0",0,},
	[3] = {3,3,"1,0",0,},
}

function OccupyOutputadditionConfig.GetConfig(key)
	local tb = OccupyOutputadditionConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["type"] = 2,["addition"] = 3,["nazo"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return OccupyOutputadditionConfig