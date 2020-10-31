local MarryConfig = {
	[1] = {1,2,1,'','',false,'',0,"024_marry","{ \"key\":1,\"value\":\"1\",\"endTime\":0}",'','','','',
		[[]],
	},
	[2] = {2,3,2,'','',false,'',0,'','','','','','',
		[[]],
	},
	[3] = {3,4,3,'','',false,'',3.6,'','','','','','',
		[[]],
	},
	[4] = {4,5,4,'','',false,'',0,'','','','','','',
		[[抵達了約定的地點……無法控制的心跳聲……]],
	},
	[5] = {5,6,4,'','',false,'',0,'','','','','','',
		[[眼前的少女，靜靜地看著你……]],
	},
	[6] = {6,7,5,'','',false,'',1,'',"{ \"key\":2,\"value\":\"1.15\",\"endTime\":1}",'','','',"{ \"key\":1,\"value\":\"1.15\",\"endTime\":1}",
		[[]],
	},
	[7] = {7,8,6,'','',false,'',1,'',"{ \"key\":3,\"value\":\"bg_1_kissxsis_04\",\"endTime\":3}",'','','',"{ \"key\":2,\"value\":\"1.15\",\"endTime\":1}",
		[[]],
	},
	[8] = {8,9,11,'','',false,'',1,'','','','','','',
		[[]],
	},
	[9] = {9,10,7,'','',false,"item_1_iconitem_240020",0,'','','','','','',
		[[]],
	},
	[10] = {10,11,2,'','',false,'',1,'','','','','',"{ \"key\":3,\"value\":\"1.15\",\"endTime\":1}",
		[[]],
	},
	[11] = {11,12,8,'','',false,'',3.5,'',"{ \"key\":4,\"value\":\"bg_1_kissxsis_04\",\"endTime\":3}","{ \"key\":1,\"value\":\"\",\"endTime\":3}",'','',"{ \"key\":4,\"value\":\"1.15\",\"endTime\":1}",
		[[]],
	},
	[12] = {12,13,9,'','',false,'',2.5,'','','','','','',
		[[]],
	},
	[13] = {13,14,10,'','',false,'',10,'','','','','','',
		[[]],
	},
	[14] = {14,-1,2,'','',false,'',0,'','','','','','',
		[[]],
	},

}
function MarryConfig.GetConfig(key)
	local Values = MarryConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["nextid"] = 2,["actiontype"] = 3,["speakername"] = 4,["speakernameen"] = 5,["showcharacter"] = 6,["parameter"] = 7,["endtime"] = 8,["voice"] = 9,["backgroundcontrol"] = 10,["charactercontrol"] = 11,["contextcontrol"] = 12,["itemcontrol"] = 13,["effectcontrol"] = 14,["content"] = 15,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return MarryConfig