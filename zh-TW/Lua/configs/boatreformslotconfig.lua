local BoatReformSlotConfig = {
	[1] = {1,"Primary",1,"0,0;1,50;2,100;3,150;4,200;5,250",
		[[主艦載武器]],
	},
	[2] = {2,"Secondary",1,"0,0;1,50;2,100;3,150;4,200;5,250",
		[[副艦載武器]],
	},
	[3] = {3,"Armour",1,"0,0;1,50;2,100;3,150;4,200;5,250",
		[[增設裝甲區]],
	},
	[4] = {4,"Engine",1,"0,0;1,50;2,100;3,150;4,200;5,250",
		[[核心引擎]],
	},
	[5] = {5,"Device",1,"0,0;1,50;2,100;3,150;4,200;5,250",
		[[輔助裝置]],
	},

}
function BoatReformSlotConfig.GetConfig(key)
	local Values = BoatReformSlotConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["slotid"] = 1,["sloteng"] = 2,["initialgrade"] = 3,["starattr"] = 4,["slotname"] = 5,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return BoatReformSlotConfig