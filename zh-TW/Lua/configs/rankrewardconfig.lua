local RankRewardConfig = {}

RankRewardConfig.Values = {
	[1] = {1,1,"1,160001,10",130010,},
	[2] = {2,10,"1,160001,5",130010,},
	[11] = {11,100,"1,160001,2",130010,},
	[0] = {0,0,"1,160001,1",130012,},
}

function RankRewardConfig.GetConfig(key)
	local tb = RankRewardConfig.Values[key]
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
return RankRewardConfig