local ActivityShowParaConfig = {
	[1] = {1,"activity_shop_title_01","activity_shop_title_02","main_1_function_icon_combat_fish","activity_1_menu_bg_20200103","activity_map_tips_04",'','','','',1,
	},
	[2] = {2,"activity_shop2_title_01","activity_shop2_title_02","main_1_function_icon_combat_recallshift","activity_1_menu_bg_20200423","activity_go_text_01","activity_surface_des_02","-425,-144","activity_1_title_20200423","-297,18",2,
	},
	[3] = {3,"activity_shop3_title_01","activity_shop3_title_02","main_1_function_icon_combat_virtual","activity_1_menu_bg_20200420","activity_go_text_02","activity_surface_des_01","26,-172","activity_1_title_20200420","292,48",2,
	},
	[4] = {4,"activity_shop3_title_01","activity_shop3_title_02","main_1_function_icon_combat_virtual","activity_1_bg_dsv","activity_go_text_03","activity_surface_des_03","-462,127","activity_1_title_dsv","-223,206",2,
	},

}
function ActivityShowParaConfig.GetConfig(key)
	local Values = ActivityShowParaConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["shopcn"] = 2,["shopen"] = 3,["btn_res"] = 4,["act_pic_bg"] = 5,["act_btn_txt"] = 6,["act_text_des"] = 7,["act_text_des_pos"] = 8,["act_title_res"] = 9,["act_title_res_pos"] = 10,["sub_rule"] = 11,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return ActivityShowParaConfig