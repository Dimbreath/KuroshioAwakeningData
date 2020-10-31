local AidPlanConfig = {
	[1] = {1,"1,160001,3;1,145301,60;1,143009,60;1,260002,12;1,260001,10;1,240021,5",
	},
	[2] = {2,"1,160001,2;1,240041,20;1,135000,500;1,260002,12;1,260001,10",
	},
	[3] = {3,"1,160001,1;1,240041,20;1,135000,500;1,260002,8;1,260001,5",
	},
	[4] = {4,"1,160001,1;1,240041,20;1,135000,500;1,260002,8;1,260001,5",
	},
	[5] = {5,"1,160001,1;1,240042,10;1,135000,500;1,260002,8;1,260001,5",
	},
	[6] = {6,"1,160001,3;1,240042,10;1,135000,1500;1,260002,12;1,260001,10",
	},
	[7] = {7,"1,160001,1;1,240042,10;1,135000,500;1,260002,8;1,260001,5",
	},

}
function AidPlanConfig.GetConfig(key)
	local Values = AidPlanConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["name"] = 2,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return AidPlanConfig