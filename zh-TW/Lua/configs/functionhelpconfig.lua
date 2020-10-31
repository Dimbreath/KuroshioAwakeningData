local FunctionHelpConfig = {
	[10000] = {10000,2,"guide_1_icon_help","Hook/MenuComponent(Clone)/Top/menu/icon","100,0",{"manoeuvre_1_text_tips"},
		[[演習]],
	},
	[10001] = {10001,1,"guide_1_icon_help","Hook/MenuComponent(Clone)/Top/menu/icon","100,0",{"function_help_reform_01","function_help_reform_02"},
		[[深海化]],
	},
	[10002] = {10002,1,"guide_1_icon_help","Hook/MenuComponent(Clone)/Top/menu/icon","100,0",{"function_help_reform_03","function_help_reform_04"},
		[[艦裝改造]],
	},
	[10003] = {10003,1,"guide_1_icon_help","FettersInfoForm/Left","-205,321",{"function_help_fettersform_01","function_help_fettersform_02","function_help_fettersform_03","function_help_fettersform_04"},
		[[羈絆]],
	},
	[10004] = {10004,1,"guide_1_icon_help","GachaOrderForm/RightBottom/PreGacha_Panel/Tip_Parent/Txt_GachaTip","-100,0",{"function_help_drawcard_01","function_help_drawcard_02"},
		[[定向招募]],
	},
	[10005] = {10005,1,"guide_1_icon_help","Hook/MenuComponent(Clone)/Top/menu/icon","100,0",{"function_help_livitan_01","function_help_livitan_02"},
		[[材料副本]],
	},
	[10006] = {10006,1,"guide_1_icon_help","ContentRoot/Hook/MenuComponent(Clone)/Top/menu/icon","100,0",{"function_help_blitzkrieg_05","function_help_blitzkrieg_06","function_help_blitzkrieg_07","function_help_blitzkrieg_08"},
		[[深海閃擊]],
	},
	[10007] = {10007,1,"guide_1_icon_help","WorldRoot/Layer/Hook/MenuComponent/Top/menu/icon","100,0",{"function_help_worldmap_01","function_help_worldmap_02","function_help_worldmap_03","function_help_worldmap_04","function_help_worldmap_05","function_help_worldmap_06"},
		[[世界地圖玩法]],
	},
	[10008] = {10008,1,"guide_1_icon_help","GachaReformForm/Queue_Panel","-205,321",{"function_help_gachareform_01","function_help_gachareform_02"},
		[[人偶培養]],
	},
	[10009] = {10009,1,"guide_1_icon_help","GachaRetireForm/Btn_Shop","-690,89",{"function_help_retire_01","function_help_retire_02"},
		[[人偶回收]],
	},
	[10010] = {10010,1,"guide_1_icon_help","Hook/MenuComponent(Clone)/Top/menu/icon","100,0",{"function_help_fleetmission_01","function_help_fleetmission_02"},
		[[聯盟任務]],
	},
	[10011] = {10011,1,"guide_1_icon_help","Hook/MenuComponent(Clone)/Top/menu/icon","100,0",{"function_help_room_01","function_help_room_02","function_help_room_03","function_help_room_04","function_help_room_05","function_help_room_06","function_help_equiproom_01","function_help_equiproom_02","function_help_equiproom_03","function_help_equiproom_04","function_help_equiproom_05","function_help_equiproom_06","function_help_equiproom_07","function_help_equiproom_08"},
		[[後宅]],
	},
	[10012] = {10012,1,"guide_1_icon_help","Hook/MenuComponent(Clone)/Top/menu/icon","100,0",{"function_help_component_01","function_help_component_02","function_help_component_03","function_help_component_04","function_help_component_05","function_help_component_06","function_help_component_07","function_help_component_08",""},
		[[詳情]],
	},

}
function FunctionHelpConfig.GetConfig(key)
	local Values = FunctionHelpConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["wdtype"] = 2,["icon"] = 3,["parent"] = 4,["iconcpos"] = 5,["value"] = 6,["name"] = 7,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return FunctionHelpConfig