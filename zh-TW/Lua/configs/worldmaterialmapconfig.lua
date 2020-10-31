local WorldMaterialMapConfig = {
	[1001] = {1001,1,'',5,0,"{ \"x\":-34,\"y\":26}","map_1_d_resource_icon_round_1",'',0,
	},
	[2001] = {2001,2,"1,6,0",5,0,"{ \"x\":-36, \"y\":21}","map_1_d_resource_icon_round_2","map_1_d_option_icon_01",1,
	},
	[2002] = {2002,2,"2,6,0",5,0,"{ \"x\":-36, \"y\":21}","map_1_d_resource_icon_round_2","map_1_d_option_icon_03",1,
	},
	[2003] = {2003,2,"3,6,0",5,0,"{ \"x\":-36, \"y\":21}","map_1_d_resource_icon_round_2","map_1_d_option_icon_04",1,
	},
	[2004] = {2004,2,"4,6,0",5,0,"{ \"x\":-36, \"y\":21}","map_1_d_resource_icon_round_2","map_1_d_option_icon_05",1,
	},
	[2005] = {2005,2,"5,6,0",5,0,"{ \"x\":-36, \"y\":21}","map_1_d_resource_icon_round_2","map_1_d_option_icon_06",1,
	},
	[3001] = {3001,3,'',5,0,"{ \"x\":-28,\"y\":32}","map_1_d_resource_icon_round_3",'',1,
	},
	[4001] = {4001,4,'',5,0,"{ \"x\":-34,\"y\":26}","map_1_d_resource_icon_round_4",'',0,
	},

}
function WorldMaterialMapConfig.GetConfig(key)
	local Values = WorldMaterialMapConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["harbourid"] = 1,["harbourtype"] = 2,["activitytime"] = 3,["limittimes"] = 4,["circlesize"] = 5,["linepos"] = 6,["iconout"] = 7,["icon"] = 8,["tagpos"] = 9,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return WorldMaterialMapConfig