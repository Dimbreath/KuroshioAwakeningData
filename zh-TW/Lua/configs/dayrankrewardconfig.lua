local DayRankRewardConfig = {}

DayRankRewardConfig.Values = {
	[1] = {1,1,"1,240042,5",130009,},
	[2] = {2,10,"1,240042,3",130009,},
	[11] = {11,100,"1,240042,2",130009,},
	[0] = {0,0,"1,240042,1",130011,},
}

function DayRankRewardConfig.GetConfig(key)
	local tb = DayRankRewardConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["upperlimit"] = 1,["lowerlimit"] = 2,["reward"] = 3,["mailid"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return DayRankRewardConfig