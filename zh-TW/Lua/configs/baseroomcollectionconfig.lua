local BaseRoomCollectionConfig = {}

BaseRoomCollectionConfig.Values = {
	[1] = {1,[[推薦1號]],"1020","0","1008;1008","2,4;9,9","1015;1010;1012;1016;1017;1013;1011","5,5;4,15;1,15;0,15;15,0;13,1;12,5","1019","0",'','','','','','','','',0,},
}

function BaseRoomCollectionConfig.GetConfig(key)
	local tb = BaseRoomCollectionConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["name"] = 2,["floorareaid"] = 3,["floorarealoc"] = 4,["carpetareaid"] = 5,["carpetarealoc"] = 6,["furnitureareaid"] = 7,["furniturearealoc"] = 8,["wallareaid"] = 9,["wallarealoc"] = 10,["wallpicturearea1id"] = 11,["wallpicturearea1loc"] = 12,["wallpicturearea2id"] = 13,["wallpicturearea2loc"] = 14,["wallpaperarea1id"] = 15,["wallpaperarea1loc"] = 16,["wallpaperarea2id"] = 17,["wallpaperarea2loc"] = 18,["nazo"] = 19,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return BaseRoomCollectionConfig