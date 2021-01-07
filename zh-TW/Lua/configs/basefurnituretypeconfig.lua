local BaseFurnitureTypeConfig = {}

BaseFurnitureTypeConfig.Values = {
	[101] = {101,1,[[內牆]],"house_furtype_head_101",0,},
	[102] = {102,1,[[地板]],"house_furtype_head_102",0,},
	[103] = {103,1,[[壁紙]],"house_furtype_head_103",0,},
	[200] = {200,2,[[普通擺放]],"house_furtype_head_200",0,},
	[201] = {201,2,[[椅子]],"house_furtype_head_201",0,},
	[202] = {202,2,[[桌子]],"house_furtype_head_202",0,},
	[203] = {203,2,[[櫃子]],"house_furtype_head_203",0,},
	[204] = {204,2,[[擺設裝飾]],"house_furtype_head_204",0,},
	[205] = {205,2,[[地毯]],"house_furtype_head_205",0,},
	[206] = {206,2,[[牆面裝飾]],"house_furtype_head_206",0,},
	[300] = {300,3,[[特殊家具]],'',0,},
}

function BaseFurnitureTypeConfig.GetConfig(key)
	local tb = BaseFurnitureTypeConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["filtratetype"] = 2,["desc"] = 3,["icon"] = 4,["nazo"] = 5,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return BaseFurnitureTypeConfig