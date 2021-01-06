local DayRankRewardConfig = {}

DayRankRewardConfig.Values = {
	[1] = {1,1,"1,1,1000",130006,},
	[2] = {2,10,"1,1,500",130006,},
	[11] = {11,100,"1,1,100",130006,},
	[0] = {0,0,"1,1,50",130007,},
}

function DayRankRewardConfig.GetConfig(key)
	local tb = DayRankRewardConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["upperlimit"] = 1,["lowerlimit"] = 2,["reward"] = 3,["mailid"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return DayRankRewardConfig