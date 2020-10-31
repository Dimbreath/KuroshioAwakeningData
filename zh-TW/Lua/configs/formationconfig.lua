local FormationConfig = {
	[1] = {1,"1","2,3","4,5",
	},

}
function FormationConfig.GetConfig(key)
	local Values = FormationConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["formation_front"] = 2,["formation_middle"] = 3,["formation_after"] = 4,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return FormationConfig