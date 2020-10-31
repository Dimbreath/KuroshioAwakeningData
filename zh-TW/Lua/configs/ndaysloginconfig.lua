local NDaysLoginConfig = {
	[1] = {1,"1,160001,2;1,260002,12",0,
	},
	[2] = {2,"1,240021,2;1,1,100",0,
	},
	[3] = {3,"2,90010,1;1,240006,20",1,
	},
	[4] = {4,"1,3,300;1,260002,12",0,
	},
	[5] = {5,"1,240021,2;1,1,200",0,
	},
	[6] = {6,"1,3,500;1,160001,2",0,
	},
	[7] = {7,"2,90011,1;1,260002,12",1,
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