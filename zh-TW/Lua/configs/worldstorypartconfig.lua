local WorldStoryPartConfig = {}

WorldStoryPartConfig.Values = {
	[1001] = {1001,[[序幕-出逃]],"Prologue",1,1,0,},
	[1002] = {1002,[[第一節-神秘人偶]],"Chapter I",1,2,0,},
	[1003] = {1003,[[第二節-漁村之夜]],"Chapter II",1,3,0,},
	[1004] = {1004,[[第三節-騷亂]],"Chapter III",1,4,0,},
	[1005] = {1005,[[第四節-八百萬神]],"Chapter IX",1,5,0,},
}

function WorldStoryPartConfig.GetConfig(key)
	local tb = WorldStoryPartConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["partname"] = 2,["partenname"] = 3,["chapterid"] = 4,["order"] = 5,["nazo"] = 6,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return WorldStoryPartConfig