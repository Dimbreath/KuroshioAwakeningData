local LottoTaskConfig = {
	[1] = {1,40101,10,60,'',
	},
	[2] = {1,40102,30,15,'',
	},
	[3] = {1,40103,60,5,'',
	},
	[4] = {2,40104,40,5,'',
	},
	[5] = {2,40105,30,10,'',
	},
	[6] = {2,40106,20,15,'',
	},
	[7] = {2,40107,15,20,'',
	},
	[8] = {2,40108,100,6,'',
	},
	[9] = {2,40109,50,9,'',
	},
	[10] = {2,40110,30,12,'',
	},
	[11] = {2,40111,20,15,'',
	},
	[12] = {3,40112,100,3,'',
	},
	[13] = {3,40113,50,6,'',
	},
	[14] = {3,40114,30,9,'',
	},
	[15] = {3,40115,20,12,'',
	},
	[16] = {3,40116,100,2,'',
	},
	[17] = {3,40117,50,3,'',
	},
	[18] = {3,40118,30,4,'',
	},
	[19] = {3,40119,20,5,'',
	},

}
function LottoTaskConfig.GetConfig(key)
	local Values = LottoTaskConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["groupid"] = 1,["taskid"] = 2,["weight"] = 3,["integral"] = 4,["refresh"] = 5,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return LottoTaskConfig