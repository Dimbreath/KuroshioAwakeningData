local IntervalRewardsConfig = {}

IntervalRewardsConfig.Values = {
	[1] = {1,"1100;400","1,3,120;1,260002,5",0,},
	[2] = {2,"1600;400","1,3,120;1,260002,5",0,},
}

function IntervalRewardsConfig.GetConfig(key)
	local tb = IntervalRewardsConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["countdown"] = 2,["rewards"] = 3,["nazo"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return IntervalRewardsConfig