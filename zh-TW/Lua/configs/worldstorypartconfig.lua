local WorldStoryPartConfig = {
	[1001] = {1001,"Prologue",1,1,
		[[序幕-出逃]],
	},
	[1002] = {1002,"Chapter I",1,2,
		[[第一節-神秘人偶]],
	},
	[1003] = {1003,"Chapter II",1,3,
		[[第二節-漁村之夜]],
	},
	[1004] = {1004,"Chapter III",1,4,
		[[第三節-騷亂]],
	},
	[1005] = {1005,"Chapter IX",1,5,
		[[第四節-八百萬神]],
	},

}
function WorldStoryPartConfig.GetConfig(key)
	local Values = WorldStoryPartConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["partenname"] = 2,["chapterid"] = 3,["order"] = 4,["partname"] = 5,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return WorldStoryPartConfig