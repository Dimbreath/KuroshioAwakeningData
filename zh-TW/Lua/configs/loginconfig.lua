local LoginConfig = {
	[1] = {1,"2,90010,2;1,3,300",0,
	},
	[2] = {2,"1,280005,1;1,240021,2",0,
	},
	[3] = {3,"1,160001,10;1,1,500",0,
	},
	[4] = {4,"1,240042,2;1,135000,5000",0,
	},
	[5] = {5,"2,90011,1;1,240020,1",0,
	},
	[6] = {6,"5,950006,1;1,3,360",0,
	},
	[7] = {7,"2,60050,1;1,1,1000",1,
	},

}
function LoginConfig.GetConfig(key)
	local Values = LoginConfig[key]
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
return LoginConfig