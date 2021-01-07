local DelayRecruitConfig = {}

DelayRecruitConfig.Values = {
	[101] = {101,"0",1800,"2,3","1,160002,1",0,},
	[102] = {102,"0",3600,"2,3,4","1,160002,2",0,},
	[103] = {103,"0",7200,"2,3,4","1,160002,3",0,},
	[104] = {104,"0",14400,"2,3,4,5","1,160002,6",0,},
	[105] = {105,"0",21600,"2,3,4,5","1,160002,10",0,},
}

function DelayRecruitConfig.GetConfig(key)
	local tb = DelayRecruitConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["groupid"] = 1,["cost01"] = 2,["time"] = 3,["quality"] = 4,["cost02"] = 5,["nazo"] = 6,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return DelayRecruitConfig