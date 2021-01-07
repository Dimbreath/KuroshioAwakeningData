local LimitConfigConfig = {}

LimitConfigConfig.Values = {
	["doll_max"] = {"doll_max",2,0,0,0,"limit_tips_doll",40,63100,0,},
	["equip_max"] = {"equip_max",6,0,2000,3000,"limit_tips_equip",66,10028,0,},
	["oil_max"] = {"oil_max",1,3,2000000,3000000,"limit_tips_oil",1000,10040,0,},
	["coin_max"] = {"coin_max",1,2,999999999,1999999999,"limit_tips_bp",101,10038,0,},
	["diamond_max"] = {"diamond_max",1,1,50000000,60000000,"limit_tips_diamond",203,10039,0,},
}

function LimitConfigConfig.GetConfig(key)
	local tb = LimitConfigConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["key"] = 1,["type"] = 2,["id"] = 3,["value"] = 4,["buffer"] = 5,["defaultkey"] = 6,["sourceid"] = 7,["errcode"] = 8,["nazo"] = 9,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return LimitConfigConfig