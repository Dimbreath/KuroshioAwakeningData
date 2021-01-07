local TurnInRewardConfig = {}

TurnInRewardConfig.Values = {
	[360001] = {360001,"1,2,5000;1,24,5000",2,2,},
	[360002] = {360002,"1,2,10000;1,24,10000",5,5,},
	[360003] = {360003,"1,2,20000;1,24,20000",10,10,},
}

function TurnInRewardConfig.GetConfig(key)
	local tb = TurnInRewardConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["itemid"] = 1,["reward"] = 2,["morale"] = 3,["integral"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return TurnInRewardConfig