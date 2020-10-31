local BaseFurnitureTypeConfig = {
	[101] = {101,1,"house_furtype_head_101",
		[[內牆]],
	},
	[102] = {102,1,"house_furtype_head_102",
		[[地板]],
	},
	[103] = {103,1,"house_furtype_head_103",
		[[壁紙]],
	},
	[200] = {200,2,"house_furtype_head_200",
		[[普通擺放]],
	},
	[201] = {201,2,"house_furtype_head_201",
		[[椅子]],
	},
	[202] = {202,2,"house_furtype_head_202",
		[[桌子]],
	},
	[203] = {203,2,"house_furtype_head_203",
		[[櫃子]],
	},
	[204] = {204,2,"house_furtype_head_204",
		[[擺設裝飾]],
	},
	[205] = {205,2,"house_furtype_head_205",
		[[地毯]],
	},
	[206] = {206,2,"house_furtype_head_206",
		[[牆面裝飾]],
	},
	[300] = {300,3,'',
		[[特殊家具]],
	},

}
function BaseFurnitureTypeConfig.GetConfig(key)
	local Values = BaseFurnitureTypeConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["filtratetype"] = 2,["icon"] = 3,["desc"] = 4,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return BaseFurnitureTypeConfig