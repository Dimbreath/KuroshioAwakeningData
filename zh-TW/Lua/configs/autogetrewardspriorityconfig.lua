local AutoGetrewardsPriorityConfig = {}

AutoGetrewardsPriorityConfig.Values = {
	[1] = {1,[[功能開啟]],1,1,0,'',0,0,0,0,},
	[2] = {2,[[月簽到]],1,2,0,'',0,0,0,0,},
	[3] = {3,[[追憶前夕]],1,3,1,"40",1,2,1,0,},
	[4] = {4,[[虛海之約]],1,3,1,"52",1,2,2,0,},
	[5] = {5,[[魚潮禮祭]],1,3,1,"54",1,2,3,0,},
	[6] = {6,[[逐風拂曉]],1,3,1,"80",1,2,4,0,},
}

function AutoGetrewardsPriorityConfig.GetConfig(key)
	local tb = AutoGetrewardsPriorityConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["name"] = 2,["open"] = 3,["type"] = 4,["activitytype"] = 5,["parameter"] = 6,["jumpmode"] = 7,["jumptype"] = 8,["priority"] = 9,["nazo"] = 10,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return AutoGetrewardsPriorityConfig