local InitialAwardsConfig = {
	[1] = {1,"2,90011,1",48,
	},

}
function InitialAwardsConfig.GetConfig(key)
	local Values = InitialAwardsConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["rewards"] = 2,["countdown"] = 3,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return InitialAwardsConfig