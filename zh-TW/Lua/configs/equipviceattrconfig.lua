local EquipViceAttrConfig = {}

EquipViceAttrConfig.Values = {
	[3001] = {3001,1,"540,900",100,0,},
	[3002] = {3002,3,"36,60",100,0,},
	[3003] = {3003,8,"27,45",100,0,},
	[3004] = {3004,9,"126,210",100,0,},
	[3005] = {3005,28,"36,60",100,0,},
	[3006] = {3006,35,"108,180",100,0,},
	[3007] = {3007,36,"5,9",100,0,},
	[4001] = {4001,1,"720,1200",100,0,},
	[4002] = {4002,3,"48,80",100,0,},
	[4003] = {4003,8,"36,60",100,0,},
	[4004] = {4004,9,"168,280",100,0,},
	[4005] = {4005,28,"48,80",100,0,},
	[4006] = {4006,35,"144,240",100,0,},
	[4007] = {4007,36,"7,12",100,0,},
	[5001] = {5001,1,"900,1500",100,0,},
	[5002] = {5002,3,"60,100",100,0,},
	[5003] = {5003,8,"45,75",100,0,},
	[5004] = {5004,9,"210,350",100,0,},
	[5005] = {5005,28,"60,100",100,0,},
	[5006] = {5006,35,"180,300",100,0,},
	[5007] = {5007,36,"9,15",100,0,},
	[5101] = {5101,1,"1725,1725",100,0,},
	[5102] = {5102,3,"115,115",100,0,},
	[5103] = {5103,8,"86,86",100,0,},
	[5104] = {5104,9,"402,402",100,0,},
	[5105] = {5105,28,"115,115",100,0,},
	[5106] = {5106,35,"345,345",100,0,},
	[5107] = {5107,36,"17,17",100,0,},
}

function EquipViceAttrConfig.GetConfig(key)
	local tb = EquipViceAttrConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["attrname"] = 2,["values"] = 3,["weight"] = 4,["nazo"] = 5,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return EquipViceAttrConfig