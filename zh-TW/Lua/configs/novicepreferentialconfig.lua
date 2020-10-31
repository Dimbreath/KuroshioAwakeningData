local NovicePreferentialConfig = {
	[1] = {1,1,40100,"activity_1_head1_20191022","activity_1_head1_small_20191022","40100,krs40100_0201","40101,krs40101_0101","lvzuofu_1","activity_1_bg_vedio4",'',"activity_1_pic1_20191022","activity_1_pic10_20191022",
	},
	[2] = {2,1,50320,"activity_1_head2_20191022","activity_1_head2_small_20191022","50320,krs50320_0201","50321,krs50321_0101","huangquan_1","activity_1_bg_vedio3",'',"activity_1_pic2_20191022","activity_1_pic20_20191022",
	},
	[3] = {3,1,30180,"activity_1_head3_20191022","activity_1_head3_small_20191022","30180,krs30180_0201","30181,krs30181_0101","hailunna_1","activity_1_bg_vedio2",'',"activity_1_pic3_20191022","activity_1_pic30_20191022",
	},

}
function NovicePreferentialConfig.GetConfig(key)
	local Values = NovicePreferentialConfig[key]
	if not Values then
		print_error(key)
		return nil
	end
	local Fields = {["id"] = 1,["teamid"] = 2,["roleid"] = 3,["btnpic"] = 4,["tabpic"] = 5,["normalvoice"] = 6,["specialvoice"] = 7,["normalvideo"] = 8,["normalbg"] = 9,["specialbg"] = 10,["normalpic"] = 11,["specialpic"] = 12,}
	for k,v in pairs(Fields) do
		Fields[k] = Values[v]
	end
	return Fields 
end
return NovicePreferentialConfig