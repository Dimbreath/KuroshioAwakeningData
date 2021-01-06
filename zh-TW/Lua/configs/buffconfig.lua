local BuffConfig = {}

BuffConfig.Values = {
	[1] = {1,1,"1,2,100","3,1","battle_1_icon_buff_2001",1,15001,'',},
	[2] = {2,1,"1,1,1000","3,1","battle_1_icon_buff_2002",2,0,'',},
	[3] = {3,2,"1,2,100","3,1","battle_1_icon_buff_2003",1,0,'',},
	[4] = {4,2,"2,2,100","3,1","battle_1_icon_buff_2004",1,0,'',},
	[5] = {5,2,"3,2,100","3,1","battle_1_icon_buff_2005",1,0,'',},
}

function BuffConfig.GetConfig(key)
	local tb = BuffConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["target"] = 2,["buffeffect"] = 3,["range"] = 4,["icon"] = 5,["value"] = 6,["taskid"] = 7,["dec"] = 8,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return BuffConfig