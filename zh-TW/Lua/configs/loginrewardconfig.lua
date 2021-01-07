local LoginRewardConfig = {}

LoginRewardConfig.Values = {
	[1] = {1,[[首月登入獎勵]],"1,1,50","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","1,1,50","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","2,90011,1","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","1,1,50","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","2,90011,1",0,},
	[2] = {2,[[第2月登入獎勵]],"1,1,50","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","1,1,50","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","2,90011,1","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","1,1,50","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","2,90011,1",0,},
	[3] = {3,[[第3月登入獎勵]],"1,1,50","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","1,1,50","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","2,90011,1","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","1,1,50","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","2,90011,1",0,},
	[4] = {4,[[第4月登入獎勵]],"1,1,50","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","1,1,50","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","2,90011,1","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","1,1,50","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","2,90011,1",0,},
	[5] = {5,[[第5月登入獎勵]],"1,1,50","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","1,1,50","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","2,90011,1","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","1,1,50","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","2,90011,1",0,},
	[6] = {6,[[第6月登入獎勵]],"1,1,50","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","1,1,50","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","2,90011,1","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","1,1,50","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","2,90011,1",0,},
	[7] = {7,[[第7月登入獎勵]],"1,1,50","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","1,1,50","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","2,90011,1","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","1,1,50","1,260001,5","1,260002,5","1,3,200","1,160001,1","1,240007,1","1,240041,1","2,90011,1",0,},
}

function LoginRewardConfig.GetConfig(key)
	local tb = LoginRewardConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["loginrewardid"] = 1,["longinrewardname"] = 2,["day1reward"] = 3,["day2reward"] = 4,["day3reward"] = 5,["day4reward"] = 6,["day5reward"] = 7,["day6reward"] = 8,["day7reward"] = 9,["day8reward"] = 10,["day9reward"] = 11,["day10reward"] = 12,["day11reward"] = 13,["day12reward"] = 14,["day13reward"] = 15,["day14reward"] = 16,["day15reward"] = 17,["day16reward"] = 18,["day17reward"] = 19,["day18reward"] = 20,["day19reward"] = 21,["day20reward"] = 22,["day21reward"] = 23,["day22reward"] = 24,["day23reward"] = 25,["day24reward"] = 26,["day25reward"] = 27,["day26reward"] = 28,["day27reward"] = 29,["day28reward"] = 30,["nazo"] = 31,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return LoginRewardConfig