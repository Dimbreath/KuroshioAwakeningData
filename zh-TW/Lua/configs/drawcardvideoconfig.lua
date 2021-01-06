local DrawcardVideoConfig = {}

DrawcardVideoConfig.Values = {
	[1] = {1,"1,5","chouka_ten_orange",0,},
	[2] = {2,"1,4","chouka_ten_purple",0,},
	[3] = {3,"1,3","chouka_ten_blue",0,},
	[4] = {4,"1,2","chouka_ten_blue",0,},
	[5] = {5,"2,5","chouka_one_orange",0,},
	[6] = {6,"2,4","chouka_one_purple",0,},
	[7] = {7,"2,3","chouka_one_blue",0,},
	[8] = {8,"2,2","chouka_one_blue",0,},
}

function DrawcardVideoConfig.GetConfig(key)
	local tb = DrawcardVideoConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["name"] = 2,["videores"] = 3,["nazo"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return DrawcardVideoConfig