local BaseFurnitureSuitConfig = {
	[1] = {1,2,"3,40;6,40;8,40;14,80",
		[[初始套裝]],
	},
	[1001] = {1001,3,"3,160;6,160;8,160;20,320",
		[[銀翼套裝]],
	},
	[1002] = {1002,3,"3,90;6,90;8,90;18,180",
		[[神代套裝]],
	},
	[1003] = {1003,5,"3,530;6,530;8,530;19,1060",
		[[黑鋒套裝]],
	},
	[1004] = {1004,4,"3,250;6,250;8,250;16,500",
		[[薔薇套裝]],
	},

}
function BaseFurnitureSuitConfig.GetConfig(key)
	local Values = BaseFurnitureSuitConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["quality"] = 2,["suitbuff"] = 3,["suitname"] = 4,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return BaseFurnitureSuitConfig