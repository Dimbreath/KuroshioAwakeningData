local OccupyCounterattackConfig = {
	[1] = {1,1,{"10201,5007"},"1,5007","3,880,362,3",
	},
	[10] = {10,3,'',"1,6014","3,-933,1175,1",
	},
	[2] = {2,2,{"1,10:05:00"},"2,1","3,880,362,3",
	},
	[3] = {3,2,{"1,13:15:00"},"2,1","3,-2658,-445,2",
	},
	[9] = {9,3,'',"1,9018","3,-3243,304,2",
	},
	[4] = {4,2,{"1,15:30:00"},"2,1","3,-1324,600,1",
	},
	[5] = {5,2,{"1,18:25:00"},"2,1","3,1622,-893,4",
	},
	[6] = {6,2,{"1,19:15:00"},"2,1","3,-2658,-445,2",
	},
	[7] = {7,3,'',"1,7018","3,1531,1159,3",
	},
	[8] = {8,3,'',"1,8016","3,3734,-1492,4",
	},

}
function OccupyCounterattackConfig.GetConfig(key)
	local Values = OccupyCounterattackConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["type"] = 2,["unlockcondition"] = 3,["ourport"] = 4,["enemyport"] = 5,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return OccupyCounterattackConfig