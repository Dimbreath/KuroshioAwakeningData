local FontLanguageConfig = {
	[1] = {1,"Cn","Cn/Fonts/ZhangHaishanAnatase;Cn/Fonts/LantingblackGBK","Cn/Fonts/LantingblackGBK_SDF",
		[[简体中文]],
	},
	[2] = {2,"Tw","Tw/Fonts/MStiffHei_HK_Medium;Cn/Fonts/LantingblackGBK","Cn/Fonts/LantingblackGBK_SDF",
		[[繁體中文]],
	},
	[3] = {3,"En","Cn/Fonts/ZhangHaishanAnatase;Cn/Fonts/LantingblackGBK",'',
		[[English]],
	},
	[4] = {4,"JP",'','',
		[[日本語]],
	},

}
function FontLanguageConfig.GetConfig(key)
	local Values = FontLanguageConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["desc"] = 2,["path"] = 3,["sdfpath"] = 4,["language"] = 5,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return FontLanguageConfig