local ProfitConfig = {
	[1] = {1,false,1,0.1,2,
		[[每日購買能源額外贈送<color=#00FFFF>{0}</color>%]],
	},
	[2] = {2,false,2,0.05,2,
		[[每日成功壓制港口BP收益提升<color=#00FFFF>{0}</color>%（不包括利維坦深淵）]],
	},
	[3] = {3,false,3,0.05,2,
		[[每日整備任務收益提升<color=#00FFFF>{0}</color>%]],
	},
	[4] = {4,false,4,0.2,2,
		[[資料磁片獲取提升<color=#00FFFF>{0}</color>%]],
	},
	[5] = {5,false,5,0.05,2,
		[[每日港口補給BP收益提升<color=#00FFFF>{0}</color>%]],
	},
	[6] = {6,false,6,10,1,
		[[單次自動打撈次數上限增加<color=#00FFFF>{0}</color>次]],
	},

}
function ProfitConfig.GetConfig(key)
	local Values = ProfitConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["superposition"] = 2,["type"] = 3,["value"] = 4,["valuetype"] = 5,["describe"] = 6,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return ProfitConfig