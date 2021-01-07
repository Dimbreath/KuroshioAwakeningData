local MillionaireTaskConfig = {}

MillionaireTaskConfig.Values = {
	[1] = {1,[[第1天]],"2,26101;2,26102;2,26201;2,26202;2,26203;2,26204;2,26205;2,26206;2,26207;2,26208;2,26209;2,26210",0,},
	[10] = {10,[[第10天]],"2,26103;2,26104;2,26201;2,26202;2,26203;2,26204;2,26205;2,26206;2,26207;2,26208;2,26209;2,26210",0,},
	[11] = {11,[[第11天]],"2,26105;2,26106;2,26201;2,26202;2,26203;2,26204;2,26205;2,26206;2,26207;2,26208;2,26209;2,26210",0,},
	[12] = {12,[[第12天]],"2,26107;2,26108;2,26201;2,26202;2,26203;2,26204;2,26205;2,26206;2,26207;2,26208;2,26209;2,26210",0,},
	[13] = {13,[[第13天]],"2,26101;2,26102;2,26201;2,26202;2,26203;2,26204;2,26205;2,26206;2,26207;2,26208;2,26209;2,26210",0,},
	[14] = {14,[[第14天]],"2,26103;2,26104;2,26201;2,26202;2,26203;2,26204;2,26205;2,26206;2,26207;2,26208;2,26209;2,26210",0,},
	[2] = {2,[[第2天]],"2,26103;2,26104;2,26201;2,26202;2,26203;2,26204;2,26205;2,26206;2,26207;2,26208;2,26209;2,26210",0,},
	[3] = {3,[[第3天]],"2,26105;2,26106;2,26201;2,26202;2,26203;2,26204;2,26205;2,26206;2,26207;2,26208;2,26209;2,26210",0,},
	[4] = {4,[[第4天]],"2,26107;2,26108;2,26201;2,26202;2,26203;2,26204;2,26205;2,26206;2,26207;2,26208;2,26209;2,26210",0,},
	[5] = {5,[[第5天]],"2,26101;2,26102;2,26201;2,26202;2,26203;2,26204;2,26205;2,26206;2,26207;2,26208;2,26209;2,26210",0,},
	[6] = {6,[[第6天]],"2,26103;2,26104;2,26201;2,26202;2,26203;2,26204;2,26205;2,26206;2,26207;2,26208;2,26209;2,26210",0,},
	[7] = {7,[[第7天]],"2,26105;2,26106;2,26201;2,26202;2,26203;2,26204;2,26205;2,26206;2,26207;2,26208;2,26209;2,26210",0,},
	[8] = {8,[[第8天]],"2,26107;2,26108;2,26201;2,26202;2,26203;2,26204;2,26205;2,26206;2,26207;2,26208;2,26209;2,26210",0,},
	[9] = {9,[[第9天]],"2,26101;2,26102;2,26201;2,26202;2,26203;2,26204;2,26205;2,26206;2,26207;2,26208;2,26209;2,26210",0,},
}

function MillionaireTaskConfig.GetConfig(key)
	local tb = MillionaireTaskConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["name"] = 2,["task"] = 3,["nazo"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return MillionaireTaskConfig