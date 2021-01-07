local GlobalBuffConfig = {}

GlobalBuffConfig.Values = {
	[1] = {1,false,1,0.1,'',0,},
	[2] = {2,false,2,0.05,'',0,},
	[3] = {3,false,3,0.05,'',0,},
	[4] = {4,false,4,0.2,'',0,},
	[5] = {5,false,5,0.05,'',0,},
	[6] = {6,false,6,10,'',0,},
}

function GlobalBuffConfig.GetConfig(key)
	local tb = GlobalBuffConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["superposition"] = 2,["type"] = 3,["value"] = 4,["ext"] = 5,["nazo"] = 6,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return GlobalBuffConfig