local IntervalRewardsConfig = {
	[1] = {1,"1100;400","1,3,120;1,260002,5",
	},
	[2] = {2,"1600;400","1,3,120;1,260002,5",
	},

}
function IntervalRewardsConfig.GetConfig(key)
	local Values = IntervalRewardsConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["countdown"] = 2,["rewards"] = 3,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return IntervalRewardsConfig