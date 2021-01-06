local TurnInRewardConfig = {}

TurnInRewardConfig.Values = {
	[360001] = {360001,"3,24040,1",10,10,},
	[360002] = {360002,"3,24040,1",20,20,},
	[360003] = {360003,"3,24040,1",50,50,},
}

function TurnInRewardConfig.GetConfig(key)
	local tb = TurnInRewardConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["itemid"] = 1,["reward"] = 2,["morale"] = 3,["integral"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return TurnInRewardConfig