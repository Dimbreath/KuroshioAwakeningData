local MonorewardConfig = {
	[201] = {201,2,"1,260001,2",
		[[在海岸上發現了一處廢棄不久的倉庫，搜尋到了%s]],
	},
	[202] = {202,2,"1,3,50",
		[[佔領了一座小型石油鑽井，獲得%s]],
	},
	[203] = {203,2,"1,2,20000",
		[[在神代會社的集市上抽中了特等簽，獲得%s]],
	},
	[204] = {204,2,"1,240209,1",
		[[今日花間院天氣晴朗，薩拉托加心情大好，送你%s]],
	},
	[205] = {205,2,"1,260001,2",
		[[今天房間收拾得很整潔，梅絲忒很滿意，獎勵了%s]],
	},
	[206] = {206,2,"1,260001,4",
		[[遇到了從利維坦深淵游來的怪魚，獲得%s]],
	},
	[207] = {207,2,"1,240006,1",
		[[在神代會社遇到了熱情好客的老奶奶，獲得%s]],
	},
	[208] = {208,2,"1,3,100",
		[[佔領了一座小型石油鑽井，獲得，獲得%s]],
	},
	[209] = {209,2,"1,2,20000",
		[[遇到從靜謐之海來此旅行的神秘友人，獲得%s]],
	},
	[210] = {210,2,"1,240209,1",
		[[遇到了狂熱的銀翼科學家，獲得%s]],
	},

}
function MonorewardConfig.GetConfig(key)
	local Values = MonorewardConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["plotid"] = 1,["type"] = 2,["itemid"] = 3,["plotdesc"] = 4,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return MonorewardConfig