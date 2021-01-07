local BusinessCardConfig = {}

BusinessCardConfig.Values = {
	[690001] = {690001,"socialcontact_1_nc_ncskin_l_3","socialcontact_1_nc_ncskin_m_3","socialcontact_1_nc_ncskin_s_3",'',0,0,},
	[690002] = {690002,"socialcontact_1_nc_ncskin_l_1","socialcontact_1_nc_ncskin_m_1","socialcontact_1_nc_ncskin_s_1","card690002",1,0,},
}

function BusinessCardConfig.GetConfig(key)
	local tb = BusinessCardConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["itemid"] = 1,["icon_i"] = 2,["icon_m"] = 3,["icon_s"] = 4,["frame"] = 5,["background"] = 6,["nazo"] = 7,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return BusinessCardConfig