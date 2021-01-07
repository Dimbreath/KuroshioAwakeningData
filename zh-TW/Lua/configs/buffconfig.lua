local BuffConfig = {}

BuffConfig.Values = {
	[1] = {1,1,"1,2,500","3,1","battle_1_icon_buff_2005",1,27001,[[我方全體耐久提高50%]],},
	[10] = {10,1,"3,2,500","3,1","battle_1_icon_buff_2007",1,27004,[[我方全體防空提高50%]],},
	[11] = {11,1,"28,2,500","3,1","battle_1_icon_buff_2003",1,27002,[[我方全體護甲提高50%]],},
	[12] = {12,1,"28,2,500","3,1","battle_1_icon_buff_2003",1,27004,[[我方全體護甲提高50%]],},
	[13] = {13,2,"1,2,500","3,1","battle_1_icon_buff_2006",1,0,[[敵方全體耐久提高50%]],},
	[14] = {14,2,"3,2,500;28,2,500","3,1","battle_1_icon_buff_2009",1,0,[[敵方全體防禦提高50%]],},
	[15] = {15,2,"2,2,500;4,2,500;5,2,500","3,1","battle_1_icon_buff_2002",1,0,[[敵方全體攻擊提高50%]],},
	[2] = {2,1,"1,2,500","3,1","battle_1_icon_buff_2005",1,27004,[[我方全體耐久提高50%]],},
	[3] = {3,1,"2,2,500","3,1","battle_1_icon_buff_2001",1,27003,[[我方全體砲擊提高50%]],},
	[4] = {4,1,"2,2,500","3,1","battle_1_icon_buff_2001",1,27005,[[我方全體砲擊提高50%]],},
	[5] = {5,1,"5,2,500","3,1","battle_1_icon_buff_2008",1,27003,[[我方全體空襲提高50%]],},
	[6] = {6,1,"5,2,500","3,1","battle_1_icon_buff_2008",1,27005,[[我方全體空襲提高50%]],},
	[7] = {7,1,"4,2,500","3,1","battle_1_icon_buff_2006",1,27003,[[我方全體雷擊提高50%]],},
	[8] = {8,1,"4,2,500","3,1","battle_1_icon_buff_2006",1,27006,[[我方全體雷擊提高50%]],},
	[9] = {9,1,"3,2,500","3,1","battle_1_icon_buff_2007",1,27002,[[我方全體防空提高50%]],},
}

function BuffConfig.GetConfig(key)
	local tb = BuffConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["target"] = 2,["buffeffect"] = 3,["range"] = 4,["icon"] = 5,["value"] = 6,["taskid"] = 7,["dec"] = 8,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return BuffConfig