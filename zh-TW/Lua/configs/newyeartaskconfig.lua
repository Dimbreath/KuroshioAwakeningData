local NewYearTaskConfig = {}

NewYearTaskConfig.Values = {
	[78] = {78,15,"27001,27002,27003,27004,27005,27006",0,},
	[79] = {79,15,"27001,27002,27003,27004,27005,27006",0,},
}

function NewYearTaskConfig.GetConfig(key)
	local tb = NewYearTaskConfig.Values[key]
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
return NewYearTaskConfig