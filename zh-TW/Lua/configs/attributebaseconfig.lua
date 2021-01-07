local AttributeBaseConfig = {}

AttributeBaseConfig.Values = {
	[1] = {1,[[耐久]],0.0602,1,"common_1_icon_state_01",0,},
	[2] = {2,[[砲擊]],0.8921,1,"common_1_icon_state_09",0,},
	[3] = {3,[[防空]],0.6335,1,"common_1_icon_state_08",0,},
	[4] = {4,[[雷擊]],0.9813,1,"common_1_icon_state_03",0,},
	[5] = {5,[[空襲]],0.8921,1,"common_1_icon_state_02",0,},
	[6] = {6,[[武器效率]],0,1,'',0,},
	[7] = {7,[[命中]],0.1,1,'',0,},
	[8] = {8,[[機動]],0.6989,0,"common_1_icon_state_07",0,},
	[9] = {9,[[暴擊]],0.274,0,"common_1_icon_state_04",0,},
	[10] = {10,[[韌性]],0,1,'',0,},
	[11] = {11,[[幸運]],0,1,'',0,},
	[12] = {12,[[裝填]],0,1,'',0,},
	[13] = {13,[[鎖敵]],0,1,'',0,},
	[14] = {14,[[裝甲類型]],0,1,'',0,},
	[15] = {15,[[額外暴擊率]],0,1,'',0,},
	[16] = {16,[[額外迴避率]],0,1,'',0,},
	[17] = {17,[[等級]],0,1,'',0,},
	[18] = {18,[[經驗]],0,1,'',0,},
	[19] = {19,[[最大經驗]],0,1,'',0,},
	[20] = {20,[[砲擊最小傷害]],0,1,'',0,},
	[21] = {21,[[砲擊最大傷害]],0,1,'',0,},
	[22] = {22,[[魚雷武器最小傷害]],0,1,'',0,},
	[23] = {23,[[魚雷武器最大傷害]],0,1,'',0,},
	[24] = {24,[[運氣]],0,1,'',0,},
	[25] = {25,[[友好度]],0,1,'',0,},
	[26] = {26,[[最小攻擊]],0,1,'',0,},
	[27] = {27,[[最大攻擊]],0,1,'',0,},
	[28] = {28,[[護甲]],0.6335,1,"common_1_icon_state_05",0,},
	[29] = {29,[[空襲最小傷害]],0,1,'',0,},
	[30] = {30,[[空襲最大傷害]],0,1,'',0,},
	[31] = {31,[[傷害加深（A類易傷）]],0,1,'',0,},
	[32] = {32,[[傷害減免（A類減免）]],0,1,'',0,},
	[33] = {33,[[暴擊傷害]],0,1,'',0,},
	[34] = {34,[[航速]],0,1,'',0,},
	[35] = {35,[[損管]],0.01,1,"common_1_icon_state_06",0,},
	[36] = {36,[[火控]],0.1,1,"common_1_icon_state_10",0,},
	[99] = {99,[[劇情特殊1]],0,1,'',0,},
	[98] = {98,[[劇情特殊1]],0,1,'',0,},
}

function AttributeBaseConfig.GetConfig(key)
	local tb = AttributeBaseConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["name"] = 2,["score"] = 3,["attrtype"] = 4,["icon"] = 5,["nazo"] = 6,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return AttributeBaseConfig