local OccupyOutputadditionConfig = {
	[1] = {1,1,"1,10",
	},
	[2] = {2,2,"1,0;3,0;4,0;5,0",
	},
	[3] = {3,3,"1,0",
	},

}
function OccupyOutputadditionConfig.GetConfig(key)
	local Values = OccupyOutputadditionConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["type"] = 2,["addition"] = 3,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return OccupyOutputadditionConfig