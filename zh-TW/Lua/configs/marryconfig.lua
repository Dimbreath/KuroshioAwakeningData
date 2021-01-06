local MarryConfig = {}

MarryConfig.Values = {
	[1] = {1,2,1,'','','',false,'',0,"024_marry","{ \"key\":1,\"value\":\"1\",\"endTime\":0}",'','','','',0,},
	[2] = {2,3,2,'','','',false,'',0,'','','','','','',0,},
	[3] = {3,4,3,'','','',false,'',3.6,'','','','','','',0,},
	[4] = {4,5,4,'','',[[抵達了約定的地點……無法控制的心跳聲……]],false,'',0,'','','','','','',0,},
	[5] = {5,6,4,'','',[[眼前的少女，靜靜地看著你……]],false,'',0,'','','','','','',0,},
	[6] = {6,7,5,'','','',false,'',1,'',"{ \"key\":2,\"value\":\"1.15\",\"endTime\":1}",'','','',"{ \"key\":1,\"value\":\"1.15\",\"endTime\":1}",0,},
	[7] = {7,8,6,'','','',false,'',1,'',"{ \"key\":3,\"value\":\"bg_1_kissxsis_04\",\"endTime\":3}",'','','',"{ \"key\":2,\"value\":\"1.15\",\"endTime\":1}",0,},
	[8] = {8,9,11,'','','',false,'',1,'','','','','','',0,},
	[9] = {9,10,7,'','','',false,"item_1_iconitem_240020",0,'','','','','','',0,},
	[10] = {10,11,2,'','','',false,'',1,'','','','','',"{ \"key\":3,\"value\":\"1.15\",\"endTime\":1}",0,},
	[11] = {11,12,8,'','','',false,'',3.5,'',"{ \"key\":4,\"value\":\"bg_1_kissxsis_04\",\"endTime\":3}","{ \"key\":1,\"value\":\"\",\"endTime\":3}",'','',"{ \"key\":4,\"value\":\"1.15\",\"endTime\":1}",0,},
	[12] = {12,13,9,'','','',false,'',2.5,'','','','','','',0,},
	[13] = {13,14,10,'','','',false,'',10,'','','','','','',0,},
	[14] = {14,-1,2,'','','',false,'',0,'','','','','','',0,},
}

function MarryConfig.GetConfig(key)
	local tb = MarryConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["id"] = 1,["nextid"] = 2,["actiontype"] = 3,["speakername"] = 4,["speakernameen"] = 5,["content"] = 6,["showcharacter"] = 7,["parameter"] = 8,["endtime"] = 9,["voice"] = 10,["backgroundcontrol"] = 11,["charactercontrol"] = 12,["contextcontrol"] = 13,["itemcontrol"] = 14,["effectcontrol"] = 15,["nazo"] = 16,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return MarryConfig