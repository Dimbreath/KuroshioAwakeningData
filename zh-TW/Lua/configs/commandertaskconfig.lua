local CommanderTaskConfig = {}

CommanderTaskConfig.Values = {
	[1] = {1,1,1001,"1,2,3,4,5,6,7,8,9",0,},
	[2] = {2,1,1002,"10",0,},
	[3] = {3,2,1001,"11,12,13,14,15,16,17,18,19",0,},
	[4] = {4,2,1002,"20",0,},
	[5] = {5,3,1001,"21,22,23,24,25,26,27,28,29",0,},
	[6] = {6,3,1002,"30",0,},
	[7] = {7,4,1001,"31,32,33,34,35,36,37,38,39",0,},
	[8] = {8,4,1002,"40",0,},
	[9] = {9,5,1001,"41,42,43,44,45,46,47,48,49",0,},
	[10] = {10,5,1002,"50",0,},
	[11] = {11,6,1001,"51,52,53,54,55,56,57,58,59",0,},
	[12] = {12,6,1002,"60",0,},
}

function CommanderTaskConfig.GetConfig(key)
	local tb = CommanderTaskConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["phase"] = 2,["tasktype"] = 3,["task"] = 4,["nazo"] = 5,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return CommanderTaskConfig