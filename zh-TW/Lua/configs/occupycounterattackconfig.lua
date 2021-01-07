local OccupyCounterattackConfig = {}

OccupyCounterattackConfig.Values = {
	[1] = {1,1,{"10201,5007"},"1,5007","3,880,362,3",0,},
	[10] = {10,3,'',"1,6014","3,-933,1175,1",0,},
	[2] = {2,2,{"1,10:05:00"},"2,1","3,880,362,3",0,},
	[3] = {3,2,{"1,13:15:00"},"2,1","3,-2658,-445,2",0,},
	[9] = {9,3,'',"1,9018","3,-3243,304,2",0,},
	[4] = {4,2,{"1,15:30:00"},"2,1","3,-1324,600,1",0,},
	[5] = {5,2,{"1,18:25:00"},"2,1","3,1622,-893,4",0,},
	[6] = {6,2,{"1,19:15:00"},"2,1","3,-2658,-445,2",0,},
	[7] = {7,3,'',"1,7018","3,1531,1159,3",0,},
	[8] = {8,3,'',"1,8014","3,3734,-1492,4",0,},
}

function OccupyCounterattackConfig.GetConfig(key)
	local tb = OccupyCounterattackConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["type"] = 2,["unlockcondition"] = 3,["ourport"] = 4,["enemyport"] = 5,["nazo"] = 6,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return OccupyCounterattackConfig