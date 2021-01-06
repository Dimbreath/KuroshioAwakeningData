local VipCardConfig = {}

VipCardConfig.Values = {
	[250011] = {250011,"activity_1_head2_20191022",230,30,1,5,"5,6",0,},
	[250012] = {250012,"activity_1_head3_20191022",180,15,1,6,'',0,},
}

function VipCardConfig.GetConfig(key)
	local tb = VipCardConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["btnpic"] = 2,["price"] = 3,["time"] = 4,["mailform"] = 5,["mail"] = 6,["buff"] = 7,["nazo"] = 8,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return VipCardConfig