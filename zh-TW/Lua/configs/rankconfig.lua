local RankConfig = {}

RankConfig.Values = {
	[100] = {100,1,0,0,0,'',[[綜合實力]],"rank_1_icon_tab_01",'','',1,0,},
	[101] = {101,1,1,100,1000,[[說明：\n\n艦隊實力=所有編隊內所有成員的評分總和]],[[艦隊排行]],'',"ARMADA",[[艦隊實力]],0,0,},
	[102] = {102,1,2,100,1000,[[說明：\n\n人偶排行是根據所有指揮官擁有的單一人偶評分進行總排行榜排序]],[[人偶排行]],'',"DOLL",[[個人實力]],1,0,},
	[200] = {200,2,0,0,0,'',[[人偶收藏]],"rank_1_icon_tab_02",'','',1,0,},
	[201] = {201,2,1,100,1000,[[說明：\n\n收藏數量是根據指揮官個人擁有的不同人偶數量為排行依據]],[[招募排行]],'',"COLLECTION",[[收藏數量]],1,0,},
	[202] = {202,2,2,100,1000,[[說明：\n\n深海排行是根據所有指揮官擁有的不同深海化人偶數量進行總排行榜排序]],[[深海排行]],'',"GHOST",[[深海數量]],1,0,},
	[300] = {300,3,0,0,0,'',[[港口攻略]],"rank_1_icon_tab_03",'','',0,0,},
	[301] = {301,3,1,100,1000,[[說明：\n\n壓制率=（已攻略港口數÷總港口數）x100%]],[[攻略排行]],'',"SUPPRESS",[[壓制率]],0,0,},
}

function RankConfig.GetConfig(key)
	local tb = RankConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["type"] = 2,["sectype"] = 3,["ranknum"] = 4,["playerranknum"] = 5,["destxt"] = 6,["btnname"] = 7,["btnicon"] = 8,["btnenname"] = 9,["typename"] = 10,["open"] = 11,["nazo"] = 12,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return RankConfig