local ActivityUpSalvageConfig = {
	["1"] = {"1","7014,107014","2,30180,1",0.05,
		[[海倫娜[SSR]掉落機率UP☆]],
	},
	["2"] = {"2","7015,107015","2,30180,1",0.05,
		[[海倫娜[SSR]掉落機率UP☆]],
	},
	["3"] = {"3","7016,107016","2,30180,1",0.05,
		[[海倫娜[SSR]掉落機率UP☆]],
	},
	["4"] = {"4","7017,107017","2,30180,1",0.05,
		[[海倫娜[SSR]掉落機率UP☆]],
	},
	["5"] = {"5","7018,107018","2,30180,1",0.05,
		[[海倫娜[SSR]掉落機率UP☆]],
	},
	["6"] = {"6","8001,108001","2,30180,1",0.05,
		[[海倫娜[SSR]掉落機率UP☆]],
	},
	["7"] = {"7","8002,108002","2,30180,1",0.05,
		[[海倫娜[SSR]掉落機率UP☆]],
	},
	["8"] = {"8","8003,108003","2,30180,1",0.05,
		[[海倫娜[SSR]掉落機率UP☆]],
	},
	["9"] = {"9","8004,108004","2,30180,1",0.05,
		[[海倫娜[SSR]掉落機率UP☆]],
	},
	["10"] = {"10","8005,108005","2,30180,1",0.05,
		[[海倫娜[SSR]掉落機率UP☆]],
	},
	["11"] = {"11","8006,108006","2,30180,1",0.05,
		[[海倫娜[SSR]掉落機率UP☆]],
	},

}
function ActivityUpSalvageConfig.GetConfig(key)
	local Values = ActivityUpSalvageConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["sequence"] = 1,["harbour"] = 2,["activitydrop"] = 3,["probability"] = 4,["activitydesc"] = 5,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return ActivityUpSalvageConfig