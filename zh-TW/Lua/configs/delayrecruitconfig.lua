local DelayRecruitConfig = {
	[101] = {101,"0",1800,"2,3","1,160002,1",
	},
	[102] = {102,"0",3600,"2,3,4","1,160002,2",
	},
	[103] = {103,"0",7200,"2,3,4","1,160002,3",
	},
	[104] = {104,"0",14400,"2,3,4,5","1,160002,6",
	},
	[105] = {105,"0",21600,"2,3,4,5","1,160002,10",
	},

}
function DelayRecruitConfig.GetConfig(key)
	local Values = DelayRecruitConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["groupid"] = 1,["cost01"] = 2,["time"] = 3,["quality"] = 4,["cost02"] = 5,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return DelayRecruitConfig