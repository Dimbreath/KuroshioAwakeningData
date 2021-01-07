local BattleMapStrongHoldConfig = {}

BattleMapStrongHoldConfig.Values = {
	[170301] = {170301,1703,"170302,170303",0,0,0,0,0,'',1,"99","170301",{198,204},0,},
	[170302] = {170302,1703,"170301,170304",170302,1000,2500,20,5,'',2,'',"170302",'',0,},
	[170303] = {170303,1703,"170301,170305",170303,1000,2500,20,5,'',2,'',"170303",{204},0,},
	[170304] = {170304,1703,"170302,170306",170304,1000,2500,20,5,'',3,'',"170304",'',0,},
	[170305] = {170305,1703,"170303,170307",170305,1000,2500,20,5,'',3,'',"170305",'',0,},
	[170306] = {170306,1703,"170304,170308",170306,1000,2500,20,5,'',3,'',"170306",'',0,},
	[170307] = {170307,1703,"170305,170309",170307,1000,2500,20,5,'',3,'',"170307",'',0,},
	[170308] = {170308,1703,"170306,170309",170308,1000,2500,20,5,'',3,"2,1,10,10","170308",{102},0,},
	[170309] = {170309,1703,"170307,170308",170309,1000,2500,20,5,'',4,"98","170309",'',0,},
	[170601] = {170601,1706,"170602,170603",0,0,0,0,0,'',1,"99","170601",{198},0,},
	[170602] = {170602,1706,"170601,170604",170602,1500,5100,30,5,'',2,'',"170602",'',0,},
	[170603] = {170603,1706,"170601,170605,170606",170603,1500,5100,30,5,'',2,'',"170603",'',0,},
	[170604] = {170604,1706,"170602,170607,170608",170604,1500,5100,30,5,'',3,'',"170604",{204},0,},
	[170605] = {170605,1706,"170603,170608",170605,1500,5100,30,5,'',3,'',"170605",'',0,},
	[170606] = {170606,1706,"170603",170606,1500,5100,30,5,'',3,"4","170606",{104},0,},
	[170607] = {170607,1706,"170604",170607,1500,5100,30,5,'',3,"3,1,1","170607",{103,204},0,},
	[170608] = {170608,1706,"170604,170605,170609,170610",170608,1500,5100,30,5,'',3,'',"170608",'',0,},
	[170609] = {170609,1706,"170608",170609,1500,5100,30,5,'',4,"2,1,15,15","170609",{102},0,},
	[170610] = {170610,1706,"170608",170610,1500,5100,30,5,'',4,"98","170610",'',0,},
	[170801] = {170801,1708,"170802,170803,170804",0,0,0,0,0,'',1,"99","170801",{198},0,},
	[170802] = {170802,1708,"170801,170805",170802,2000,8000,40,5,'',2,'',"170802",'',0,},
	[170803] = {170803,1708,"170801,170807",170803,2000,8000,40,5,'',2,'',"170803",'',0,},
	[170804] = {170804,1708,"170801,170806",170804,2000,8000,40,5,'',2,'',"170804",'',0,},
	[170805] = {170805,1708,"170802,170808",170805,2000,8000,40,5,'',3,"7,100,20,30","170805",{107},0,},
	[170806] = {170806,1708,"170804,170809,170810",170806,2000,8000,40,5,'',3,'',"170806",{204},0,},
	[170807] = {170807,1708,"170803",170807,2000,8000,40,5,'',3,"6,5","170807",{106},0,},
	[170808] = {170808,1708,"170805,170809",170808,2000,8000,40,5,'',3,'',"170808",'',0,},
	[170809] = {170809,1708,"170806,170808,170811",170809,2000,8000,40,5,'',3,'',"170809",'',0,},
	[170810] = {170810,1708,"170806",170810,2000,8000,40,5,'',4,"3,2,2","170810",{103,204},0,},
	[170811] = {170811,1708,"170809",170811,2000,8000,40,5,'',4,"98","170811",'',0,},
	[180201] = {180201,1802,"180202",0,0,0,0,0,'',1,"99","180201",{198},0,},
	[180202] = {180202,1802,"180201,180203,180204",180202,1500,5100,30,5,'',2,'',"180202",'',0,},
	[180203] = {180203,1802,"180202,180204,180205",180203,1500,5100,30,5,'',3,'',"180203",'',0,},
	[180204] = {180204,1802,"180202,180203,180205",180204,1500,5100,30,5,'',3,'',"180204",'',0,},
	[180205] = {180205,1802,"180203,180204,180206,180207",180205,1500,5100,30,5,'',3,'',"180205",'',0,},
	[180206] = {180206,1802,"180205",180206,1500,5100,30,5,'',4,"98","180206",'',0,},
	[180207] = {180207,1802,"180205",180207,1500,5100,30,5,'',4,"1,180207","180207",{101},0,},
	[180301] = {180301,1803,"180302,180303",0,0,0,0,0,'',1,"99","180301",{198},0,},
	[180302] = {180302,1803,"180301,180304,180305",180302,2000,7400,40,5,'',2,'',"180302",'',0,},
	[180303] = {180303,1803,"180301,180305,180306",180303,2000,7400,40,5,'',2,'',"180303",'',0,},
	[180304] = {180304,1803,"180302,180307",180304,2000,7400,40,5,'',3,'',"180304",'',0,},
	[180305] = {180305,1803,"180302,180303,180307,180308",180305,2000,7400,40,5,'',3,"7,100,20,30","180305",{107},0,},
	[180306] = {180306,1803,"180303,180308",180306,2000,7400,40,5,'',3,'',"180306",'',0,},
	[180307] = {180307,1803,"180304,180305,180309",180307,2000,7400,40,5,'',3,"2,1,15,15","180307",{102},0,},
	[180308] = {180308,1803,"180305,180306,180309",180308,2000,7400,40,5,'',3,"3,1,3","180308",{103},0,},
	[180309] = {180309,1803,"180307,180308",180309,2000,7400,40,5,'',4,"98","180309",'',0,},
	[180401] = {180401,1804,"180402,180403",0,0,0,0,0,'',1,"99","180401",{198,202},0,},
	[180402] = {180402,1804,"180401,180404,180405",180402,2500,10000,50,5,'',2,'',"180402",{202},0,},
	[180403] = {180403,1804,"180401,180406",180403,2500,10000,50,5,'',2,'',"180403",{202},0,},
	[180404] = {180404,1804,"180402,180407",180404,2500,10000,50,5,'',3,'',"180404",'',0,},
	[180405] = {180405,1804,"180402,180407",180405,2500,10000,50,5,'',3,'',"180405",'',0,},
	[180406] = {180406,1804,"180403,180409,180410",180406,2500,10000,50,5,'',3,'',"180406",'',0,},
	[180407] = {180407,1804,"180404,180405,180408",180407,2500,10000,50,5,'',3,'',"180407",'',0,},
	[180408] = {180408,1804,"180407",180408,2500,10000,50,5,'',4,"98","180408",'',0,},
	[180409] = {180409,1804,"180406",180409,2500,10000,50,5,'',3,"5,3,180407","180409",{105},0,},
	[180410] = {180410,1804,"180406",180410,2500,10000,50,5,'',4,"1,180410","180410",{101},0,},
	[180501] = {180501,1805,"180502",0,0,0,0,0,'',1,"99","180501",{198},0,},
	[180502] = {180502,1805,"180501,180503,180504",180502,3000,12900,60,5,'',2,'',"180502",{202},0,},
	[180503] = {180503,1805,"180502,180505",180503,3000,12900,60,5,'',3,'',"180503",{202},0,},
	[180504] = {180504,1805,"180502,180506,180507",180504,3000,12900,60,5,'',3,'',"180504",{202,204},0,},
	[180505] = {180505,1805,"180503,180508,180509",180505,3000,12900,60,5,'',3,'',"180505",{204},0,},
	[180506] = {180506,1805,"180504,180510",180506,3000,12900,60,5,'',3,'',"180506",'',0,},
	[180507] = {180507,1805,"180504",180507,3000,12900,60,5,'',4,"3,2,4","180507",{103,204},0,},
	[180508] = {180508,1805,"180505",180508,3000,12900,60,5,'',4,"2,2,10,10","180508",{102,204},0,},
	[180509] = {180509,1805,"180505,180510,180511",180509,3000,12900,60,5,'',3,'',"180509",'',0,},
	[180510] = {180510,1805,"180506,180509",180510,3000,12900,60,5,'',3,'',"180510",'',0,},
	[180511] = {180511,1805,"180509",180511,3000,12900,60,5,'',4,"98","180511",'',0,},
	[180601] = {180601,1806,"180602,180603,180604",0,0,0,0,0,'',1,"99","180601",{198,202},0,},
	[180602] = {180602,1806,"180601,180605",180602,3000,13800,60,5,'',2,'',"180602",{202},0,},
	[180603] = {180603,1806,"180601,180605",180603,3000,13800,60,5,'',2,'',"180603",{202},0,},
	[180604] = {180604,1806,"180601,180606,180607",180604,3000,13800,60,5,'',2,'',"180604",{202,204},0,},
	[180605] = {180605,1806,"180602,180603,180608,180609",180605,3000,13800,60,5,'',3,'',"180605",'',0,},
	[180606] = {180606,1806,"180604,180610",180606,3000,13800,60,5,'',3,'',"180606",{204},0,},
	[180607] = {180607,1806,"180604,180611",180607,3000,13800,60,5,'',3,"3,2,5","180607",{103},0,},
	[180608] = {180608,1806,"180605",180608,3000,13800,60,5,'',4,"2,2,10,10","180608",{102},0,},
	[180609] = {180609,1806,"180605,180610",180609,3000,13800,60,5,'',3,'',"180609",'',0,},
	[180610] = {180610,1806,"180606,180609,180612",180610,3000,13800,60,5,'',3,'',"180610",'',0,},
	[180611] = {180611,1806,"180607",180611,3000,13800,60,5,'',4,"5,3,180610","180611",{105},0,},
	[180612] = {180612,1806,"180610",180612,3000,13800,60,5,'',4,"98","180612",'',0,},
	[180701] = {180701,1807,"180702,180703",0,0,0,0,0,'',1,"99","180701",{198},0,},
	[180702] = {180702,1807,"180701",180702,3000,13800,60,5,'',2,"5,5,180704","180702",{105},0,},
	[180703] = {180703,1807,"180701",180703,3000,13800,60,5,'',2,"5,5,180705","180703",{105},0,},
	[180704] = {180704,1807,"180706,180707",180704,3000,13800,60,5,'',3,'',"180704",'',0,},
	[180705] = {180705,1807,"180708,180709",180705,3000,13800,60,5,'',3,'',"180705",'',0,},
	[180706] = {180706,1807,"180704",180706,3000,13800,60,5,'',3,"6,5","180706",{106},0,},
	[180707] = {180707,1807,"180704,180710,180711",180707,3000,13800,60,5,'',3,'',"180707",{204},0,},
	[180708] = {180708,1807,"180705,180712,180713",180708,3000,13800,60,5,'',3,'',"180708",{204},0,},
	[180709] = {180709,1807,"180705",180709,3000,13800,60,5,'',3,"6,5","180709",{106},0,},
	[180710] = {180710,1807,"180707",180710,3000,13800,60,5,'',4,"2,2,15,15","180710",{102,204},0,},
	[180711] = {180711,1807,"180707,180714",180711,3000,13800,60,5,'',3,'',"180711",'',0,},
	[180712] = {180712,1807,"180708,180714",180712,3000,13800,60,5,'',3,'',"180712",'',0,},
	[180713] = {180713,1807,"180708",180713,3000,13800,60,5,'',4,"3,2,6","180713",{103,204},0,},
	[180714] = {180714,1807,"180711,180712",180714,3000,13800,60,5,'',4,"98","180714",'',0,},
}

function BattleMapStrongHoldConfig.GetConfig(key)
	local tb = BattleMapStrongHoldConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["strongholdid"] = 1,["harbourid"] = 2,["neighborid"] = 3,["battleid"] = 4,["lordexp"] = 5,["exp"] = 6,["cost"] = 7,["friendlyexp"] = 8,["drop"] = 9,["initialstatus"] = 10,["status"] = 11,["battleart"] = 12,["eventinfo"] = 13,["nazo"] = 14,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return BattleMapStrongHoldConfig