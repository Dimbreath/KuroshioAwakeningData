local BusinessCardConfig = {
	[690001] = {690001,"socialcontact_1_nc_ncskin_l_3","socialcontact_1_nc_ncskin_m_3","socialcontact_1_nc_ncskin_s_3",'',0,
	},
	[690002] = {690002,"socialcontact_1_nc_ncskin_l_1","socialcontact_1_nc_ncskin_m_1","socialcontact_1_nc_ncskin_s_1","card690002",1,
	},

}
function BusinessCardConfig.GetConfig(key)
	local Values = BusinessCardConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["itemid"] = 1,["icon_i"] = 2,["icon_m"] = 3,["icon_s"] = 4,["frame"] = 5,["background"] = 6,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return BusinessCardConfig