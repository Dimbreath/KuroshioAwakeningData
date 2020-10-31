local TotalrechargeConfig = {
	[1] = {1,199,"1,260001,12;1,260002,12","commodity_totalrecharge_lv1",
	},
	[2] = {2,699,"1,135000,2000;1,260002,12","commodity_totalrecharge_lv2",
	},
	[3] = {3,1999,"1,240042,5;1,260002,24","commodity_totalrecharge_lv3",
	},
	[4] = {4,3599,"2,90010,1;1,260002,24","commodity_totalrecharge_lv4",
	},
	[5] = {5,5299,"1,145002,1800;1,145001,600","commodity_totalrecharge_lv5",
	},
	[6] = {6,8299,"1,250017,5;1,240203,5","commodity_totalrecharge_lv6",
	},
	[7] = {7,12299,"2,90011,3;1,240206,10","commodity_totalrecharge_lv7",
	},

}
function TotalrechargeConfig.GetConfig(key)
	local Values = TotalrechargeConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["num"] = 2,["reward"] = 3,["describe"] = 4,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return TotalrechargeConfig