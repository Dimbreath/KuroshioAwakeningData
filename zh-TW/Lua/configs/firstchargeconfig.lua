local FirstChargeConfig = {}

FirstChargeConfig.Values = {
	[1] = {1,1,"2,40070,1;1,3,300;1,2,50000;1,24,50000;1,240006,5","1,24;2,40070;2,40070;1,3;1,2;2,40070;2,40070;2,40070;1,240006;1,240006;2,40070;2,40070;2,40070;1,240006;1,240006","activity_1_rc_tab_icon_1",399,"activity_1_rc_pic_r_0012","activity_1_rc_pic_r_0013","activity_1_rc_pic_r_0014",'','','',"40070,krs40070_0201","40071,krs40071_0101",0,},
	[2] = {2,399,"2,50340,1;1,240006,10;1,2,200000;1,24,200000;1,160001,5;1,120001,5","2,50340;2,50340;2,50340;2,50340;1,240006;2,50340;2,50340;2,50340;2,50340;1,2;1,24;1,160001;1,160001;1,120001;1,120001","activity_1_rc_tab_icon_1",3699,"activity_1_rc_pic_r_0002","activity_1_rc_pic_r_0007","activity_1_rc_pic_r_0008","activity_1_bg_vedio7",'',"xili_1","50340,krs50340_0201","50341,krs50341_0101",0,},
	[3] = {3,1299,"6,1001051,1;6,6001051,1;1,240013,1;1,2,500000;1,135000,5000","6,1001051;6,1001051;6,6001051;1,240013;1,240013;6,1001051;6,1001051;6,6001051;1,240013;1,240013;1,2;1,135000;1,135000;1,240013;1,240013","activity_1_rc_tab_icon_2",7299,"activity_1_rc_pic_r_0003",'','','','','','','',0,},
}

function FirstChargeConfig.GetConfig(key)
	local tb = FirstChargeConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["charge"] = 2,["gift"] = 3,["sequence"] = 4,["titlepic"] = 5,["cost"] = 6,["overview"] = 7,["normalpic"] = 8,["specialpic"] = 9,["normalvideopic"] = 10,["specialvideopic"] = 11,["video"] = 12,["normalvoice"] = 13,["specialvoice"] = 14,["nazo"] = 15,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return FirstChargeConfig