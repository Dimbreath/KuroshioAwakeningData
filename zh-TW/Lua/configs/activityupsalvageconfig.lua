local ActivityUpSalvageConfig = {}

ActivityUpSalvageConfig.Values = {
	["1"] = {"1","7014,107014","2,30180,1",0.05,"海倫娜[SSR]掉落機率UP☆",0,},
	["2"] = {"2","7015,107015","2,30180,1",0.05,"海倫娜[SSR]掉落機率UP☆",0,},
	["3"] = {"3","7016,107016","2,30180,1",0.05,"海倫娜[SSR]掉落機率UP☆",0,},
	["4"] = {"4","7017,107017","2,30180,1",0.05,"海倫娜[SSR]掉落機率UP☆",0,},
	["5"] = {"5","7018,107018","2,30180,1",0.05,"海倫娜[SSR]掉落機率UP☆",0,},
	["6"] = {"6","8001,108001","2,30180,1",0.05,"海倫娜[SSR]掉落機率UP☆",0,},
	["7"] = {"7","8002,108002","2,30180,1",0.05,"海倫娜[SSR]掉落機率UP☆",0,},
	["8"] = {"8","8003,108003","2,30180,1",0.05,"海倫娜[SSR]掉落機率UP☆",0,},
	["9"] = {"9","8004,108004","2,30180,1",0.05,"海倫娜[SSR]掉落機率UP☆",0,},
	["10"] = {"10","8005,108005","2,30180,1",0.05,"海倫娜[SSR]掉落機率UP☆",0,},
	["11"] = {"11","8006,108006","2,30180,1",0.05,"海倫娜[SSR]掉落機率UP☆",0,},
}

function ActivityUpSalvageConfig.GetConfig(key)
	local tb = ActivityUpSalvageConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["sequence"] = 1,["harbour"] = 2,["activitydrop"] = 3,["probability"] = 4,["activitydesc"] = 5,["nazo"] = 6,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return ActivityUpSalvageConfig