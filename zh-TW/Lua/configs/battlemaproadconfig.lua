local BattleMapRoadConfig = {}

BattleMapRoadConfig.Values = {
	[731437225646399] = {170301,170303,1703,4,"1,5,1","294,-279",315,0,},
	[732738600737391] = {170604,170607,1706,4,"3,170606","-301,254",45,0,},
	[733606184131386] = {170806,170810,1708,4,"1,4,1","-200,103",0,0,},
	[774816395346098] = {180401,180402,1804,2,'',"285,95",225,0,},
	[774816395346099] = {180401,180403,1804,2,'',"268,33",270,0,},
	[775250187043095] = {180502,180503,1805,2,'',"220,-181",180,0,},
	[775250187043096] = {180502,180504,1805,2,'',"160,-269",270,0,},
	[775263071944988] = {180505,180508,1805,4,"1,3,1","128,20",135,0,},
	[775258776977691] = {180504,180507,1805,4,"1,6,1","28,-445",135,0,},
	[775675388805498] = {180601,180602,1806,2,'',"380,-42",180,0,},
	[775675388805499] = {180601,180603,1806,2,'',"282,-81",180,0,},
	[775675388805500] = {180601,180604,1806,2,'',"225,-165",315,0,},
	[775688273707390] = {180604,180606,1806,4,"1,6,1","80,-150",45,0,},
	[776130655338982] = {180707,180710,1807,4,"1,4,1","4,265",45,0,},
	[776134950306281] = {180708,180713,1807,4,"1,6,1","-325,-146",90,0,},
}

function BattleMapRoadConfig.GetConfig(key)
	local tb = BattleMapRoadConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["frtharbourid"] = 1,["secharbourid"] = 2,["harbourid"] = 3,["roadtype"] = 4,["numtype"] = 5,["iconpos"] = 6,["rotation"] = 7,["nazo"] = 8,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return BattleMapRoadConfig