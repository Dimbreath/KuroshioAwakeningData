local FettersExpConfig = {}

FettersExpConfig.Values = {
	[1] = {1,500,1000,0,},
	[2] = {2,700,1100,0,},
	[3] = {3,900,1200,0,},
	[4] = {4,1100,1300,0,},
	[5] = {5,1300,1400,0,},
	[6] = {6,1500,1500,0,},
	[7] = {7,2500,1600,0,},
	[8] = {8,3000,1700,0,},
	[9] = {9,3500,1800,0,},
	[10] = {10,0,2000,0,},
}

function FettersExpConfig.GetConfig(key)
	local tb = FettersExpConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["fetterslevel"] = 1,["exptonextlevel"] = 2,["attrcoefficient"] = 3,["nazo"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return FettersExpConfig