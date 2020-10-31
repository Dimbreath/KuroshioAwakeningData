local FleetGlobalConfig = {
	["join_fleet_lv"] = {"join_fleet_lv",
		[[1]],
		[[大艦隊功能開啟時的指揮官等級]],
	},
	["set_up_fleet"] = {"set_up_fleet",
		[[3;0]],
		[[創立艦隊的條件，允許存在多個（指揮官等級，戒備值）]],
	},
	["set_up_consume"] = {"set_up_consume",
		[[1,1,500]],
		[[創立艦隊的消耗（消耗基本形式）]],
	},
	["fleet_tag"] = {"fleet_tag",
		[[考據黨;肝爆;話癆;蘿莉控;萌新;顏即王道;氪爆;鹹魚]],
		[[艦隊Tag配置，最長4個字，最多8個TAG]],
	},
	["fleet_info_max"] = {"fleet_info_max",
		[[50]],
		[[單個艦隊的申請資訊最大儲存數]],
	},
	["fleet_member_max"] = {"fleet_member_max",
		[[30]],
		[[單個艦隊可容納的成員數量]],
	},
	["fleet_fresh_cd"] = {"fleet_fresh_cd",
		[[3]],
		[[艦隊列表更新CD（單位為秒）]],
	},
	["fleetBossAlter"] = {"fleetBossAlter",
		[[15]],
		[[司令AFK時間，單位為天（工會進入【流轉】狀態的前置條件）]],
	},
	["transferPowerCd"] = {"transferPowerCd",
		[[72]],
		[[會長轉移行為CD（會長身份不滿X小時時，不可轉移給下一人]],
	},

}
function FleetGlobalConfig.GetConfig(key)
	local Values = FleetGlobalConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["key"] = 1,["value"] = 2,["remarks"] = 3,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return FleetGlobalConfig