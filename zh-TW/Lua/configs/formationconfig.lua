local FormationConfig = {}

FormationConfig.Values = {
	[1] = {1,"1","2,3","4,5",0,},
}

function FormationConfig.GetConfig(key)
	local tb = FormationConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["formation_front"] = 2,["formation_middle"] = 3,["formation_after"] = 4,["nazo"] = 5,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return FormationConfig