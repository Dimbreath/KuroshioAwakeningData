local ChristmasrewardConfig = {}

ChristmasrewardConfig.Values = {
	[4294967297] = {1,1,"1,240203,1",0,},
	[4294967298] = {1,2,"1,240042,1",0,},
	[4294967299] = {1,3,"2,90010,1",0,},
	[4294967300] = {1,4,"1,160001,1",0,},
	[8589934593] = {2,1,"1,240203,1",0,},
	[8589934594] = {2,2,"1,240042,1",0,},
	[8589934595] = {2,3,"2,90010,1",0,},
	[8589934596] = {2,4,"1,160001,1",0,},
}

function ChristmasrewardConfig.GetConfig(key)
	local tb = ChristmasrewardConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["plotid"] = 1,["id"] = 2,["itemid"] = 3,["nazo"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return ChristmasrewardConfig