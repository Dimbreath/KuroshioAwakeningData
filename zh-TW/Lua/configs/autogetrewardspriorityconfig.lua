local AutoGetrewardsPriorityConfig = {
	[1] = {1,1,1,0,'',0,0,0,
		[[功能開啟]],
	},
	[2] = {2,1,2,0,'',0,0,0,
		[[月簽到]],
	},
	[3] = {3,1,3,1,"40",1,2,1,
		[[追憶前夕]],
	},
	[4] = {4,1,3,1,"52",1,2,2,
		[[虛海之約]],
	},
	[5] = {5,1,3,1,"54",1,2,3,
		[[魚潮禮祭]],
	},
	[6] = {6,1,3,1,"48",1,2,4,
		[[出鞘利劍]],
	},

}
function AutoGetrewardsPriorityConfig.GetConfig(key)
	local Values = AutoGetrewardsPriorityConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["open"] = 2,["type"] = 3,["activitytype"] = 4,["parameter"] = 5,["jumpmode"] = 6,["jumptype"] = 7,["priority"] = 8,["name"] = 9,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return AutoGetrewardsPriorityConfig