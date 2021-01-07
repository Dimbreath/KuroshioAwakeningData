local MonorewardConfig = {}

MonorewardConfig.Values = {
	[201] = {201,2,"1,260001,2",[[在海岸上發現了一處廢棄不久的倉庫，搜尋到了%s]],0,},
	[202] = {202,2,"1,3,100",[[佔領了一座小型石油鑽井，獲得%s]],0,},
	[203] = {203,2,"1,2,20000",[[在神代會社的集市上抽中了特等簽，獲得%s]],0,},
	[204] = {204,2,"1,240209,1",[[今日花間院天氣晴朗，薩拉托加心情大好，送你%s]],0,},
	[205] = {205,2,"1,260001,4",[[遇到了從利維坦深淵游來的怪魚，獲得%s]],0,},
	[206] = {206,2,"1,240006,1",[[在神代會社遇到了熱情好客的老奶奶，獲得%s]],0,},
}

function MonorewardConfig.GetConfig(key)
	local tb = MonorewardConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["plotid"] = 1,["type"] = 2,["itemid"] = 3,["plotdesc"] = 4,["nazo"] = 5,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return MonorewardConfig