local AchieveBadgeConfig = {
	[680001] = {680001,'',
	},
	[680002] = {680002,'',
	},
	[680003] = {680003,'',
	},
	[680004] = {680004,'',
	},

}
function AchieveBadgeConfig.GetConfig(key)
	local Values = AchieveBadgeConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["itemid"] = 1,["icon"] = 2,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return AchieveBadgeConfig