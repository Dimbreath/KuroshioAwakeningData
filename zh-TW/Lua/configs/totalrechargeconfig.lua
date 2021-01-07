local TotalrechargeConfig = {}

TotalrechargeConfig.Values = {
	[1] = {1,199,"1,260001,12;1,260002,12","commodity_totalrecharge_lv1",0,},
	[2] = {2,699,"1,135000,2000;1,260002,12","commodity_totalrecharge_lv2",0,},
	[3] = {3,1999,"1,240042,5;1,260002,24","commodity_totalrecharge_lv3",0,},
	[4] = {4,3599,"2,90010,1;1,260002,24","commodity_totalrecharge_lv4",0,},
	[5] = {5,5299,"1,145002,1800;1,145001,600","commodity_totalrecharge_lv5",0,},
	[6] = {6,8299,"1,250017,5;1,240203,5","commodity_totalrecharge_lv6",0,},
	[7] = {7,12299,"2,90011,3;1,240206,10","commodity_totalrecharge_lv7",0,},
}

function TotalrechargeConfig.GetConfig(key)
	local tb = TotalrechargeConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["num"] = 2,["reward"] = 3,["describe"] = 4,["nazo"] = 5,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return TotalrechargeConfig