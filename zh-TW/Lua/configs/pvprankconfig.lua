local PvpRankConfig = {}

PvpRankConfig.Values = {
	[1] = {1,[[二等兵]],0,99,"common_1_pvprank_1","1",0,},
	[2] = {2,[[上等兵]],100,199,"common_1_pvprank_2","1.1",0,},
	[3] = {3,[[士官]],200,299,"common_1_pvprank_3","1.2",0,},
	[4] = {4,[[少尉]],300,599,"common_1_pvprank_4","1.3",0,},
	[5] = {5,[[中尉]],600,899,"common_1_pvprank_5","1.4",0,},
	[6] = {6,[[上尉]],900,1199,"common_1_pvprank_6","1.5",0,},
	[7] = {7,[[少校]],1200,1599,"common_1_pvprank_7","1.6",0,},
	[8] = {8,[[中校]],1600,1999,"common_1_pvprank_8","1.7",0,},
	[9] = {9,[[大校]],2000,2399,"common_1_pvprank_9","1.8",0,},
	[10] = {10,[[少將]],2400,3599,"common_1_pvprank_10","1.9",0,},
	[11] = {11,[[中將]],3600,4799,"common_1_pvprank_11","2",0,},
	[12] = {12,[[上將]],4800,14999,"common_1_pvprank_12","2.1",0,},
}

function PvpRankConfig.GetConfig(key)
	local tb = PvpRankConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["name"] = 2,["rankupcondition_min"] = 3,["rankupcondition_max"] = 4,["icon"] = 5,["exp_pro"] = 6,["nazo"] = 7,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return PvpRankConfig