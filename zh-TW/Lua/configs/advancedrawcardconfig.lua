local AdvanceDrawCardConfig = {}

AdvanceDrawCardConfig.Values = {
	[1] = {1,{"10101,3"},{"10101,12"},"7","1001",10,1,0,3,"main_1_function_icon_banner_yg_1","main_1_function_icon_banner_yg_2",0,},
}

function AdvanceDrawCardConfig.GetConfig(key)
	local tb = AdvanceDrawCardConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["precondi_1"] = 2,["precondi_2"] = 3,["duringtime"] = 4,["drawcardid"] = 5,["usetime"] = 6,["paytime"] = 7,["freetime"] = 8,["resettime"] = 9,["banner_1"] = 10,["banner_2"] = 11,["nazo"] = 12,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return AdvanceDrawCardConfig