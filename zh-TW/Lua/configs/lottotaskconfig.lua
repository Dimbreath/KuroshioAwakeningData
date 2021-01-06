local LottoTaskConfig = {}

LottoTaskConfig.Values = {
	[1] = {1,40101,40,120,'',},
	[2] = {1,40102,30,30,'',},
	[3] = {1,40103,30,10,'',},
	[4] = {2,40104,40,10,'',},
	[5] = {2,40105,30,20,'',},
	[6] = {2,40106,20,30,'',},
	[7] = {2,40107,15,40,'',},
	[8] = {2,40108,100,12,'',},
	[9] = {2,40109,50,18,'',},
	[10] = {2,40110,30,24,'',},
	[11] = {2,40111,20,30,'',},
	[12] = {3,40112,100,6,'',},
	[13] = {3,40113,50,12,'',},
	[14] = {3,40114,30,18,'',},
	[15] = {3,40115,20,24,'',},
	[16] = {3,40116,100,4,'',},
	[17] = {3,40117,50,6,'',},
	[18] = {3,40118,30,8,'',},
	[19] = {3,40119,20,10,'',},
}

function LottoTaskConfig.GetConfig(key)
	local tb = LottoTaskConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["groupid"] = 1,["taskid"] = 2,["weight"] = 3,["integral"] = 4,["refresh"] = 5,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return LottoTaskConfig