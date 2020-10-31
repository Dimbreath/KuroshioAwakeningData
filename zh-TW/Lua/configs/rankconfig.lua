local RankConfig = {
	[100] = {100,1,0,0,0,"rank_1_icon_tab_01",'',1,
		[[]],
		[[綜合實力]],
		[[]],
	},
	[101] = {101,1,1,100,1000,'',"ARMADA",0,
		[[說明：

艦隊實力=所有編隊內所有成員的評分總和]],
		[[艦隊排行]],
		[[艦隊實力]],
	},
	[102] = {102,1,2,100,1000,'',"DOLL",1,
		[[說明：

人偶排行是根據所有指揮官擁有的單一人偶評分進行總排行榜排序]],
		[[人偶排行]],
		[[個人實力]],
	},
	[200] = {200,2,0,0,0,"rank_1_icon_tab_02",'',1,
		[[]],
		[[人偶收藏]],
		[[]],
	},
	[201] = {201,2,1,100,1000,'',"COLLECTION",1,
		[[說明：

收藏數量是根據指揮官個人擁有的不同人偶數量為排行依據]],
		[[招募排行]],
		[[收藏數量]],
	},
	[202] = {202,2,2,100,1000,'',"GHOST",1,
		[[說明：

深海排行是根據所有指揮官擁有的不同深海化人偶數量進行總排行榜排序]],
		[[深海排行]],
		[[深海數量]],
	},
	[300] = {300,3,0,0,0,"rank_1_icon_tab_03",'',0,
		[[]],
		[[港口攻略]],
		[[]],
	},
	[301] = {301,3,1,100,1000,'',"SUPPRESS",0,
		[[說明：

壓制率=（已攻略港口數÷總港口數）x100%]],
		[[攻略排行]],
		[[壓制率]],
	},

}
function RankConfig.GetConfig(key)
	local Values = RankConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["type"] = 2,["sectype"] = 3,["ranknum"] = 4,["playerranknum"] = 5,["btnicon"] = 6,["btnenname"] = 7,["open"] = 8,["destxt"] = 9,["btnname"] = 10,["typename"] = 11,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return RankConfig