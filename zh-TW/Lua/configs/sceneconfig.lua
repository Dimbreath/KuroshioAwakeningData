local SceneConfig = {
	[1] = {1,"Login","1",
	},
	[2] = {2,"Lobby","2",
	},
	[3] = {3,"SLG","3",
	},
	[4] = {4,"Battle","4",
	},
	[5] = {5,"BattleAutoTest","4",
	},

}
function SceneConfig.GetConfig(key)
	local Values = SceneConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["assetname"] = 2,["backgroundmusicid"] = 3,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return SceneConfig