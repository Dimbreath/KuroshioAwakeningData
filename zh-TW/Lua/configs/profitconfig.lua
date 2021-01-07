local ProfitConfig = {}

ProfitConfig.Values = {
	[1] = {1,false,1,0.1,[[每日購買能源額外贈送<color=#00FFFF>{0}</color>%]],2,0,},
	[2] = {2,false,2,0.05,[[每日成功壓制港口BP收益提升<color=#00FFFF>{0}</color>%（不包括利維坦深淵）]],2,0,},
	[3] = {3,false,3,0.05,[[每日整備任務收益提升<color=#00FFFF>{0}</color>%]],2,0,},
	[4] = {4,false,4,0.2,[[資料磁片獲取提升<color=#00FFFF>{0}</color>%]],2,0,},
	[5] = {5,false,5,0.05,[[每日港口補給BP收益提升<color=#00FFFF>{0}</color>%]],2,0,},
	[6] = {6,false,6,10,[[單次自動打撈次數上限增加<color=#00FFFF>{0}</color>次]],1,0,},
}

function ProfitConfig.GetConfig(key)
	local tb = ProfitConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["superposition"] = 2,["type"] = 3,["value"] = 4,["describe"] = 5,["valuetype"] = 6,["nazo"] = 7,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return ProfitConfig