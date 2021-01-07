local BaseFurnitureFunctionConfig = {}

BaseFurnitureFunctionConfig.Values = {
	[2001101] = {2001101,[[製作總控臺]],300,'',1,0,4,0,{" "},'',0,'',0,},
	[2001201] = {2001201,[[裝備收納箱]],300,'',1,2001202,1,1,'','',0,"backhouse_furniture_func_01_text",0,},
	[2001202] = {2001202,[[裝備收納箱]],300,'',2,2001203,1,2,{"10201,8002"},"1,2,20000",1800,"backhouse_furniture_func_01_text",0,},
	[2001203] = {2001203,[[裝備收納箱]],300,'',3,2001204,1,3,{"10201,6006"},"1,2,50000",3600,"backhouse_furniture_func_01_text",0,},
	[2001204] = {2001204,[[裝備收納箱]],300,'',4,2001205,1,4,{"10201,7009"},"1,2,100000",5400,"backhouse_furniture_func_01_text",0,},
	[2001205] = {2001205,[[裝備收納箱]],300,'',5,0,1,5,{"10201,7012"},"1,2,200000",7200,"backhouse_furniture_func_01_text",0,},
	[2001301] = {2001301,[[工程圖紙桌]],300,'',1,2001302,2,1,'','',0,"backhouse_furniture_func_02_text",0,},
	[2001302] = {2001302,[[工程圖紙桌]],300,'',2,2001303,2,2,{"10201,7005"},"1,2,20000",1800,"backhouse_furniture_func_02_text",0,},
	[2001303] = {2001303,[[工程圖紙桌]],300,'',3,2001304,2,3,{"10201,9008"},"1,2,50000",3600,"backhouse_furniture_func_02_text",0,},
	[2001304] = {2001304,[[工程圖紙桌]],300,'',4,2001305,2,4,{"10201,8010"},"1,2,100000",5400,"backhouse_furniture_func_02_text",0,},
	[2001305] = {2001305,[[工程圖紙桌]],300,'',5,0,2,5,{"10201,6014"},"1,2,200000",7200,"backhouse_furniture_func_02_text",0,},
	[2001401] = {2001401,[[3D印表機]],300,'',1,2001402,3,0,'','',0,"backhouse_furniture_func_03_text",0,},
	[2001402] = {2001402,[[3D印表機]],300,'',2,2001403,3,10,{"10201,9004"},"1,2,20000",1800,"backhouse_furniture_func_03_text",0,},
	[2001403] = {2001403,[[3D印表機]],300,'',3,2001404,3,15,{"10201,8006"},"1,2,50000",3600,"backhouse_furniture_func_03_text",0,},
	[2001404] = {2001404,[[3D印表機]],300,'',4,2001405,3,20,{"10201,6011"},"1,2,100000",5400,"backhouse_furniture_func_03_text",0,},
	[2001405] = {2001405,[[3D印表機]],300,'',5,0,3,25,{"10201,9013"},"1,2,200000",7200,"backhouse_furniture_func_03_text",0,},
	[2001001] = {2001001,[[裝備製作室牆面]],300,'',1,0,5,0,'','',0,'',0,},
	[2001002] = {2001002,[[裝備製作室地板]],300,'',1,0,5,0,'','',0,'',0,},
}

function BaseFurnitureFunctionConfig.GetConfig(key)
	local tb = BaseFurnitureFunctionConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["furniturename"] = 2,["furnituretype"] = 3,["furnitureart"] = 4,["level"] = 5,["nextfurniture"] = 6,["function"] = 7,["furniturequality"] = 8,["precondi"] = 9,["cost"] = 10,["time"] = 11,["desc"] = 12,["nazo"] = 13,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return BaseFurnitureFunctionConfig