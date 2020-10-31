local DrawcardVideoConfig = {
	[1] = {1,"1,5","chouka_ten_orange",
	},
	[2] = {2,"1,4","chouka_ten_purple",
	},
	[3] = {3,"1,3","chouka_ten_blue",
	},
	[4] = {4,"1,2","chouka_ten_blue",
	},
	[5] = {5,"2,5","chouka_one_orange",
	},
	[6] = {6,"2,4","chouka_one_purple",
	},
	[7] = {7,"2,3","chouka_one_blue",
	},
	[8] = {8,"2,2","chouka_one_blue",
	},

}
function DrawcardVideoConfig.GetConfig(key)
	local Values = DrawcardVideoConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["name"] = 2,["videores"] = 3,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return DrawcardVideoConfig