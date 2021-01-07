local TachieShowCfgConfig = {}

TachieShowCfgConfig.Values = {
	[1] = {1,1,0,'','',0,'','','',0,},
	[2] = {2,0,1,'','',0,'','','',0,},
	[3] = {3,0,0,'','',1,'','','',0,},
	[4] = {4,0,0,'','',0,"1,0.4",'','',0,},
	[5] = {5,0,0,'','',0,"0,0.3",'','',0,},
	[6] = {6,0,0,"1,2,0.5",'',0,'','','',0,},
	[7] = {7,0,0,"2,2,1",'',0,'','','',0,},
	[8] = {8,0,0,"3,4,0.5",'',0,'','','',0,},
	[9] = {9,0,0,"1,4,0.5",'',0,'','','',0,},
	[10] = {10,0,0,"2,4,0.5",'',0,'','','',0,},
	[11] = {11,0,0,"3,8,1",'',0,'','','',0,},
	[12] = {12,0,0,"1,4,1",'',0,"1,0.4",'','',0,},
	[13] = {13,0,0,'',"3000,0,4",0,'','','',0,},
	[14] = {14,0,0,'',"3000,0,4",0,"0,0.3",'','',0,},
	[15] = {15,0,0,'',"-3000,0,4",0,'','','',0,},
	[16] = {16,0,0,'',"-3000,0,4",0,"0,0.3",'','',0,},
	[17] = {17,0,1,'','',0,"1,0.4",'','',0,},
	[18] = {18,0,1,'','',0,"0,0.3",'','',0,},
	[19] = {19,0,0,"1,4,2","3000,0,2",0,"1,0.4",'','',0,},
	[20] = {20,0,0,"1,4,2","3000,0,2",0,"0,0.3",'','',0,},
	[21] = {21,0,0,"2,4,1",'',0,"1,0.4",'','',0,},
	[22] = {22,0,1,"1,2,0.5",'',0,'','','',0,},
	[23] = {23,1,0,'','',0,"1,0.4",'','',0,},
	[24] = {24,1,0,'','',0,"0,0.3",'','',0,},
	[25] = {25,0,0,"1,14,1",'',0,'','','',0,},
	[26] = {26,1,1,'','',0,'','','',0,},
	[27] = {27,0,0,'','',0,'',"-6,-440,2",'',0,},
	[28] = {28,0,0,'','',0,"1,0.4","-6,-1500,1.5","0.6,0.6",0,},
	[29] = {29,0,0,'','',0,'','',"0.8,0.8",0,},
	[30] = {30,0,0,'','',0,'','',"0.3,0.3",0,},
	[31] = {31,0,0,'','',0,"1,0.4","-6,412,2","0.3,0.3",0,},
	[32] = {32,0,0,'','',0,"0,0.3","-6,3000,2",'',0,},
	[33] = {33,0,0,'','',0,"0,0.3",'',"0.8,0.8",0,},
	[34] = {34,0,0,'','',0,"1,0.4",'',"0.3,0.3",0,},
	[35] = {35,0,0,'','',1,"1,0.4",'','',0,},
	[36] = {36,0,0,'','',1,"0,0.3",'','',0,},
	[37] = {37,0,0,"1,2,0.5,5",'',0,'','','',0,},
	[38] = {38,0,0,"1,2,1,5",'',0,'','','',0,},
	[39] = {39,0,0,"2,2,0.5,5",'',0,'','','',0,},
	[40] = {40,0,0,"1,2,0.5,10",'',1,'','','',0,},
	[41] = {41,1,0,'','',1,'','','',0,},
	[42] = {42,0,0,"2,4,1",'',0,"1,0.4",'','',0,},
	[43] = {43,0,0,'','',0,"1,0.4","-1550,-293,1",'',0,},
}

function TachieShowCfgConfig.GetConfig(key)
	local tb = TachieShowCfgConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["tachieshowid"] = 1,["bottom"] = 2,["initialposition"] = 3,["shake"] = 4,["shift"] = 5,["communicationscreen"] = 6,["fadein"] = 7,["move"] = 8,["scale"] = 9,["nazo"] = 10,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return TachieShowCfgConfig