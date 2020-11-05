local NDaysLoginConfig = {
	[1] = {1,"1,160001,1;1,260002,20",0,
	},
	[2] = {2,"1,2,50000;1,1,100",0,
	},
	[3] = {3,"1,160001,1;1,145002,1200",0,
	},
	[4] = {4,"1,240042,2;1,260001,20",0,
	},
	[5] = {5,"1,145001,400;1,1,100",0,
	},
	[6] = {6,"1,240021,1;1,260001,20",0,
	},
	[7] = {7,"1,160001,1;1,240021,1",0,
	},

}
function NDaysLoginConfig.GetConfig(key)
	local Values = NDaysLoginConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["rewards"] = 2,["specialawards"] = 3,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return NDaysLoginConfig