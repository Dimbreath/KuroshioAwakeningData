local WorldStoryChapterConfig = {
	[1] = {1,"The winter of false god",2,"1,8,45",
		[[第一章-偽神之冬]],
	},

}
function WorldStoryChapterConfig.GetConfig(key)
	local Values = WorldStoryChapterConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["chapterenname"] = 2,["order"] = 3,["coinnum"] = 4,["chaptername"] = 5,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return WorldStoryChapterConfig