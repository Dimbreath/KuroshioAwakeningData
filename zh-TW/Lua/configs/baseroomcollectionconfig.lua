local BaseRoomCollectionConfig = {
	[1] = {1,"1020","0","1008;1008","2,4;9,9","1015;1010;1012;1016;1017;1013;1011","5,5;4,15;1,15;0,15;15,0;13,1;12,5","1019","0",'','','','','','','','',
		[[推薦1號]],
	},

}
function BaseRoomCollectionConfig.GetConfig(key)
	local Values = BaseRoomCollectionConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["floorareaid"] = 2,["floorarealoc"] = 3,["carpetareaid"] = 4,["carpetarealoc"] = 5,["furnitureareaid"] = 6,["furniturearealoc"] = 7,["wallareaid"] = 8,["wallarealoc"] = 9,["wallpicturearea1id"] = 10,["wallpicturearea1loc"] = 11,["wallpicturearea2id"] = 12,["wallpicturearea2loc"] = 13,["wallpaperarea1id"] = 14,["wallpaperarea1loc"] = 15,["wallpaperarea2id"] = 16,["wallpaperarea2loc"] = 17,["name"] = 18,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return BaseRoomCollectionConfig