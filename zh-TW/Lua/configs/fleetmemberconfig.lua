local FleetMemberConfig = {
	[1] = {1,1,1,1,
		[[司令]],
	},
	[2] = {2,2,0,1,
		[[副司令]],
	},
	[3] = {3,5,0,0,
		[[精英]],
	},
	[4] = {4,29,0,0,
		[[普通成員]],
	},

}
function FleetMemberConfig.GetConfig(key)
	local Values = FleetMemberConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["membermax"] = 2,["admininfo"] = 3,["adminmember"] = 4,["title"] = 5,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return FleetMemberConfig