local VipCardConfig = {
	[250011] = {250011,"activity_1_head2_20191022",230,30,1,5,"5,6",
	},
	[250012] = {250012,"activity_1_head3_20191022",180,15,1,6,'',
	},

}
function VipCardConfig.GetConfig(key)
	local Values = VipCardConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["btnpic"] = 2,["price"] = 3,["time"] = 4,["mailform"] = 5,["mail"] = 6,["buff"] = 7,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return VipCardConfig