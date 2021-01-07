local FontLanguageConfig = {}

FontLanguageConfig.Values = {
	[1] = {1,[[简体中文]],"Cn","Cn/Fonts/ZhangHaishanAnatase;Cn/Fonts/LantingblackGBK","Cn/Fonts/LantingblackGBK_SDF",0,},
	[2] = {2,[[繁體中文]],"Tw","Tw/Fonts/MStiffHei_HK_Medium;Cn/Fonts/LantingblackGBK","Cn/Fonts/LantingblackGBK_SDF",0,},
	[3] = {3,"English","En","Cn/Fonts/ZhangHaishanAnatase;Cn/Fonts/LantingblackGBK",'',0,},
	[4] = {4,[[日本語]],"JP",'','',0,},
}

function FontLanguageConfig.GetConfig(key)
	local tb = FontLanguageConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["language"] = 2,["desc"] = 3,["path"] = 4,["sdfpath"] = 5,["nazo"] = 6,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return FontLanguageConfig