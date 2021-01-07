local EquipEnhanceConfig = {}

EquipEnhanceConfig.Values = {
	[8589934593] = {2,1,10,530,0,},
	[8589934594] = {2,2,10,1570,0,},
	[8589934595] = {2,3,15,2630,0,},
	[8589934596] = {2,4,25,3680,0,},
	[8589934597] = {2,5,20,4730,0,},
	[8589934598] = {2,6,40,5780,0,},
	[8589934599] = {2,7,35,6840,0,},
	[8589934600] = {2,8,45,7880,0,},
	[8589934601] = {2,9,50,8940,0,},
	[8589934602] = {2,10,60,9990,0,},
	[8589934603] = {2,11,60,11040,0,},
	[8589934604] = {2,12,65,12090,0,},
	[8589934605] = {2,13,80,13140,0,},
	[8589934606] = {2,14,75,14200,0,},
	[8589934607] = {2,15,90,15240,0,},
	[8589934608] = {2,16,90,16300,0,},
	[8589934609] = {2,17,100,17350,0,},
	[8589934610] = {2,18,105,18400,0,},
	[8589934611] = {2,19,110,19440,0,},
	[8589934612] = {2,20,115,20510,0,},
	[8589934613] = {2,21,125,21550,0,},
	[8589934614] = {2,22,125,22610,0,},
	[8589934615] = {2,23,130,23650,0,},
	[8589934616] = {2,24,145,24710,0,},
	[8589934617] = {2,25,145,25760,0,},
	[8589934618] = {2,26,150,26810,0,},
	[8589934619] = {2,27,160,27860,0,},
	[8589934620] = {2,28,165,28920,0,},
	[8589934621] = {2,29,165,29960,0,},
	[8589934622] = {2,30,175,31010,0,},
	[12884901889] = {3,1,10,620,0,},
	[12884901890] = {3,2,15,1830,0,},
	[12884901891] = {3,3,15,3070,0,},
	[12884901892] = {3,4,25,4290,0,},
	[12884901893] = {3,5,30,5520,0,},
	[12884901894] = {3,6,40,6750,0,},
	[12884901895] = {3,7,45,7970,0,},
	[12884901896] = {3,8,55,9200,0,},
	[12884901897] = {3,9,55,10430,0,},
	[12884901898] = {3,10,70,11650,0,},
	[12884901899] = {3,11,70,12880,0,},
	[12884901900] = {3,12,75,14110,0,},
	[12884901901] = {3,13,95,15330,0,},
	[12884901902] = {3,14,90,16560,0,},
	[12884901903] = {3,15,105,17790,0,},
	[12884901904] = {3,16,105,19010,0,},
	[12884901905] = {3,17,110,20240,0,},
	[12884901906] = {3,18,125,21470,0,},
	[12884901907] = {3,19,130,22680,0,},
	[12884901908] = {3,20,130,23920,0,},
	[12884901909] = {3,21,150,25150,0,},
	[12884901910] = {3,22,145,26370,0,},
	[12884901911] = {3,23,155,27600,0,},
	[12884901912] = {3,24,165,28830,0,},
	[12884901913] = {3,25,170,30050,0,},
	[12884901914] = {3,26,175,31280,0,},
	[12884901915] = {3,27,190,32500,0,},
	[12884901916] = {3,28,190,33740,0,},
	[12884901917] = {3,29,195,34960,0,},
	[12884901918] = {3,30,200,36180,0,},
	[17179869185] = {4,1,10,700,0,},
	[17179869186] = {4,2,15,2100,0,},
	[17179869187] = {4,3,15,3510,0,},
	[17179869188] = {4,4,35,4910,0,},
	[17179869189] = {4,5,30,6300,0,},
	[17179869190] = {4,6,50,7710,0,},
	[17179869191] = {4,7,45,9110,0,},
	[17179869192] = {4,8,65,10520,0,},
	[17179869193] = {4,9,65,11920,0,},
	[17179869194] = {4,10,80,13320,0,},
	[17179869195] = {4,11,80,14720,0,},
	[17179869196] = {4,12,90,16120,0,},
	[17179869197] = {4,13,100,17520,0,},
	[17179869198] = {4,14,105,18920,0,},
	[17179869199] = {4,15,120,20330,0,},
	[17179869200] = {4,16,120,21730,0,},
	[17179869201] = {4,17,130,23130,0,},
	[17179869202] = {4,18,145,24530,0,},
	[17179869203] = {4,19,140,25930,0,},
	[17179869204] = {4,20,155,27340,0,},
	[17179869205] = {4,21,165,28740,0,},
	[17179869206] = {4,22,170,30140,0,},
	[17179869207] = {4,23,175,31540,0,},
	[17179869208] = {4,24,195,32950,0,},
	[17179869209] = {4,25,190,34340,0,},
	[17179869210] = {4,26,200,35740,0,},
	[17179869211] = {4,27,215,37160,0,},
	[17179869212] = {4,28,215,38550,0,},
	[17179869213] = {4,29,225,39950,0,},
	[17179869214] = {4,30,235,41350,0,},
	[21474836481] = {5,1,10,880,0,},
	[21474836482] = {5,2,20,2620,0,},
	[21474836483] = {5,3,20,4390,0,},
	[21474836484] = {5,4,40,6130,0,},
	[21474836485] = {5,5,40,7880,0,},
	[21474836486] = {5,6,60,9640,0,},
	[21474836487] = {5,7,60,11390,0,},
	[21474836488] = {5,8,80,13140,0,},
	[21474836489] = {5,9,80,14900,0,},
	[21474836490] = {5,10,100,16650,0,},
	[21474836491] = {5,11,100,18400,0,},
	[21474836492] = {5,12,110,20150,0,},
	[21474836493] = {5,13,130,21900,0,},
	[21474836494] = {5,14,130,23660,0,},
	[21474836495] = {5,15,150,25410,0,},
	[21474836496] = {5,16,150,27160,0,},
	[21474836497] = {5,17,160,28910,0,},
	[21474836498] = {5,18,180,30670,0,},
	[21474836499] = {5,19,180,32410,0,},
	[21474836500] = {5,20,190,34170,0,},
	[21474836501] = {5,21,210,35930,0,},
	[21474836502] = {5,22,210,37670,0,},
	[21474836503] = {5,23,220,39430,0,},
	[21474836504] = {5,24,240,41180,0,},
	[21474836505] = {5,25,240,42930,0,},
	[21474836506] = {5,26,250,44680,0,},
	[21474836507] = {5,27,270,46440,0,},
	[21474836508] = {5,28,270,48190,0,},
	[21474836509] = {5,29,280,49940,0,},
	[21474836510] = {5,30,290,51690,0,},
}

function EquipEnhanceConfig.GetConfig(key)
	local tb = EquipEnhanceConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["quality"] = 1,["level"] = 2,["exp"] = 3,["cost"] = 4,["nazo"] = 5,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return EquipEnhanceConfig