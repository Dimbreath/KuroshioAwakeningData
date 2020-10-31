local MonopolyMapConfig = {
	[1] = {1,20,"6,6","1,2,100000",2,"common_3019100","8102,8103",
	},
	[2] = {2,24,"6,6","1,3,100",2,"common_5003000","8104,8105,8106",
	},
	[3] = {3,28,"7,7","1,240206,1",2,"common_5043000","8107,8108,8109,8110",
	},

}
function MonopolyMapConfig.GetConfig(key)
	local Values = MonopolyMapConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["floorid"] = 1,["pointcount"] = 2,["wh"] = 3,["reward"] = 4,["currency"] = 5,["spineasset"] = 6,["plot"] = 7,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return MonopolyMapConfig