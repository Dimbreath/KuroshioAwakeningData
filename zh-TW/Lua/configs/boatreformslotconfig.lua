local BoatReformSlotConfig = {}

BoatReformSlotConfig.Values = {
	[1] = {1,[[主艦載武器]],"Primary",1,"0,0;1,50;2,100;3,150;4,200;5,250",0,},
	[2] = {2,[[副艦載武器]],"Secondary",1,"0,0;1,50;2,100;3,150;4,200;5,250",0,},
	[3] = {3,[[增設裝甲區]],"Armour",1,"0,0;1,50;2,100;3,150;4,200;5,250",0,},
	[4] = {4,[[核心引擎]],"Engine",1,"0,0;1,50;2,100;3,150;4,200;5,250",0,},
	[5] = {5,[[輔助裝置]],"Device",1,"0,0;1,50;2,100;3,150;4,200;5,250",0,},
}

function BoatReformSlotConfig.GetConfig(key)
	local tb = BoatReformSlotConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["slotid"] = 1,["slotname"] = 2,["sloteng"] = 3,["initialgrade"] = 4,["starattr"] = 5,["nazo"] = 6,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return BoatReformSlotConfig