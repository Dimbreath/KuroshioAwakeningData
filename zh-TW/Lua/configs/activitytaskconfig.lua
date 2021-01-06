local ActivityTaskConfig = {}

ActivityTaskConfig.Values = {
	[21] = {21,15,"15001,15002,15003,15004,15005,15006,15007,15008,15101,15102,15103,15104,15105,15106,15107,15108,15109,15110,15301,15302,15303,15304,15305,15306,15307,15308,15309",0,},
	[22] = {22,15,"15001,15002,15003,15004,15005,15006,15007,15008,15101,15102,15103,15104,15105,15106,15107,15108,15109,15110,15301,15302,15303,15304,15305,15306,15307,15308,15309",0,},
}

function ActivityTaskConfig.GetConfig(key)
	local tb = ActivityTaskConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["activityid"] = 1,["activitytype"] = 2,["task"] = 3,["nazo"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return ActivityTaskConfig