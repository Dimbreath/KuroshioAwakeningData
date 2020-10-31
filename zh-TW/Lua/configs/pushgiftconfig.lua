local PushGiftConfig = {
	[1001] = {1001,{"6,30"},"1,250077,1",0,{"1,1,100","1,2,100","1,3,100"},24,"activity_1_rc_character_02","-35,-100","activity_1_rc_character_bg_02","activity_1_rc_icon_limited","activity_1_rc_timelimited",201,101,"activity_1_limitedgift_banner_01",
		[[新人限時福利]],
		[[<color=#5bffff>1600%</color>超值優惠！]],
	},
	[1002] = {1002,{"4,5007,1"},"1,250078,1",0,{"1,1,100"},24,"activity_1_rc_character_02","-35,-100","activity_1_rc_character_bg_02","activity_1_rc_icon_limited","activity_1_rc_timelimited",202,102,"activity_1_limitedgift_banner_01",
		[[新人限時福利]],
		[[<color=#5bffff>250%</color>超值優惠！]],
	},
	[1003] = {1003,{"4,8010,1"},"1,250079,1",0,{"1,1,100","1,2,100","1,3,100"},24,"activity_1_rc_character_02","-35,-100","activity_1_rc_character_bg_02","activity_1_rc_icon_limited","activity_1_rc_timelimited",203,103,"activity_1_limitedgift_banner_01",
		[[新人限時福利]],
		[[<color=#5bffff>250%</color>超值優惠！]],
	},
	[1004] = {1004,{"4,207001,1|4,208001,1|4,209001,1|4,206001,1"},"1,250080,1",0,{"1,1,100"},24,"activity_1_rc_character_02","-35,-100","activity_1_rc_character_bg_02","activity_1_rc_icon_limited","activity_1_rc_timelimited",204,104,"activity_1_limitedgift_banner_01",
		[[新人限時福利]],
		[[<color=#5bffff>300%</color>超值優惠！]],
	},
	[2001] = {2001,{"7,3","1,5,3","9,5,1"},"1,250081,1",0,{"1,1,100","1,2,100","1,3,100"},24,"activity_1_rc_character_01","-46.3,-94.8","activity_1_rc_character_bg_01","activity_1_rc_icon_ship","activity_1_rc_ship",205,105,"activity_1_limitedgift_banner_02",
		[[神秘商船]],
		[[<color=#5bffff>250%</color>超值優惠！]],
	},
	[2002] = {2002,{"5,145001,400","5,145002,1200"},"1,250082,1",0,{"1,1,100"},24,"activity_1_rc_character_01","-46.3,-94.8","activity_1_rc_character_bg_01","activity_1_rc_icon_ship","activity_1_rc_ship",206,106,"activity_1_limitedgift_banner_02",
		[[神秘商船]],
		[[<color=#5bffff>250%</color>超值優惠！]],
	},
	[2003] = {2003,{"3,10,2|5,240203,2|10,5,2"},"1,250083,1",0,{"1,1,100","1,2,100","1,3,100"},24,"activity_1_rc_character_01","-46.3,-94.8","activity_1_rc_character_bg_01","activity_1_rc_icon_ship","activity_1_rc_ship",207,107,"activity_1_limitedgift_banner_02",
		[[神秘商船]],
		[[<color=#5bffff>250%</color>超值優惠！]],
	},
	[2004] = {2004,{"2,5,3"},"1,250084,1",0,{"1,1,100"},24,"activity_1_rc_character_01","-46.3,-94.8","activity_1_rc_character_bg_01","activity_1_rc_icon_ship","activity_1_rc_ship",208,108,"activity_1_limitedgift_banner_02",
		[[神秘商船]],
		[[<color=#5bffff>300%</color>超值優惠！]],
	},
	[2005] = {2005,{"6,100","7,5"},"1,250085,1",0,{"1,1,100"},24,"activity_1_rc_character_01","-46.3,-94.8","activity_1_rc_character_bg_01","activity_1_rc_icon_ship","activity_1_rc_ship",209,109,"activity_1_limitedgift_banner_02",
		[[神秘商船]],
		[[<color=#5bffff>250%</color>超值優惠！]],
	},
	[2006] = {2006,{"8,25"},"1,250086,1",0,{"1,1,100"},24,"activity_1_rc_character_01","-46.3,-94.8","activity_1_rc_character_bg_01","activity_1_rc_icon_ship","activity_1_rc_ship",210,110,"activity_1_limitedgift_banner_02",
		[[神秘商船]],
		[[可自選獲得以上十名<color=#5bffff>SSR人偶</color>其中一名\n<size=16>*特殊限定補給，每位指揮官<color=#5bffff>終身限購</color>一次，不要錯過喲</size>]],
	},

}
function PushGiftConfig.GetConfig(key)
	local Values = PushGiftConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["check"] = 2,["giftid"] = 3,["story"] = 4,["rewards"] = 5,["limittime"] = 6,["giftboat"] = 7,["boatcoordinate"] = 8,["broadsideboat"] = 9,["titleicon"] = 10,["titleresource"] = 11,["android"] = 12,["ios"] = 13,["mainboat"] = 14,["title"] = 15,["text"] = 16,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return PushGiftConfig