local OpenRewardConfig = {}

OpenRewardConfig.Values = {
	[360001] = {360001,"3,24044,1","3,24040,1",10,},
	[360002] = {360002,"3,24045,1","3,24041,1",10,},
	[360003] = {360003,"3,24046,1","3,24042,1",10,},
}

function OpenRewardConfig.GetConfig(key)
	local tb = OpenRewardConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["itemid"] = 1,["normalreward"] = 2,["seniorreward"] = 3,["num"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return OpenRewardConfig