local AdvanceDrawCardConfig = {
	[1] = {1,{"10101,3"},{"10101,12"},"7","1001",10,1,0,3,"main_1_function_icon_banner_yg_1","main_1_function_icon_banner_yg_2",
	},

}
function AdvanceDrawCardConfig.GetConfig(key)
	local Values = AdvanceDrawCardConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["precondi_1"] = 2,["precondi_2"] = 3,["duringtime"] = 4,["drawcardid"] = 5,["usetime"] = 6,["paytime"] = 7,["freetime"] = 8,["resettime"] = 9,["banner_1"] = 10,["banner_2"] = 11,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return AdvanceDrawCardConfig