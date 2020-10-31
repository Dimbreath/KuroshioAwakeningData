local ActivityTaskConfig = {
	[21] = {21,15,"15001,15002,15003,15004,15005,15006,15007,15008,15101,15102,15103,15104,15105,15106,15107,15108,15109,15110,15301,15302,15303,15304,15305,15306,15307,15308,15309",
	},
	[22] = {22,15,"15001,15002,15003,15004,15005,15006,15007,15008,15101,15102,15103,15104,15105,15106,15107,15108,15109,15110,15301,15302,15303,15304,15305,15306,15307,15308,15309",
	},

}
function ActivityTaskConfig.GetConfig(key)
	local Values = ActivityTaskConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["activityid"] = 1,["activitytype"] = 2,["task"] = 3,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return ActivityTaskConfig