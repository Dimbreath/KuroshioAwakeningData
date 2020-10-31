local GlobalBuffConfig = {
	[1] = {1,false,1,0.1,'',
	},
	[2] = {2,false,2,0.05,'',
	},
	[3] = {3,false,3,0.05,'',
	},
	[4] = {4,false,4,0.2,'',
	},
	[5] = {5,false,5,0.05,'',
	},
	[6] = {6,false,6,10,'',
	},

}
function GlobalBuffConfig.GetConfig(key)
	local Values = GlobalBuffConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["superposition"] = 2,["type"] = 3,["value"] = 4,["ext"] = 5,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return GlobalBuffConfig