local FleetGlobalConfig = {}

FleetGlobalConfig.Values = {
	["join_fleet_lv"] = {"join_fleet_lv","1",[[大艦隊功能開啟時的指揮官等級]],0,},
	["set_up_fleet"] = {"set_up_fleet","3;0",[[創立艦隊的條件，允許存在多個（指揮官等級，戒備值）]],0,},
	["set_up_consume"] = {"set_up_consume","1,1,500",[[創立艦隊的消耗（消耗基本形式）]],0,},
	["fleet_tag"] = {"fleet_tag",[[考據黨;肝爆;話癆;蘿莉控;萌新;顏即王道;氪爆;鹹魚]],[[艦隊Tag配置，最長4個字，最多8個TAG]],0,},
	["fleet_info_max"] = {"fleet_info_max","50",[[單個艦隊的申請資訊最大儲存數]],0,},
	["fleet_member_max"] = {"fleet_member_max","30",[[單個艦隊可容納的成員數量]],0,},
	["fleet_fresh_cd"] = {"fleet_fresh_cd","3",[[艦隊列表更新CD（單位為秒）]],0,},
	["fleetBossAlter"] = {"fleetBossAlter","15",[[司令AFK時間，單位為天（工會進入【流轉】狀態的前置條件）]],0,},
	["transferPowerCd"] = {"transferPowerCd","72",[[會長轉移行為CD（會長身份不滿X小時時，不可轉移給下一人]],0,},
}

function FleetGlobalConfig.GetConfig(key)
	local tb = FleetGlobalConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["key"] = 1,["value"] = 2,["remarks"] = 3,["nazo"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return FleetGlobalConfig