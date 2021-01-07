local NDaysLoginTypeConfig = {}

NDaysLoginTypeConfig.Values = {
	[40] = {40,"activity_1_ND_bg_20200412","activity_1_ND_pic_20200412","-240,-95","activity_1_ZYQX_title_20200412","318,228","71ADFF","1,2,3,4,5,6,7","Ndayslogin_texture",0,},
	[52] = {52,"activity_1_menu_bg_xhzy_20200723","activity_1_pic_xhzy_20200723","-240,-95","activity_1_title_xhzy_20200723","318,228","71ADFF","8,9,10,11,12,13,14","Ndayslogin_texture_01",0,},
	[54] = {54,"activity_1_menu_bg_yclj_20200723","activity_1_pic_yclj_20200914","-240,-95","activity_1_title_yclj_20200723","318,228","71ADFF","15,16,17,18,19,20,21","Ndayslogin_texture_02",0,},
	[71] = {71,"activity_1_ND_bg_20201214","activity_1_ND_pic_20201214","-167,-73","activity_1_ND_title_20201214","420,142","FFFFFF","22,23,24,25,26,27,28","Ndayslogin_texture_03",0,},
}

function NDaysLoginTypeConfig.GetConfig(key)
	local tb = NDaysLoginTypeConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["background"] = 2,["drawing"] = 3,["coordinate1"] = 4,["title"] = 5,["coordinate2"] = 6,["color"] = 7,["reward"] = 8,["default"] = 9,["nazo"] = 10,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return NDaysLoginTypeConfig