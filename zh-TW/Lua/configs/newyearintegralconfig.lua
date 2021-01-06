local NewYearIntegralConfig = {}

NewYearIntegralConfig.Values = {
	[0] = {0,5,},
	[10] = {10,10,},
	[20] = {20,20,},
}

function NewYearIntegralConfig.GetConfig(key)
	local tb = NewYearIntegralConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["integral"] = 1,["coin"] = 2,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return NewYearIntegralConfig