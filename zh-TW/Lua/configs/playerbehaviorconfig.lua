local PlayerBehaviorConfig = {}

PlayerBehaviorConfig.Values = {
	[1001001] = {1001001,1,"1,59","4,0,0,0,1",[[通關任意閃擊港口]],"1,32,50",'',0,0,},
	[1001002] = {1001002,1,"1,59","8,3,5,1",[[SSR品質]],"1,32,100",'',0,0,},
	[1001003] = {1001003,1,"1,59","8,3,4,1",[[SR品質]],"1,32,50",'',0,0,},
	[1001004] = {1001004,1,"1,59","8,3,3,1",[[R品質]],"1,32,20",'',0,0,},
	[1001005] = {1001005,1,"1,59","8,3,2,1",[[N品質]],"1,32,10",'',0,0,},
	[1002001] = {1002001,2,"1,61","1,3",[[每完成{0}次每日任務]],"1,890001,50","2,600",0,0,},
	[1002002] = {1002002,2,"1,61","3,0,0,0,2",[[每通過{0}次利維坦深淵]],"1,890001,50","2,600",0,0,},
	[1002003] = {1002003,2,"1,61","11,3,100",[[每消耗{0}點能源]],"1,890001,100","2,600",0,0,},
	[1002004] = {1002004,2,"1,61","12,0,5",[[每進行{0}次招募]],"1,890001,150","2,600",0,0,},
}

function PlayerBehaviorConfig.GetConfig(key)
	local tb = PlayerBehaviorConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["module"] = 2,["effective_time"] = 3,["channel"] = 4,["describe"] = 5,["reward"] = 6,["limit"] = 7,["order"] = 8,["nazo"] = 9,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return PlayerBehaviorConfig