local ClientTimeConfig = {}

ClientTimeConfig.Values = {
	["abyss"] = {"abyss",0,'','',1,'',0,},
	["abyss_choose"] = {"abyss_choose",0,'','',1,'',0,},
	["abyss_equip"] = {"abyss_equip",0,'','',1,'',0,},
	["abyss_up"] = {"abyss_up",0,'','',1,'',0,},
	["abyss_weapon"] = {"abyss_weapon",0,'','',1,'',0,},
	["CLIENT_TIME_UPDATEDAILOG_6"] = {"CLIENT_TIME_UPDATEDAILOG_6",0,'','',1,'',0,},
	["CLIENT_TIME_UPDATEOKBTN_7"] = {"CLIENT_TIME_UPDATEOKBTN_7",0,'','',1,'',0,},
	["CLIENT_TIME_STARTUPDATE_8"] = {"CLIENT_TIME_STARTUPDATE_8",0,'','',1,'',0,},
	["CLIENT_TIME_UPDATEING_9"] = {"CLIENT_TIME_UPDATEING_9",0,'','',1,'',0,},
	["CLIENT_TIME_UPDATESUCCESS_10"] = {"CLIENT_TIME_UPDATESUCCESS_10",0,'','',1,'',0,},
	["CLIENT_TIME_DECOMPRESSIONSTART_11"] = {"CLIENT_TIME_DECOMPRESSIONSTART_11",0,'','',1,'',0,},
	["CLIENT_TIME_DECOMPRESSIONEND_12"] = {"CLIENT_TIME_DECOMPRESSIONEND_12",0,'','',1,'',0,},
	["CLIENT_TIME_SDKLOGIN_13"] = {"CLIENT_TIME_SDKLOGIN_13",0,'','',1,'',0,},
	["CLIENT_TIME_SDKSTARTCALLBACK_14"] = {"CLIENT_TIME_SDKSTARTCALLBACK_14",0,'','',1,'',0,},
	["CLIENT_TIME_SDKENDCALLBACK_15"] = {"CLIENT_TIME_SDKENDCALLBACK_15",0,'','',1,'',0,},
	["CLIENT_TIME_LOGINGAME_16"] = {"CLIENT_TIME_LOGINGAME_16",0,'','',3,{"null","af_login","null"},0,},
	["CLIENT_TIME_CREATEROLEUI_17"] = {"CLIENT_TIME_CREATEROLEUI_17",0,'','',1,'',0,},
	["CLIENT_TIME_CREATEROLESUCCESS_18"] = {"CLIENT_TIME_CREATEROLESUCCESS_18",0,'','',3,{"null","af_complete_registration","null"},0,},
	["CLIENT_TIME_SELECTCOMMANDERUI_19"] = {"CLIENT_TIME_SELECTCOMMANDERUI_19",0,'','',1,'',0,},
	["CLIENT_TIME_SELECTCOMMANDERSUCCESS_20"] = {"CLIENT_TIME_SELECTCOMMANDERSUCCESS_20",0,'','',1,'',0,},
	["CLIENT_TIME_FINISH_NOVICE_GUIDE_21"] = {"CLIENT_TIME_FINISH_NOVICE_GUIDE_21",0,'','',2,{"null","af_tutorial_completion","null"},0,},
	["CLIENT_TIME_PLAYER_LEVEL_UP_22"] = {"CLIENT_TIME_PLAYER_LEVEL_UP_22",1,"3;6;9",'',2,{"null","af_level_achieved","null"},0,},
	["CLIENT_TIME_STORY_STEP_23"] = {"CLIENT_TIME_STORY_STEP_23",0,'','',1,'',0,},
	["CLIENT_TIME_STORY_SKIP_24"] = {"CLIENT_TIME_STORY_SKIP_24",0,'','',1,'',0,},
	["CLIENT_TIME_STORY_AUTO_25"] = {"CLIENT_TIME_STORY_AUTO_25",0,'','',1,'',0,},
	["guide_fight22_78"] = {"guide_fight22_78",0,'','',1,'',0,},
	["guide_gacha_172"] = {"guide_gacha_172",0,'','',1,'',0,},
	["guide_gachapage_173"] = {"guide_gachapage_173",0,'','',1,'',0,},
	["guide_gachaall_174"] = {"guide_gachaall_174",0,'','',1,'',0,},
	["guide_gachaget_175"] = {"guide_gachaget_175",0,'','',1,'',0,},
	["guide_gachaconfirm_177"] = {"guide_gachaconfirm_177",0,'','',1,'',0,},
	["guide_gachareturn_181"] = {"guide_gachareturn_181",0,'','',1,'',0,},
	["guide_teamfomat_187"] = {"guide_teamfomat_187",0,'','',1,'',0,},
	["guide_teamadd_189"] = {"guide_teamadd_189",0,'','',1,'',0,},
	["guide_chooseboat1_190"] = {"guide_chooseboat1_190",0,'','',1,'',0,},
	["guide_jump_191"] = {"guide_jump_191",0,'','',1,'',0,},
	["guide_attack_192"] = {"guide_attack_192",0,'','',1,'',0,},
	["guide_area_201"] = {"guide_area_201",0,'','',1,'',0,},
	["guide_hourblechoose_205"] = {"guide_hourblechoose_205",0,'','',1,'',0,},
	["guide_hourblechoose1"] = {"guide_hourblechoose1",0,'','',1,'',0,},
	["guide_attack1"] = {"guide_attack1",0,'','',1,'',0,},
	["guide_teamchoose"] = {"guide_teamchoose",0,'','',1,'',0,},
	["guide_teamchoose_206"] = {"guide_teamchoose_206",0,'','',1,'',0,},
	["guide_teamconfirm_207"] = {"guide_teamconfirm_207",0,'','',1,'',0,},
	["guide_attackconfirm_208"] = {"guide_attackconfirm_208",0,'','',1,'',0,},
	["guide_LB_212"] = {"guide_LB_212",0,'','',1,'',0,},
	["guide_touch3_219"] = {"guide_touch3_219",0,'','',1,'',0,},
	["guide_jump2_220"] = {"guide_jump2_220",0,'','',1,'',0,},
	["guide_mainpage_316"] = {"guide_mainpage_316",0,'','',1,'',0,},
	["guide_task_317"] = {"guide_task_317",0,'','',1,'',0,},
	["guide_taskrwd_318"] = {"guide_taskrwd_318",0,'','',1,'',0,},
	["guide_jump3_231"] = {"guide_jump3_231",0,'','',1,'',0,},
	["guide_attack2_232"] = {"guide_attack2_232",0,'','',1,'',0,},
	["guide_area2"] = {"guide_area2",0,'','',1,'',0,},
	["guide_hourblechoose2"] = {"guide_hourblechoose2",0,'','',1,'',0,},
	["guide_attack2"] = {"guide_attack2",0,'','',1,'',0,},
	["guide_attackconfirm2"] = {"guide_attackconfirm2",0,'','',1,'',0,},
	["guide_autofight2_281"] = {"guide_autofight2_281",0,'','',1,'',0,},
	["guide_quickfight2_282"] = {"guide_quickfight2_282",0,'','',1,'',0,},
	["guide_sitechoose_285"] = {"guide_sitechoose_285",0,'','',1,'',0,},
	["guide_jump5_315"] = {"guide_jump5_315",0,'','',1,'',0,},
	["guide_dock_307"] = {"guide_dock_307",0,'','',1,'',0,},
	["guide_chooseboat3_308"] = {"guide_chooseboat3_308",0,'','',1,'',0,},
	["guide_upgrade1_309"] = {"guide_upgrade1_309",0,'','',1,'',0,},
	["guide_upgrade3_311"] = {"guide_upgrade3_311",0,'','',1,'',0,},
	["guide_upgrade5_313"] = {"guide_upgrade5_313",0,'','',1,'',0,},
	["guide_jump6_319"] = {"guide_jump6_319",0,'','',1,'',0,},
	["guide_mainpage_320"] = {"guide_mainpage_320",0,'','',1,'',0,},
	["guide_deep_331"] = {"guide_deep_331",0,'','',1,'',0,},
	["guide_darkpage_332"] = {"guide_darkpage_332",0,'','',1,'',0,},
	["guide_chooseclick_333"] = {"guide_chooseclick_333",0,'','',1,'',0,},
	["guide_chooseboat4_334"] = {"guide_chooseboat4_334",0,'','',1,'',0,},
	["guide_deeprise_335"] = {"guide_deeprise_335",0,'','',1,'',0,},
	["guide_jump7_344"] = {"guide_jump7_344",0,'','',1,'',0,},
	["guide_attack3_345"] = {"guide_attack3_345",0,'','',1,'',0,},
	["guide_hourblechoose3"] = {"guide_hourblechoose3",0,'','',1,'',0,},
	["guide_attack3_3"] = {"guide_attack3_3",0,'','',1,'',0,},
	["guide_chapter1_1"] = {"guide_chapter1_1",0,'','',1,'',0,},
	["guide_pass_2"] = {"guide_pass_2",0,'','',1,'',0,},
	["guide_chapter2_3"] = {"guide_chapter2_3",0,'','',1,'',0,},
	["guide_chapter3_4"] = {"guide_chapter3_4",0,'','',1,'',0,},
	["guide_chapter4_5"] = {"guide_chapter4_5",0,'','',1,'',0,},
	["guide_chapter5_6"] = {"guide_chapter5_6",0,'','',1,'',0,},
	["guide_chapter6_7"] = {"guide_chapter6_7",0,'','',1,'',0,},
	["guide_chapter7_8"] = {"guide_chapter7_8",0,'','',1,'',0,},
	["guide_chapter8_9"] = {"guide_chapter8_9",0,'','',1,'',0,},
	["guide_chapter9_10"] = {"guide_chapter9_10",0,'','',1,'',0,},
	["guide_chapter10_11"] = {"guide_chapter10_11",0,'','',1,'',0,},
	["guide_chapter11_12"] = {"guide_chapter11_12",0,'','',1,'',0,},
	["guide_chapter12_13"] = {"guide_chapter12_13",0,'','',1,'',0,},
	["guide_chapter13_14"] = {"guide_chapter13_14",0,'','',1,'',0,},
	["guide_chapter14_15"] = {"guide_chapter14_15",0,'','',1,'',0,},
	["guide_chapter15_16"] = {"guide_chapter15_16",0,'','',1,'',0,},
	["guide_chapter16_17"] = {"guide_chapter16_17",0,'','',1,'',0,},
	["guide_chapter17_18"] = {"guide_chapter17_18",0,'','',1,'',0,},
	["guide_chapter18_19"] = {"guide_chapter18_19",0,'','',1,'',0,},
	["guide_chapter19_20"] = {"guide_chapter19_20",0,'','',1,'',0,},
	["guide_chapter20_21"] = {"guide_chapter20_21",0,'','',1,'',0,},
	["guide_chapter21_22"] = {"guide_chapter21_22",0,'','',1,'',0,},
	["guide_chapter22_23"] = {"guide_chapter22_23",0,'','',1,'',0,},
	["guide_chapter23_24"] = {"guide_chapter23_24",0,'','',1,'',0,},
	["guide_chapter24_25"] = {"guide_chapter24_25",0,'','',1,'',0,},
	["guide_chapter25_26"] = {"guide_chapter25_26",0,'','',1,'',0,},
	["guide_chapter26_27"] = {"guide_chapter26_27",0,'','',1,'',0,},
	["guide_chapter27_28"] = {"guide_chapter27_28",0,'','',1,'',0,},
	["guide_chapter28_29"] = {"guide_chapter28_29",0,'','',1,'',0,},
	["guide_chapter29_30"] = {"guide_chapter29_30",0,'','',1,'',0,},
	["guide_chapter30_31"] = {"guide_chapter30_31",0,'','',1,'',0,},
	["guide_chapter31_32"] = {"guide_chapter31_32",0,'','',1,'',0,},
	["guide_chapter32_33"] = {"guide_chapter32_33",0,'','',1,'',0,},
	["guide_chapter33_34"] = {"guide_chapter33_34",0,'','',1,'',0,},
	["guide_chapter34_35"] = {"guide_chapter34_35",0,'','',1,'',0,},
	["guide_chapter35_36"] = {"guide_chapter35_36",0,'','',1,'',0,},
	["guide_chapter36_37"] = {"guide_chapter36_37",0,'','',1,'',0,},
	["guide_chapter37_38"] = {"guide_chapter37_38",0,'','',1,'',0,},
	["guide_chapter38_39"] = {"guide_chapter38_39",0,'','',1,'',0,},
	["guide_chapter39_40"] = {"guide_chapter39_40",0,'','',1,'',0,},
	["guide_chapter40_41"] = {"guide_chapter40_41",0,'','',1,'',0,},
	["guide_chapter41_42"] = {"guide_chapter41_42",0,'','',1,'',0,},
	["guide_chapter42_43"] = {"guide_chapter42_43",0,'','',1,'',0,},
	["guide_chapter43_44"] = {"guide_chapter43_44",0,'','',1,'',0,},
	["guide_chapter44_45"] = {"guide_chapter44_45",0,'','',1,'',0,},
	["guide_chapter45_46"] = {"guide_chapter45_46",0,'','',1,'',0,},
	["guide_chapter46_47"] = {"guide_chapter46_47",0,'','',1,'',0,},
	["guide_chapter47_48"] = {"guide_chapter47_48",0,'','',1,'',0,},
	["guide_chapter48_49"] = {"guide_chapter48_49",0,'','',1,'',0,},
	["guide_chapter49_50"] = {"guide_chapter49_50",0,'','',1,'',0,},
	["guide_chapter50_51"] = {"guide_chapter50_51",0,'','',1,'',0,},
	["guide_chapter51_52"] = {"guide_chapter51_52",0,'','',1,'',0,},
	["guide_chapter52_53"] = {"guide_chapter52_53",0,'','',1,'',0,},
	["guide_chapter53_54"] = {"guide_chapter53_54",0,'','',1,'',0,},
	["guide_chapter54_55"] = {"guide_chapter54_55",0,'','',1,'',0,},
	["guide_chapter55_56"] = {"guide_chapter55_56",0,'','',1,'',0,},
	["guide_chapter56_57"] = {"guide_chapter56_57",0,'','',1,'',0,},
	["guide_chapter57_58"] = {"guide_chapter57_58",0,'','',1,'',0,},
	["guide_chapter58_59"] = {"guide_chapter58_59",0,'','',1,'',0,},
	["guide_chapter59_60"] = {"guide_chapter59_60",0,'','',1,'',0,},
	["guide_chapter60_61"] = {"guide_chapter60_61",0,'','',1,'',0,},
	["guide_chapter61_62"] = {"guide_chapter61_62",0,'','',1,'',0,},
	["guide_fight11_63"] = {"guide_fight11_63",0,'','',1,'',0,},
	["guide_chapter62_64"] = {"guide_chapter62_64",0,'','',1,'',0,},
	["guide_chapter63_65"] = {"guide_chapter63_65",0,'','',1,'',0,},
	["guide_chapter64_66"] = {"guide_chapter64_66",0,'','',1,'',0,},
	["guide_chapter65_67"] = {"guide_chapter65_67",0,'','',1,'',0,},
	["guide_fight12_68"] = {"guide_fight12_68",0,'','',1,'',0,},
	["guide_fight13_69"] = {"guide_fight13_69",0,'','',1,'',0,},
	["guide_chapter66_70"] = {"guide_chapter66_70",0,'','',1,'',0,},
	["guide_chapter67_71"] = {"guide_chapter67_71",0,'','',1,'',0,},
	["guide_chapter68_72"] = {"guide_chapter68_72",0,'','',1,'',0,},
	["guide_chapter69_73"] = {"guide_chapter69_73",0,'','',1,'',0,},
	["guide_fight21_74"] = {"guide_fight21_74",0,'','',1,'',0,},
	["guide_chapter70_75"] = {"guide_chapter70_75",0,'','',1,'',0,},
	["guide_chapter71_76"] = {"guide_chapter71_76",0,'','',1,'',0,},
	["guide_chapter72_77"] = {"guide_chapter72_77",0,'','',1,'',0,},
	["guide_fight2win_79"] = {"guide_fight2win_79",0,'','',1,'',0,},
	["guide_chapter73_80"] = {"guide_chapter73_80",0,'','',1,'',0,},
	["guide_chapter74_81"] = {"guide_chapter74_81",0,'','',1,'',0,},
	["guide_chapter75_82"] = {"guide_chapter75_82",0,'','',1,'',0,},
	["guide_chapter76_83"] = {"guide_chapter76_83",0,'','',1,'',0,},
	["guide_chapter77_84"] = {"guide_chapter77_84",0,'','',1,'',0,},
	["guide_chapter78_85"] = {"guide_chapter78_85",0,'','',1,'',0,},
	["guide_chapter79_86"] = {"guide_chapter79_86",0,'','',1,'',0,},
	["guide_chapter80_87"] = {"guide_chapter80_87",0,'','',1,'',0,},
	["guide_chapter81_88"] = {"guide_chapter81_88",0,'','',1,'',0,},
	["guide_chapter82_89"] = {"guide_chapter82_89",0,'','',1,'',0,},
	["guide_chapter83_90"] = {"guide_chapter83_90",0,'','',1,'',0,},
	["guide_chapter84_91"] = {"guide_chapter84_91",0,'','',1,'',0,},
	["guide_chapter85_92"] = {"guide_chapter85_92",0,'','',1,'',0,},
	["guide_name_93"] = {"guide_name_93",0,'','',1,'',0,},
	["guide_namerand_94"] = {"guide_namerand_94",0,'','',1,'',0,},
	["guide_namerandpage_95"] = {"guide_namerandpage_95",0,'','',1,'',0,},
	["guide_namerandfinish_96"] = {"guide_namerandfinish_96",0,'','',1,'',0,},
	["guide_chapter86_97"] = {"guide_chapter86_97",0,'','',1,'',0,},
	["guide_nameranddeny_98"] = {"guide_nameranddeny_98",0,'','',1,'',0,},
	["guide_inputpage_99"] = {"guide_inputpage_99",0,'','',1,'',0,},
	["guide_namerepeat_100"] = {"guide_namerepeat_100",0,'','',1,'',0,},
	["guide_nameinput_101"] = {"guide_nameinput_101",0,'','',1,'',0,},
	["guide_inputpage2_102"] = {"guide_inputpage2_102",0,'','',1,'',0,},
	["guide_namerepeat2_103"] = {"guide_namerepeat2_103",0,'','',1,'',0,},
	["guide_chapter87_104"] = {"guide_chapter87_104",0,'','',1,'',0,},
	["guide_chapter88_105"] = {"guide_chapter88_105",0,'','',1,'',0,},
	["guide_chapter89_106"] = {"guide_chapter89_106",0,'','',1,'',0,},
	["guide_chapter90_107"] = {"guide_chapter90_107",0,'','',1,'',0,},
	["guide_sex_108"] = {"guide_sex_108",0,'','',1,'',0,},
	["guide_chapter91_109"] = {"guide_chapter91_109",0,'','',1,'',0,},
	["guide_chapter92_110"] = {"guide_chapter92_110",0,'','',1,'',0,},
	["guide_chapter93_111"] = {"guide_chapter93_111",0,'','',1,'',0,},
	["guide_chapter94_112"] = {"guide_chapter94_112",0,'','',1,'',0,},
	["guide_chapter95_113"] = {"guide_chapter95_113",0,'','',1,'',0,},
	["guide_chapter96_114"] = {"guide_chapter96_114",0,'','',1,'',0,},
	["guide_chapter97_115"] = {"guide_chapter97_115",0,'','',1,'',0,},
	["guide_chapter98_116"] = {"guide_chapter98_116",0,'','',1,'',0,},
	["guide_chapter99_117"] = {"guide_chapter99_117",0,'','',1,'',0,},
	["guide_chapter100_118"] = {"guide_chapter100_118",0,'','',1,'',0,},
	["guide_chapter101_119"] = {"guide_chapter101_119",0,'','',1,'',0,},
	["guide_chapter102_120"] = {"guide_chapter102_120",0,'','',1,'',0,},
	["guide_chapter103_121"] = {"guide_chapter103_121",0,'','',1,'',0,},
	["guide_chapter104_122"] = {"guide_chapter104_122",0,'','',1,'',0,},
	["guide_chapter105_123"] = {"guide_chapter105_123",0,'','',1,'',0,},
	["guide_chapter106_124"] = {"guide_chapter106_124",0,'','',1,'',0,},
	["guide_chapter107_125"] = {"guide_chapter107_125",0,'','',1,'',0,},
	["guide_chapter108chose_126"] = {"guide_chapter108chose_126",0,'','',1,'',0,},
	["guide_chapter109_127"] = {"guide_chapter109_127",0,'','',1,'',0,},
	["guide_chapter110_128"] = {"guide_chapter110_128",0,'','',1,'',0,},
	["guide_chapter111_129"] = {"guide_chapter111_129",0,'','',1,'',0,},
	["guide_chapter112_130"] = {"guide_chapter112_130",0,'','',1,'',0,},
	["guide_chapter113_131"] = {"guide_chapter113_131",0,'','',1,'',0,},
	["guide_chapter114_132"] = {"guide_chapter114_132",0,'','',1,'',0,},
	["guide_chapter115_133"] = {"guide_chapter115_133",0,'','',1,'',0,},
	["guide_chapter116_134"] = {"guide_chapter116_134",0,'','',1,'',0,},
	["guide_chapter117_135"] = {"guide_chapter117_135",0,'','',1,'',0,},
	["guide_chapter118_136"] = {"guide_chapter118_136",0,'','',1,'',0,},
	["guide_chapter119chose_137"] = {"guide_chapter119chose_137",0,'','',1,'',0,},
	["guide_chapter120_138"] = {"guide_chapter120_138",0,'','',1,'',0,},
	["guide_chapter121_139"] = {"guide_chapter121_139",0,'','',1,'',0,},
	["guide_chapter122_140"] = {"guide_chapter122_140",0,'','',1,'',0,},
	["guide_chapter123_141"] = {"guide_chapter123_141",0,'','',1,'',0,},
	["guide_chapter124_142"] = {"guide_chapter124_142",0,'','',1,'',0,},
	["guide_chapter125_143"] = {"guide_chapter125_143",0,'','',1,'',0,},
	["guide_chapter126_144"] = {"guide_chapter126_144",0,'','',1,'',0,},
	["guide_chapter127_145"] = {"guide_chapter127_145",0,'','',1,'',0,},
	["guide_chapter128_146"] = {"guide_chapter128_146",0,'','',1,'',0,},
	["guide_chapter129_147"] = {"guide_chapter129_147",0,'','',1,'',0,},
	["guide_chapter130_148"] = {"guide_chapter130_148",0,'','',1,'',0,},
	["guide_chapter131_149"] = {"guide_chapter131_149",0,'','',1,'',0,},
	["guide_chapter132_150"] = {"guide_chapter132_150",0,'','',1,'',0,},
	["guide_chapter133_151"] = {"guide_chapter133_151",0,'','',1,'',0,},
	["guide_chapter134_152"] = {"guide_chapter134_152",0,'','',1,'',0,},
	["guide_chapter135_153"] = {"guide_chapter135_153",0,'','',1,'',0,},
	["guide_chapter136_154"] = {"guide_chapter136_154",0,'','',1,'',0,},
	["guide_chapter137_155"] = {"guide_chapter137_155",0,'','',1,'',0,},
	["guide_chapter138_156"] = {"guide_chapter138_156",0,'','',1,'',0,},
	["guide_chapter139_157"] = {"guide_chapter139_157",0,'','',1,'',0,},
	["guide_chapter140_158"] = {"guide_chapter140_158",0,'','',1,'',0,},
	["guide_chapter141_159"] = {"guide_chapter141_159",0,'','',1,'',0,},
	["guide_chapter142chose_160"] = {"guide_chapter142chose_160",0,'','',1,'',0,},
	["guide_chapter143_161"] = {"guide_chapter143_161",0,'','',1,'',0,},
	["guide_chapter144_162"] = {"guide_chapter144_162",0,'','',1,'',0,},
	["guide_chapter145_163"] = {"guide_chapter145_163",0,'','',1,'',0,},
	["guide_chapter146_164"] = {"guide_chapter146_164",0,'','',1,'',0,},
	["guide_chapter147_165"] = {"guide_chapter147_165",0,'','',1,'',0,},
	["guide_softguide_166"] = {"guide_softguide_166",0,'','',1,'',0,},
	["guide_chapter148_167"] = {"guide_chapter148_167",0,'','',1,'',0,},
	["guide_chapter149_168"] = {"guide_chapter149_168",0,'','',1,'',0,},
	["guide_chapter150_169"] = {"guide_chapter150_169",0,'','',1,'',0,},
	["guide_chapter151_170"] = {"guide_chapter151_170",0,'','',1,'',0,},
	["guide_chapter152_171"] = {"guide_chapter152_171",0,'','',1,'',0,},
	["guide_gachapop_176"] = {"guide_gachapop_176",0,'','',1,'',0,},
	["guide_gachafinish_178"] = {"guide_gachafinish_178",0,'','',1,'',0,},
	["guide_touch_179"] = {"guide_touch_179",0,'','',1,'',0,},
	["guide_gachapage2_180"] = {"guide_gachapage2_180",0,'','',1,'',0,},
	["guide_chapter153_182"] = {"guide_chapter153_182",0,'','',1,'',0,},
	["guide_chapter154_183"] = {"guide_chapter154_183",0,'','',1,'',0,},
	["guide_chapter155_184"] = {"guide_chapter155_184",0,'','',1,'',0,},
	["guide_chapter156_185"] = {"guide_chapter156_185",0,'','',1,'',0,},
	["guide_chapter157_186"] = {"guide_chapter157_186",0,'','',1,'',0,},
	["guide_teampage_188"] = {"guide_teampage_188",0,'','',1,'',0,},
	["guide_chapter158_193"] = {"guide_chapter158_193",0,'','',1,'',0,},
	["guide_chapter159_194"] = {"guide_chapter159_194",0,'','',1,'',0,},
	["guide_chapter160_195"] = {"guide_chapter160_195",0,'','',1,'',0,},
	["guide_chapter161_196"] = {"guide_chapter161_196",0,'','',1,'',0,},
	["guide_chapter162_197"] = {"guide_chapter162_197",0,'','',1,'',0,},
	["guide_chapter163_198"] = {"guide_chapter163_198",0,'','',1,'',0,},
	["guide_chapter164_199"] = {"guide_chapter164_199",0,'','',1,'',0,},
	["guide_chapter165_200"] = {"guide_chapter165_200",0,'','',1,'',0,},
	["guide_chapter166_202"] = {"guide_chapter166_202",0,'','',1,'',0,},
	["guide_chapter167_203"] = {"guide_chapter167_203",0,'','',1,'',0,},
	["guide_chapter168_204"] = {"guide_chapter168_204",0,'','',1,'',0,},
	["guide_fightpage_209"] = {"guide_fightpage_209",0,'','',1,'',0,},
	["guide_autofight_210"] = {"guide_autofight_210",0,'','',1,'',0,},
	["guide_quickfight_211"] = {"guide_quickfight_211",0,'','',1,'',0,},
	["guide_continue_213"] = {"guide_continue_213",0,'','',1,'',0,},
	["guide_boatget_214"] = {"guide_boatget_214",0,'','',1,'',0,},
	["guide_touch2_215"] = {"guide_touch2_215",0,'','',1,'',0,},
	["guide_returnmap_216"] = {"guide_returnmap_216",0,'','',1,'',0,},
	["guide_rewardpop_217"] = {"guide_rewardpop_217",0,'','',1,'',0,},
	["guide_levelup_218"] = {"guide_levelup_218",0,'','',1,'',0,},
	["guide_gacha2_221"] = {"guide_gacha2_221",0,'','',1,'',0,},
	["guide_gachaall2_222"] = {"guide_gachaall2_222",0,'','',1,'',0,},
	["guide_gachaten_223"] = {"guide_gachaten_223",0,'','',1,'',0,},
	["guide_gachapop2_224"] = {"guide_gachapop2_224",0,'','',1,'',0,},
	["guide_gachaconfirm2_225"] = {"guide_gachaconfirm2_225",0,'','',1,'',0,},
	["guide_gachacg_226"] = {"guide_gachacg_226",0,'','',1,'',0,},
	["guide_gachaclick_227"] = {"guide_gachaclick_227",0,'','',1,'',0,},
	["guide_gachaskip_228"] = {"guide_gachaskip_228",0,'','',1,'',0,},
	["guide_gacharesult_229"] = {"guide_gacharesult_229",0,'','',1,'',0,},
	["guide_touch4_230"] = {"guide_touch4_230",0,'','',1,'',0,},
	["guide_area2_233"] = {"guide_area2_233",0,'','',1,'',0,},
	["guide_hourblechoose2_234"] = {"guide_hourblechoose2_234",0,'','',1,'',0,},
	["guide_residence_235"] = {"guide_residence_235",0,'','',1,'',0,},
	["guide_residenceteamadd_236"] = {"guide_residenceteamadd_236",0,'','',1,'',0,},
	["guide_chooseboat2_237"] = {"guide_chooseboat2_237",0,'','',1,'',0,},
	["guide_boatconfirm_238"] = {"guide_boatconfirm_238",0,'','',1,'',0,},
	["guide_return_239"] = {"guide_return_239",0,'','',1,'',0,},
	["guide_hourblechoose3_240"] = {"guide_hourblechoose3_240",0,'','',1,'',0,},
	["guide_attackconfirm2_241"] = {"guide_attackconfirm2_241",0,'','',1,'',0,},
	["guide_chapter169_242"] = {"guide_chapter169_242",0,'','',1,'',0,},
	["guide_pass2_243"] = {"guide_pass2_243",0,'','',1,'',0,},
	["guide_chapter170_244"] = {"guide_chapter170_244",0,'','',1,'',0,},
	["guide_chapter171_245"] = {"guide_chapter171_245",0,'','',1,'',0,},
	["guide_chapter172_246"] = {"guide_chapter172_246",0,'','',1,'',0,},
	["guide_chapter173_247"] = {"guide_chapter173_247",0,'','',1,'',0,},
	["guide_chapter174_248"] = {"guide_chapter174_248",0,'','',1,'',0,},
	["guide_chapter175_249"] = {"guide_chapter175_249",0,'','',1,'',0,},
	["guide_chapter176_250"] = {"guide_chapter176_250",0,'','',1,'',0,},
	["guide_chapter177_251"] = {"guide_chapter177_251",0,'','',1,'',0,},
	["guide_chapter178_252"] = {"guide_chapter178_252",0,'','',1,'',0,},
	["guide_chapter179_253"] = {"guide_chapter179_253",0,'','',1,'',0,},
	["guide_chapter180_254"] = {"guide_chapter180_254",0,'','',1,'',0,},
	["guide_chapter181_255"] = {"guide_chapter181_255",0,'','',1,'',0,},
	["guide_chapter182_256"] = {"guide_chapter182_256",0,'','',1,'',0,},
	["guide_chapter183_257"] = {"guide_chapter183_257",0,'','',1,'',0,},
	["guide_chapter184_258"] = {"guide_chapter184_258",0,'','',1,'',0,},
	["guide_chapter185_259"] = {"guide_chapter185_259",0,'','',1,'',0,},
	["guide_chapter186_260"] = {"guide_chapter186_260",0,'','',1,'',0,},
	["guide_chapter187chose_261"] = {"guide_chapter187chose_261",0,'','',1,'',0,},
	["guide_chapter188_262"] = {"guide_chapter188_262",0,'','',1,'',0,},
	["guide_chapter189_263"] = {"guide_chapter189_263",0,'','',1,'',0,},
	["guide_chapter190_264"] = {"guide_chapter190_264",0,'','',1,'',0,},
	["guide_chapter191_265"] = {"guide_chapter191_265",0,'','',1,'',0,},
	["guide_chapter192_266"] = {"guide_chapter192_266",0,'','',1,'',0,},
	["guide_chapter193_267"] = {"guide_chapter193_267",0,'','',1,'',0,},
	["guide_chapter194_268"] = {"guide_chapter194_268",0,'','',1,'',0,},
	["guide_chapter195_269"] = {"guide_chapter195_269",0,'','',1,'',0,},
	["guide_chapter196_270"] = {"guide_chapter196_270",0,'','',1,'',0,},
	["guide_chapter197_271"] = {"guide_chapter197_271",0,'','',1,'',0,},
	["guide_chapter198_272"] = {"guide_chapter198_272",0,'','',1,'',0,},
	["guide_chapter199_273"] = {"guide_chapter199_273",0,'','',1,'',0,},
	["guide_chapter200_274"] = {"guide_chapter200_274",0,'','',1,'',0,},
	["guide_chapter201_275"] = {"guide_chapter201_275",0,'','',1,'',0,},
	["guide_chapter202_276"] = {"guide_chapter202_276",0,'','',1,'',0,},
	["guide_chapter203_277"] = {"guide_chapter203_277",0,'','',1,'',0,},
	["guide_chapter204_278"] = {"guide_chapter204_278",0,'','',1,'',0,},
	["guide_chapter205_279"] = {"guide_chapter205_279",0,'','',1,'',0,},
	["guide_fight31_280"] = {"guide_fight31_280",0,'','',1,'',0,},
	["guide_chapter206_283"] = {"guide_chapter206_283",0,'','',1,'',0,},
	["guide_chapter207_284"] = {"guide_chapter207_284",0,'','',1,'',0,},
	["guide_sitechange_286"] = {"guide_sitechange_286",0,'','',1,'',0,},
	["guide_fight3win_287"] = {"guide_fight3win_287",0,'','',1,'',0,},
	["guide_fightresult_288"] = {"guide_fightresult_288",0,'','',1,'',0,},
	["guide_fightitem_289"] = {"guide_fightitem_289",0,'','',1,'',0,},
	["guide_bondexp_290"] = {"guide_bondexp_290",0,'','',1,'',0,},
	["guide_touch5_291"] = {"guide_touch5_291",0,'','',1,'',0,},
	["guide_chapter208_292"] = {"guide_chapter208_292",0,'','',1,'',0,},
	["guide_pass3_293"] = {"guide_pass3_293",0,'','',1,'',0,},
	["guide_boatget2_294"] = {"guide_boatget2_294",0,'','',1,'',0,},
	["guide_touch6_295"] = {"guide_touch6_295",0,'','',1,'',0,},
	["guide_rewardpop2_296"] = {"guide_rewardpop2_296",0,'','',1,'',0,},
	["guide_touch7_297"] = {"guide_touch7_297",0,'','',1,'',0,},
	["guide_levelup2_298"] = {"guide_levelup2_298",0,'','',1,'',0,},
	["guide_revengetip_299"] = {"guide_revengetip_299",0,'','',1,'',0,},
	["guide_chapter209_300"] = {"guide_chapter209_300",0,'','',1,'',0,},
	["guide_chapter210_301"] = {"guide_chapter210_301",0,'','',1,'',0,},
	["guide_chapter211_302"] = {"guide_chapter211_302",0,'','',1,'',0,},
	["guide_mine_303"] = {"guide_mine_303",0,'','',1,'',0,},
	["guide_mineget_304"] = {"guide_mineget_304",0,'','',1,'',0,},
	["guide_minereward_305"] = {"guide_minereward_305",0,'','',1,'',0,},
	["guide_jump4_306"] = {"guide_jump4_306",0,'','',1,'',0,},
	["guide_upgrade2_310"] = {"guide_upgrade2_310",0,'','',1,'',0,},
	["guide_upgrade4_312"] = {"guide_upgrade4_312",0,'','',1,'',0,},
	["guide_upgrade6_314"] = {"guide_upgrade6_314",0,'','',1,'',0,},
	["guide_chapter212_321"] = {"guide_chapter212_321",0,'','',1,'',0,},
	["guide_chapter213_322"] = {"guide_chapter213_322",0,'','',1,'',0,},
	["guide_chapter214_323"] = {"guide_chapter214_323",0,'','',1,'',0,},
	["guide_chapter215_324"] = {"guide_chapter215_324",0,'','',1,'',0,},
	["guide_chapter216_325"] = {"guide_chapter216_325",0,'','',1,'',0,},
	["guide_chapter217_326"] = {"guide_chapter217_326",0,'','',1,'',0,},
	["guide_chapter218_327"] = {"guide_chapter218_327",0,'','',1,'',0,},
	["guide_chapter219_328"] = {"guide_chapter219_328",0,'','',1,'',0,},
	["guide_chapter220_329"] = {"guide_chapter220_329",0,'','',1,'',0,},
	["guide_chapter221_330"] = {"guide_chapter221_330",0,'','',1,'',0,},
	["guide_chapter222_336"] = {"guide_chapter222_336",0,'','',1,'',0,},
	["guide_pass4_337"] = {"guide_pass4_337",0,'','',1,'',0,},
	["guide_chapter223_338"] = {"guide_chapter223_338",0,'','',1,'',0,},
	["guide_pass5_339"] = {"guide_pass5_339",0,'','',1,'',0,},
	["guide_deepfinish_340"] = {"guide_deepfinish_340",0,'','',1,'',0,},
	["guide_touch8_341"] = {"guide_touch8_341",0,'','',1,'',0,},
	["guide_chapter224_342"] = {"guide_chapter224_342",0,'','',1,'',0,},
	["guide_pass6_343"] = {"guide_pass6_343",0,'','',1,'',0,},
	["guide_area3_346"] = {"guide_area3_346",0,'','',1,'',0,},
	["guide_denfendrwd_347"] = {"guide_denfendrwd_347",0,'','',1,'',0,},
	["guide_rewardpop3_348"] = {"guide_rewardpop3_348",0,'','',1,'',0,},
	["guide_touch9_349"] = {"guide_touch9_349",0,'','',1,'',0,},
	["guide_chapter225_350"] = {"guide_chapter225_350",0,'','',1,'',0,},
	["guide_chapter226_351"] = {"guide_chapter226_351",0,'','',1,'',0,},
	["guide_chapter227_352"] = {"guide_chapter227_352",0,'','',1,'',0,},
	["guide_chapter228_353"] = {"guide_chapter228_353",0,'','',1,'',0,},
	["LOGIN_SDKUI_OPEN"] = {"LOGIN_SDKUI_OPEN",0,'','',4,'',0,},
	["LOGIN_SDK_SUCCESS"] = {"LOGIN_SDK_SUCCESS",0,'','',4,'',0,},
	["LOGIN_SDK_FAIL"] = {"LOGIN_SDK_FAIL",0,'','',4,'',0,},
	["LOGIN_GETNOTICE_SUCCES"] = {"LOGIN_GETNOTICE_SUCCES",0,'','',4,'',0,},
	["LOGIN_GETNOTICE_FAIL"] = {"LOGIN_GETNOTICE_FAIL",0,'','',4,'',0,},
	["LOGIN_SERVER_SUCCES"] = {"LOGIN_SERVER_SUCCES",0,'','',4,'',0,},
	["manoeuvre"] = {"manoeuvre",0,'','',1,'',0,},
	["manoeuvre_attack"] = {"manoeuvre_attack",0,'','',1,'',0,},
	["manoeuvre_choose"] = {"manoeuvre_choose",0,'','',1,'',0,},
	["memories"] = {"memories",0,'','',1,'',0,},
	["memories_attack"] = {"memories_attack",0,'','',1,'',0,},
	["memories_attack2"] = {"memories_attack2",0,'','',1,'',0,},
	["memories_chapter1"] = {"memories_chapter1",0,'','',1,'',0,},
	["memories_harbour"] = {"memories_harbour",0,'','',1,'',0,},
	["LOGIN_SERVER_FAIL"] = {"LOGIN_SERVER_FAIL",0,'','',4,'',0,},
	["WEBSOCKET_START"] = {"WEBSOCKET_START",0,'','',4,'',0,},
	["WEBSOCKET_SUCCES"] = {"WEBSOCKET_SUCCES",0,'','',4,'',0,},
	["WEBSOCKET_FAIL"] = {"WEBSOCKET_FAIL",0,'','',4,'',0,},
	["HOTUPDATE_ABLIST_BEGIN"] = {"HOTUPDATE_ABLIST_BEGIN",0,'','',4,'',0,},
	["HOTUPDATE_ABLIST_SUCCESS"] = {"HOTUPDATE_ABLIST_SUCCESS",0,'','',4,'',0,},
	["HOTUPDATE_FILELIST_BEGIN"] = {"HOTUPDATE_FILELIST_BEGIN",0,'','',4,'',0,},
	["HOTUPDATE_FILELIST_RETRY"] = {"HOTUPDATE_FILELIST_RETRY",0,'','',4,'',0,},
	["HOTUPDATE_FILELIST_SUCCESS"] = {"HOTUPDATE_FILELIST_SUCCESS",0,'','',4,'',0,},
	["levia"] = {"levia",0,'','',1,'',0,},
	["levia_attack"] = {"levia_attack",0,'','',1,'',0,},
	["levia_down"] = {"levia_down",0,'','',1,'',0,},
	["levia_exp"] = {"levia_exp",0,'','',1,'',0,},
	["RECHARGE_BTN_CLICK"] = {"RECHARGE_BTN_CLICK",0,'','',5,'',0,},
	["RECHARGE_SERVER_REQUEST"] = {"RECHARGE_SERVER_REQUEST",0,'','',5,'',0,},
	["RECHARGE_SERVER_RESPONSE_SUCCES"] = {"RECHARGE_SERVER_RESPONSE_SUCCES",0,'','',5,'',0,},
	["ship"] = {"ship",0,'','',1,'',0,},
	["ship_body"] = {"ship_body",0,'','',1,'',0,},
	["ship_chooseequip"] = {"ship_chooseequip",0,'','',1,'',0,},
	["ship_chooseship"] = {"ship_chooseship",0,'','',1,'',0,},
	["ship_equip"] = {"ship_equip",0,'','',1,'',0,},
	["ship_equipchange"] = {"ship_equipchange",0,'','',1,'',0,},
	["ship_strength"] = {"ship_strength",0,'','',1,'',0,},
	["ship_up"] = {"ship_up",0,'','',1,'',0,},
	["ship2"] = {"ship2",0,'','',1,'',0,},
	["ship2_add"] = {"ship2_add",0,'','',1,'',0,},
	["ship2_choose"] = {"ship2_choose",0,'','',1,'',0,},
	["ship2_choosetech"] = {"ship2_choosetech",0,'','',1,'',0,},
	["ship2_tech"] = {"ship2_tech",0,'','',1,'',0,},
	["ship2_up"] = {"ship2_up",0,'','',1,'',0,},
	["RECHARGE_SERVER_RESPONSE_FAIL"] = {"RECHARGE_SERVER_RESPONSE_FAIL",0,'','',5,'',0,},
	["RECHARGE_SDK_CALLBACK_SUCCES"] = {"RECHARGE_SDK_CALLBACK_SUCCES",0,'','',5,'',0,},
	["RECHARGE_SDK_CALLBACK_FAIL"] = {"RECHARGE_SDK_CALLBACK_FAIL",0,'','',5,'',0,},
	["RECHARGE_CANCEL"] = {"RECHARGE_CANCEL",0,'','',5,'',0,},
	["RECHARGE_SERVER_LOOP_REPONSE_SUCCES"] = {"RECHARGE_SERVER_LOOP_REPONSE_SUCCES",0,'','',5,'',0,},
	["RECHARGE_SERVER_LOOP_REPONSE_FAIL"] = {"RECHARGE_SERVER_LOOP_REPONSE_FAIL",0,'','',5,'',0,},
	["RECHARGE_INQUIRY_FAIL"] = {"RECHARGE_INQUIRY_FAIL",0,'','',5,'',0,},
	["CLIENT_TIME_MTP_26"] = {"CLIENT_TIME_MTP_26",0,'','',1,'',0,},
	["CLIENT_TIME_WIFI_3G4G_27"] = {"CLIENT_TIME_WIFI_3G4G_27",0,'','',1,'',0,},
	["depot"] = {"depot",0,'','',1,'',0,},
	["depot_use"] = {"depot_use",0,'','',1,'',0,},
	["dock_choose"] = {"dock_choose",0,'','',1,'',0,},
	["dock_confirm"] = {"dock_confirm",0,'','',1,'',0,},
	["dock_control"] = {"dock_control",0,'','',1,'',0,},
	["dock_dec"] = {"dock_dec",0,'','',1,'',0,},
	["dock_equip"] = {"dock_equip",0,'','',1,'',0,},
	["dock_furniture"] = {"dock_furniture",0,'','',1,'',0,},
	["dock_order"] = {"dock_order",0,'','',1,'',0,},
	["dock_order2"] = {"dock_order2",0,'','',1,'',0,},
	["dock_owner"] = {"dock_owner",0,'','',1,'',0,},
	["dock_quit"] = {"dock_quit",0,'','',1,'',0,},
	["dock_room"] = {"dock_room",0,'','',1,'',0,},
	["dock_save"] = {"dock_save",0,'','',1,'',0,},
	["dock_switch"] = {"dock_switch",0,'','',1,'',0,},
	["gift_click"] = {"gift_click",0,'','',1,'',0,},
	["gift_tips"] = {"gift_tips",0,'','',1,'',0,},
	["CLIENT_TIME_3G4G_WIFI_28"] = {"CLIENT_TIME_3G4G_WIFI_28",0,'','',1,'',0,},
	["CLIENT_TIME_AWAKE_1"] = {"CLIENT_TIME_AWAKE_1",0,'','',1,'',0,},
	["CLIENT_TIME_OBBSUCCESS_2"] = {"CLIENT_TIME_OBBSUCCESS_2",0,'','',1,'',0,},
	["CLIENT_TIME_OBBUI_3"] = {"CLIENT_TIME_OBBUI_3",0,'','',1,'',0,},
	["CLIENT_TIME_OBBOKBTN_4"] = {"CLIENT_TIME_OBBOKBTN_4",0,'','',1,'',0,},
	["CLIENT_TIME_OBBDOWNLOADING_5"] = {"CLIENT_TIME_OBBDOWNLOADING_5",0,'','',1,'',0,},
	["CLIENT_TIME_QUALITYLEVEL_29"] = {"CLIENT_TIME_QUALITYLEVEL_29",0,'','',1,'',0,},
	["CLIENT_TIME_QUALITYLEVELCALCULATION_30"] = {"CLIENT_TIME_QUALITYLEVELCALCULATION_30",0,'','',1,'',0,},
	["CLIENT_TIME_QUALITYLEVELCHANGE_31"] = {"CLIENT_TIME_QUALITYLEVELCHANGE_31",0,'','',1,'',0,},
	["RECHARGE_SDK_UI_OPEN"] = {"RECHARGE_SDK_UI_OPEN",0,'','',5,'',0,},
	["RECHARGE_SERVER_LOOP_REQUEST"] = {"RECHARGE_SERVER_LOOP_REQUEST",0,'','',5,'',0,},
}

function ClientTimeConfig.GetConfig(key)
	local tb = ClientTimeConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["name"] = 1,["clienttimetype"] = 2,["parameter"] = 3,["parameter2"] = 4,["server"] = 5,["serverarg"] = 6,["nazo"] = 7,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return ClientTimeConfig