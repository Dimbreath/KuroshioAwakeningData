local BaseFurnitureFunctionConfig = {
	[2001101] = {2001101,300,'',1,0,4,0,'','',0,'',
		[[製作總控臺]],
	},
	[2001201] = {2001201,300,'',1,2001202,1,1,'','',0,"backhouse_furniture_func_01_text",
		[[裝備收納箱]],
	},
	[2001202] = {2001202,300,'',2,2001203,1,2,{"10201,8002"},"1,2,20000",1800,"backhouse_furniture_func_01_text",
		[[裝備收納箱]],
	},
	[2001203] = {2001203,300,'',3,2001204,1,3,{"10201,6006"},"1,2,50000",3600,"backhouse_furniture_func_01_text",
		[[裝備收納箱]],
	},
	[2001204] = {2001204,300,'',4,2001205,1,4,{"10201,7009"},"1,2,100000",5400,"backhouse_furniture_func_01_text",
		[[裝備收納箱]],
	},
	[2001205] = {2001205,300,'',5,0,1,5,{"10201,7012"},"1,2,200000",7200,"backhouse_furniture_func_01_text",
		[[裝備收納箱]],
	},
	[2001301] = {2001301,300,'',1,2001302,2,1,'','',0,"backhouse_furniture_func_02_text",
		[[工程圖紙桌]],
	},
	[2001302] = {2001302,300,'',2,2001303,2,2,{"10201,7005"},"1,2,20000",1800,"backhouse_furniture_func_02_text",
		[[工程圖紙桌]],
	},
	[2001303] = {2001303,300,'',3,2001304,2,3,{"10201,9008"},"1,2,50000",3600,"backhouse_furniture_func_02_text",
		[[工程圖紙桌]],
	},
	[2001304] = {2001304,300,'',4,2001305,2,4,{"10201,8010"},"1,2,100000",5400,"backhouse_furniture_func_02_text",
		[[工程圖紙桌]],
	},
	[2001305] = {2001305,300,'',5,0,2,5,{"10201,6014"},"1,2,200000",7200,"backhouse_furniture_func_02_text",
		[[工程圖紙桌]],
	},
	[2001401] = {2001401,300,'',1,2001402,3,0,'','',0,"backhouse_furniture_func_03_text",
		[[3D印表機]],
	},
	[2001402] = {2001402,300,'',2,2001403,3,10,{"10201,9004"},"1,2,20000",1800,"backhouse_furniture_func_03_text",
		[[3D印表機]],
	},
	[2001403] = {2001403,300,'',3,2001404,3,15,{"10201,8006"},"1,2,50000",3600,"backhouse_furniture_func_03_text",
		[[3D印表機]],
	},
	[2001404] = {2001404,300,'',4,2001405,3,20,{"10201,6011"},"1,2,100000",5400,"backhouse_furniture_func_03_text",
		[[3D印表機]],
	},
	[2001405] = {2001405,300,'',5,0,3,25,{"10201,9013"},"1,2,200000",7200,"backhouse_furniture_func_03_text",
		[[3D印表機]],
	},
	[2001001] = {2001001,300,'',1,0,5,0,'','',0,'',
		[[裝備製作室牆面]],
	},
	[2001002] = {2001002,300,'',1,0,5,0,'','',0,'',
		[[裝備製作室地板]],
	},

}
function BaseFurnitureFunctionConfig.GetConfig(key)
	local Values = BaseFurnitureFunctionConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["furnituretype"] = 2,["furnitureart"] = 3,["level"] = 4,["nextfurniture"] = 5,["function"] = 6,["furniturequality"] = 7,["precondi"] = 8,["cost"] = 9,["time"] = 10,["desc"] = 11,["furniturename"] = 12,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return BaseFurnitureFunctionConfig