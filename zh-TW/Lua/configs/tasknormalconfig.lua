local TaskNormalConfig = {}

TaskNormalConfig.Values = {
	[1] = {1,"quest_1_icon_0006","4",1,"10101,10102,10103,10104,10105,10106,10107,10108,10109,10110,10111,10112,10113,10114,10115,10116,10117,10118,10119,10120,10121,10122,10123,10124,10125,10126,10127,10201,10202,10203,10204,10205,10206,10207,10208,10209,10210,10211,10212,10301,10302,10303,10304,10306,10308,10310,10312,10314,10316,10318,10320,10322,10324,10701,10702,10703,10704,10705,10706,10707,10708,10709,10710,10711,10712,10713,10714,10715",0,},
	[2] = {2,"quest_1_icon_0005","1",1,"12001,12002,12003,12004,12005,12006,12008",0,},
	[3] = {3,"quest_1_icon_0008","2",1,"11001,11002,11003,11005,11006,11008,11009,11010",0,},
	[4] = {4,"quest_1_icon_0007","5",1,'',0,},
	[5] = {5,"quest_1_icon_0007","3",1,"13001,13101,13201,13401,13501,13601,13701,13801",0,},
}

function TaskNormalConfig.GetConfig(key)
	local tb = TaskNormalConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["icon"] = 2,["sort"] = 3,["show"] = 4,["task"] = 5,["nazo"] = 6,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return TaskNormalConfig