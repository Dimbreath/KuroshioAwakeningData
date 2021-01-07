local ProspectItemConfig = {}

ProspectItemConfig.Values = {
	[1] = {1,1,1,1,0,999801,0,},
	[2] = {2,1,1,5,0,999802,0,},
	[3] = {3,1,5,1,0,999803,0,},
	[4] = {4,1,3,3,4,999806,0,},
	[5] = {5,2,3,3,0,999805,0,},
	[6] = {6,1,3,3,0,999804,0,},
	[7] = {7,2,5,5,0,999807,0,},
	[8] = {8,1,5,5,0,999808,0,},
}

function ProspectItemConfig.GetConfig(key)
	local tb = ProspectItemConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["iatticetype"] = 2,["iattice_x"] = 3,["iattice_y"] = 4,["iattice_random"] = 5,["coinexchangeid"] = 6,["nazo"] = 7,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return ProspectItemConfig