local BattleMapHelpConfig = {
	[198] = {198,1,98,1,"slg_1_map_icon_2005",1,"ff78b1cc",
		[[固定據點]],
		[[我方艦隊潛入港口時的初始據點與敵方港口駐軍Boss據點。]],
	},
	[101] = {101,1,1,2,"slg_1_map_icon_2008",2,"ff78b1cc",
		[[物資緝獲]],
		[[敵方據點通常有物資儲備，佔領該類型據點將緝獲敵方物資。]],
	},
	[103] = {103,1,3,3,"slg_1_map_icon_2007",2,"ff78b1cc",
		[[Buff加成]],
		[[佔領該類型據點時，士氣獲得提升，對應艦隊可獲得一項Buff加成效果。]],
	},
	[105] = {105,1,5,4,"slg_1_map_event_icon_5",2,"ff78b1cc",
		[[定向潛入]],
		[[某些海域存在暗流密道，佔領該類型據點，對應艦隊可潛入至某一固定據點。]],
	},
	[106] = {106,1,6,5,"slg_1_map_event_icon_6",2,"ff78b1cc",
		[[隨機潛入]],
		[[某些海域存在神秘暗流，佔領該類型據點，對應艦隊可潛入至某一隨機據點。]],
	},
	[102] = {102,1,2,6,"slg_1_map_icon_2006",2,"ff78b1cc",
		[[安全據點]],
		[[港口內可能存在安全區域，佔領該類型據點後，可回復對應艦隊的血量以及大招能量。]],
	},
	[104] = {104,1,4,7,"slg_1_map_event_icon_4",3,"ff78b1cc",
		[[戰略事件]],
		[[佔領該類型據點，可解鎖通行特殊航道。]],
	},
	[107] = {107,1,7,8,"slg_1_map_event_icon_7",2,"ff78b1cc",
		[[戰術迂迴]],
		[[途經該類型據點時，可選擇是否進行迂迴作戰，成功則可規避直接戰鬥，有效保存實力。]],
	},
	[202] = {202,2,2,9,"slg_1_map_link_06",2,"49ecffcc",
		[[單向航道]],
		[[該航道僅可隨箭頭指向單向通行，無法原航路返回，請指揮官謹慎進行戰略部署。]],
	},
	[204] = {204,2,4,10,"slg_1_map_icon_s_lockbg",1,"49ecffcc",
		[[特殊航道]],
		[[該航道實行通行管制，滿足解禁條件後才可通行。]],
	},

}
function BattleMapHelpConfig.GetConfig(key)
	local Values = BattleMapHelpConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["helptype"] = 2,["helpid"] = 3,["order"] = 4,["icon"] = 5,["pagenum"] = 6,["color"] = 7,["title"] = 8,["content"] = 9,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return BattleMapHelpConfig