local NewYearIntegralConfig = {}

NewYearIntegralConfig.Values = {
	[0] = {0,1,},
	[1000] = {1000,3,},
	[1500] = {1500,4,},
	[2000] = {2000,5,},
	[500] = {500,2,},
}

function NewYearIntegralConfig.GetConfig(key)
	local tb = NewYearIntegralConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["integral"] = 1,["coin"] = 2,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return NewYearIntegralConfig