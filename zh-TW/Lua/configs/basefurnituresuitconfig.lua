local BaseFurnitureSuitConfig = {}

BaseFurnitureSuitConfig.Values = {
	[1] = {1,[[初始套裝]],2,"3,40;6,40;8,40;14,80",0,},
	[1001] = {1001,[[銀翼套裝]],3,"3,160;6,160;8,160;20,320",0,},
	[1002] = {1002,[[神代套裝]],3,"3,90;6,90;8,90;18,180",0,},
	[1003] = {1003,[[黑鋒套裝]],5,"3,530;6,530;8,530;19,1060",0,},
	[1004] = {1004,[[薔薇套裝]],4,"3,250;6,250;8,250;16,500",0,},
}

function BaseFurnitureSuitConfig.GetConfig(key)
	local tb = BaseFurnitureSuitConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["suitname"] = 2,["quality"] = 3,["suitbuff"] = 4,["nazo"] = 5,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return BaseFurnitureSuitConfig