local WorldStoryChapterConfig = {}

WorldStoryChapterConfig.Values = {
	[1] = {1,[[第一章-偽神之冬]],"The winter of false god",2,"1,8,45",0,},
}

function WorldStoryChapterConfig.GetConfig(key)
	local tb = WorldStoryChapterConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["chaptername"] = 2,["chapterenname"] = 3,["order"] = 4,["coinnum"] = 5,["nazo"] = 6,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return WorldStoryChapterConfig