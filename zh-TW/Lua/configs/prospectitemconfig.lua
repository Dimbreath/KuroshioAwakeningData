local ProspectItemConfig = {
	[1] = {1,1,1,1,0,999801,
	},
	[2] = {2,1,1,5,0,999802,
	},
	[3] = {3,1,5,1,0,999803,
	},
	[4] = {4,1,3,3,0,999804,
	},
	[5] = {5,2,3,3,0,999805,
	},
	[6] = {6,1,3,3,4,999806,
	},
	[7] = {7,2,5,5,0,999807,
	},
	[8] = {8,1,5,5,0,999808,
	},

}
function ProspectItemConfig.GetConfig(key)
	local Values = ProspectItemConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["iatticetype"] = 2,["iattice_x"] = 3,["iattice_y"] = 4,["iattice_random"] = 5,["coinexchangeid"] = 6,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return ProspectItemConfig