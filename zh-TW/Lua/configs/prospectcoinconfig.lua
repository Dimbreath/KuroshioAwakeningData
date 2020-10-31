local ProspectCoinConfig = {
	[1] = {1,9999,1,1,"1,17,30",
	},
	[2] = {2,9999,2,1,"1,17,10",
	},
	[3] = {3,9999,3,1,"1,17,1",
	},
	[4] = {4,9999,4,60,"1,17,10",
	},

}
function ProspectCoinConfig.GetConfig(key)
	local Values = ProspectCoinConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["activity_id"] = 2,["channel"] = 3,["company"] = 4,["reward"] = 5,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return ProspectCoinConfig