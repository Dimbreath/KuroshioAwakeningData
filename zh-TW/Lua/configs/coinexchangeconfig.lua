local CoinExchangeConfig = {}

CoinExchangeConfig.Values = {
	[41] = {41,15,[[徵招合約]],"1,160001,1",1,10,"1,250010,30",'',0,true,0,},
	[42] = {42,15,[[特批調令]],"1,120001,1",2,10,"1,250010,15",'',0,true,0,},
	[49] = {49,15,[[中級裝備箱]],"1,240007,1",9,5,"1,250010,10",'',0,true,0,},
	[60201] = {60201,101,[[奈米神經元件*500]],"1,135000,500",4,4,"1,29,10",'',0,true,0,},
	[60202] = {60202,101,[[S型人偶]],"2,90011,1",12,1,"1,29,200",'',2,false,0,},
	[60203] = {60203,101,[[A型人偶]],"2,90010,1",11,2,"1,29,40",'',2,true,0,},
	[60204] = {60204,101,[[初級裝備箱]],"1,240201,1",8,15,"1,29,6",'',0,true,0,},
	[60205] = {60205,101,[[中級裝備箱]],"1,240202,1",9,10,"1,29,20",'',0,true,0,},
	[60206] = {60206,101,[[高級裝備箱]],"1,240203,1",10,5,"1,29,40",'',0,true,0,},
	[60207] = {60207,101,[[初級深海化箱]],"1,240040,1",5,20,"1,29,2",'',0,true,0,},
	[60208] = {60208,101,[[中級深海化箱]],"1,240041,1",6,10,"1,29,8",'',0,true,0,},
	[60209] = {60209,101,[[高級深海化箱]],"1,240042,1",7,5,"1,29,20",'',0,true,0,},
	[60210] = {60210,101,[[元氣櫻花餅]],"1,240006,1",3,200,"1,29,2",'',0,true,0,},
	[60211] = {60211,101,[[BP卡．60min]],"1,260002,1",2,200,"1,29,2",'',0,true,0,},
	[60212] = {60212,101,[[賦絡溶液儲罐]],"1,260001,1",1,200,"1,29,2",'',0,true,0,},
	[60213] = {60213,101,[[步數指定]],"1,880001,1",15,999,"1,1,75",'',0,true,0,},
	[60214] = {60214,101,[[雙骰子道具]],"1,880002,1",14,999,"1,1,50",'',0,true,0,},
	[60215] = {60215,101,[[慾念之骰]],"1,880003,1",13,999,"1,1,50",'',0,true,0,},
	[90001] = {90001,26,[[響]],"2,50140,1",13,1,"1,33,2000",'',0,true,0,},
	[90002] = {90002,26,[[曉]],"2,50020,1",12,1,"1,33,2000",'',0,false,0,},
	[90003] = {90003,26,[[35.6cm連裝砲]],"6,106025001,1",11,1,"1,33,1000",'',2,false,0,},
	[90004] = {90004,26,[[三聯裝九三式氧氣魚雷]],"6,205014001,1",10,1,"1,33,1000",'',2,true,0,},
	[90005] = {90005,26,[[基地-神代會社]],"1,680107,1",9,1,"1,33,660",'',0,false,0,},
	[90006] = {90006,26,[[深海結晶·神代*5]],"1,144008,5",8,20,"1,33,50",'',0,true,0,},
	[90007] = {90007,26,[[深海結晶·戰艦*10]],"1,145601,10",7,20,"1,33,15",'',0,false,0,},
	[90008] = {90008,26,[[深海結晶·驅逐*10]],"1,145501,10",6,20,"1,33,15",'',0,true,0,},
	[90009] = {90009,26,[[奈米神經元件*500]],"1,135000,500",5,40,"1,33,25",'',0,true,0,},
	[20001] = {20001,8,"Z1","2,50490,1",25,1,"1,12,400",'',4,false,0,},
	[20002] = {20002,8,[[SG雷達]],"6,603018001,1",23,1,"1,12,5000",'',0,false,0,},
	[20003] = {20003,8,[[A型人偶]],"2,90010,1",22,3,"1,12,100",'',0,true,0,},
	[20004] = {20004,8,[[高級裝備箱]],"1,240021,1",21,10,"1,12,45",'',0,false,0,},
	[20005] = {20005,8,[[徵招合約]],"1,160001,1",1,10,"1,12,100",'',0,false,0,},
	[20013] = {20013,8,[[能源*60]],"1,3,60",1,9999,"1,12,60",'',0,false,0,},
	[20014] = {20014,8,[[深海污泥．神代*4]],"1,142008,4",1,139,"1,12,20",'',0,false,0,},
	[20015] = {20015,8,[[深海原石．神代*2]],"1,143008,2",5,102,"1,12,20",'',0,false,0,},
	[20016] = {20016,8,[[深海結晶．神代]],"1,144008,1",9,10,"1,12,24",'',0,true,0,},
	[20017] = {20017,8,[[深海污泥．銀翼*4]],"1,142009,4",2,139,"1,12,20",'',0,false,0,},
	[20018] = {20018,8,[[深海原石．銀翼*2]],"1,143009,2",6,102,"1,12,20",'',0,false,0,},
	[20019] = {20019,8,[[深海結晶．銀翼]],"1,144009,1",10,10,"1,12,24",'',0,true,0,},
	[20020] = {20020,8,[[深海污泥．薔薇*4]],"1,142010,4",3,139,"1,12,20",'',0,false,0,},
	[20021] = {20021,8,[[深海原石．薔薇*2]],"1,143010,2",7,102,"1,12,20",'',0,false,0,},
	[20022] = {20022,8,[[深海結晶．薔薇]],"1,144010,1",11,10,"1,12,24",'',0,true,0,},
	[20023] = {20023,8,[[深海污泥．黑鋒*4]],"1,142011,4",4,139,"1,12,20",'',0,false,0,},
	[20024] = {20024,8,[[深海原石．黑鋒*2]],"1,143011,2",8,102,"1,12,20",'',0,false,0,},
	[20025] = {20025,8,[[深海結晶．黑鋒]],"1,144011,1",12,10,"1,12,24",'',0,true,0,},
	[20026] = {20026,8,[[深海結晶．航母*20]],"1,145101,20",13,43,"1,12,120",'',0,false,0,},
	[20027] = {20027,8,[[深海結晶．輕巡*20]],"1,145301,20",14,43,"1,12,120",'',0,false,0,},
	[20028] = {20028,8,[[深海結晶．重巡*20]],"1,145401,20",15,43,"1,12,120",'',0,false,0,},
	[20029] = {20029,8,[[深海結晶．驅逐*20]],"1,145501,20",16,43,"1,12,120",'',0,false,0,},
	[20030] = {20030,8,[[深海結晶．戰艦*20]],"1,145601,20",17,43,"1,12,120",'',0,false,0,},
	[20031] = {20031,8,[[胡德]],"2,60050,1",26,1,"1,12,400",'',0,false,0,},
	[20032] = {20032,8,[[35.6cm連裝砲]],"6,106025001,1",24,1,"1,12,320",'',0,false,0,},
	[20033] = {20033,8,[[賦絡溶液儲罐]],"1,260001,1",8,999,"1,12,10",'',0,true,0,},
	[20034] = {20034,8,[[BP卡．60min]],"1,260002,1",7,999,"1,12,10",'',0,true,0,},
	[20035] = {20035,8,[[奈米神經元件*500]],"1,135000,500",6,40,"1,12,25",'',0,true,0,},
	[20036] = {20036,8,[[高級深海化箱]],"1,240206,1",20,10,"1,12,75",'',0,true,0,},
	[20037] = {20037,8,[[中級深海化箱]],"1,240205,1",19,10,"1,12,30",'',0,true,0,},
	[20038] = {20038,8,[[深海化材料艦種箱*20]],"1,240207,20",18,40,"1,12,30",'',0,true,0,},
	[20039] = {20039,8,[[初級裝備箱]],"1,240201,1",16,10,"1,12,15",'',0,true,0,},
	[20040] = {20040,8,[[中級裝備箱]],"1,240202,1",17,10,"1,12,50",'',0,true,0,},
	[20041] = {20041,8,[[千代田]],"2,20090,1",21,1,"1,12,500",'',0,true,0,},
	[30001] = {30001,9,[[SKC34 283mm三聯裝砲]],"6,106007001,1",23,1,"1,13,5000",'',0,false,0,},
	[30002] = {30002,9,[[S型人偶]],"2,90011,1",25,1,"1,12,1000",'',0,true,0,},
	[30003] = {30003,9,[[能源*100]],"1,3,100",14,9999,"1,13,60",'',0,false,0,},
	[30004] = {30004,9,[[夕張]],"2,30170,1",27,1,"1,13,7500",'',4,true,0,},
	[30005] = {30005,9,"BP*5000","1,2,5000",15,9999,"1,13,30",'',0,false,0,},
	[30006] = {30006,9,[[獨角獸]],"2,10120,1",26,1,"1,13,500",'',2,false,0,},
	[30007] = {30007,9,[[280B型對空雷達]],"6,601012001,1",24,1,"1,13,400",'',0,false,0,},
	[30008] = {30008,9,[[高級裝備箱]],"1,240203,1",21,10,"1,13,100",'',0,true,0,},
	[30009] = {30009,9,[[賦絡溶液儲罐]],"1,260001,1",18,999,"1,13,10",'',0,true,0,},
	[30010] = {30010,9,[[BP卡．60min]],"1,260002,1",17,999,"1,13,10",'',0,true,0,},
	[30011] = {30011,9,[[深海結晶．神代*5]],"1,144008,5",9,20,"1,13,120",'',0,true,0,},
	[30012] = {30012,9,[[高級深海化箱]],"1,240206,1",22,10,"1,12,75",'',0,true,0,},
	[30013] = {30013,9,[[SG雷達]],"6,603018001,1",24,1,"1,12,1250",'',0,true,0,},
	[30014] = {30014,9,[[皮米材料*100]],"1,145002,100",19,25,"1,12,25",'',0,true,0,},
	[30015] = {30015,9,[[深海尖晶*50]],"1,145001,50",20,10,"1,12,25",'',0,true,0,},
	[30016] = {30016,9,[[九七式艦攻]],"6,302009001,1",23,1,"1,12,1000",'',0,true,0,},
	[9001] = {9001,9000,[[海王星]],"2,30130,1",12,1,"1,14,1500","1,4",4,true,0,},
	[90010] = {90010,26,[[賦絡溶液儲罐*2]],"1,260001,2",4,999,"1,33,10",'',0,true,0,},
	[90011] = {90011,26,[[BP儲卡·60min*2]],"1,260002,2",3,999,"1,33,10",'',0,true,0,},
	[90012] = {90012,26,[[賦絡溶液*500]],"1,24,500",2,999,"1,33,1",'',0,true,0,},
	[90013] = {90013,26,"BP*500","1,2,500",1,999,"1,33,1",'',0,true,0,},
	[9002] = {9002,9000,[[S型人偶]],"2,90011,1",11,1,"1,14,1200","1,4",0,true,0,},
	[9003] = {9003,9000,[[A型人偶]],"2,90010,1",10,4,"1,14,300","1,3",0,true,0,},
	[9004] = {9004,9000,[[高級武器箱]],"1,240050,1",9,1,"1,14,250","1,3",0,true,0,},
	[9005] = {9005,9000,[[高級裝置箱]],"1,240051,1",8,2,"1,14,200","1,3",0,true,0,},
	[9006] = {9006,9000,[[妙高]],"2,40020,1",7,1,"1,14,200","1,2",0,true,0,},
	[9007] = {9007,9000,[[奈米神經元件*1000]],"1,135000,1000",6,20,"1,14,150",'',0,true,0,},
	[9008] = {9008,9000,[[高級深海化寶箱]],"1,240042,1",5,2,"1,14,150",'',0,true,0,},
	[91001] = {91001,29,[[高級深海化箱]],"1,240206,1",17,10,"1,41,150",'',0,true,0,},
	[91002] = {91002,29,[[中級深海化箱]],"1,240205,1",15,10,"1,41,60",'',0,true,0,},
	[91003] = {91003,29,[[深海結晶·神代]],"1,144008,1",11,10,"1,41,48",'',0,true,0,},
	[91004] = {91004,29,[[深海結晶·銀翼]],"1,144009,1",10,10,"1,41,48",'',0,true,0,},
	[91005] = {91005,29,[[深海結晶·薔薇]],"1,144010,1",9,10,"1,41,48",'',0,true,0,},
	[91006] = {91006,29,[[深海結晶·黑鋒]],"1,144011,1",8,10,"1,41,48",'',0,true,0,},
	[91007] = {91007,29,[[深海化材料艦種箱*20]],"1,240207,20",16,40,"1,41,60",'',0,true,0,},
	[91008] = {91008,29,[[奈米神經元件*500]],"1,135000,500",5,40,"1,41,50",'',0,true,0,},
	[91009] = {91009,29,[[標槍]],"2,50420,1",21,1,"1,41,1000",'',0,true,0,},
	[91010] = {91010,29,[[A型人偶]],"2,90010,1",20,3,"1,41,200",'',0,true,0,},
	[91011] = {91011,29,[[初級裝備箱]],"1,240201,1",12,10,"1,41,30",'',0,true,0,},
	[91012] = {91012,29,[[中級裝備箱]],"1,240202,1",13,10,"1,41,100",'',0,true,0,},
	[91013] = {91013,29,[[賦絡溶液儲罐]],"1,260001,1",4,999,"1,41,20",'',0,true,0,},
	[91014] = {91014,29,[[BP卡·60min]],"1,260002,1",3,999,"1,41,20",'',0,true,0,},
	[92001] = {92001,30,[[深海結晶·銀翼*5]],"1,144009,5",19,15,"1,42,240",'',0,true,0,},
	[92002] = {92002,30,[[高級深海化箱]],"1,240206,1",18,10,"1,41,150",'',0,true,0,},
	[92003] = {92003,30,[[高級裝備箱]],"1,240203,1",14,10,"1,41,200",'',0,true,0,},
	[92004] = {92004,30,[[皮米材料*​​100]],"1,145002,100",7,25,"1,41,50",'',0,true,0,},
	[92005] = {92005,30,[[深海尖晶*50]],"1,145001,50",6,10,"1,41,50",'',0,true,0,},
	[92006] = {92006,30,[[薩拉托加]],"2,10290,1",22,1,"1,42,15000",'',0,true,0,},
	[92007] = {92007,30,[[賦絡溶液儲罐]],"1,260001,1",2,999,"1,42,20",'',0,true,0,},
	[92008] = {92008,30,[[BP卡·60min]],"1,260002,1",1,999,"1,42,20",'',0,true,0,},
	[1041] = {1041,107,[[徵招合約]],"1,160001,1",1,10,"1,250010,30",'',0,true,0,},
	[1042] = {1042,107,[[特批調令]],"1,120001,1",2,10,"1,250010,15",'',0,true,0,},
	[1049] = {1049,107,[[中級裝備箱]],"1,240007,1",9,5,"1,250010,10",'',0,true,0,},
	[40001] = {40001,14,[[S型人偶]],"2,90011,1",12,1,"1,16,4000",'',0,false,0,},
	[40002] = {40002,14,[[A型人偶]],"2,90010,1",11,5,"1,16,800",'',0,false,0,},
	[40003] = {40003,14,[[高級裝備箱]],"1,240021,1",6,6,"1,16,500",'',0,false,0,},
	[40010] = {40010,14,[[皮米材料]],"1,145002,10",5,0,"1,16,10",'',0,false,0,},
	[40011] = {40011,14,[[深海尖晶]],"1,145001,1",7,0,"1,16,50",'',0,false,0,},
	[40012] = {40012,14,[[賦絡溶液]],"1,24,1",4,50,"1,16,50",'',0,false,0,},
	[40013] = {40013,14,[[奈米神經元件]],"1,135000,200",8,50,"1,16,64",'',0,true,0,},
	[40014] = {40014,14,[[深海化材料艦種箱]],"1,240043,10",7,50,"1,16,96",'',0,true,0,},
	[40015] = {40015,14,[[初級深海化箱]],"1,240040,1",5,20,"1,16,32",'',0,true,0,},
	[40016] = {40016,14,[[中級深海化箱]],"1,240041,1",3,10,"1,16,128",'',0,true,0,},
	[40017] = {40017,14,[[高級深海化箱]],"1,240042,1",1,5,"1,16,320",'',0,true,0,},
	[40018] = {40018,14,[[初級裝備箱]],"1,240016,1",6,20,"1,16,96",'',0,true,0,},
	[40019] = {40019,14,[[中級裝備箱]],"1,240007,1",4,10,"1,16,320",'',0,true,0,},
	[40020] = {40020,14,[[高級裝備箱]],"1,240203,1",2,5,"1,16,640",'',0,true,0,},
	[40021] = {40021,14,[[賦絡溶液儲罐]],"1,260001,1",9,50,"1,16,30",'',0,true,0,},
	[40022] = {40022,14,[[BP卡．60min]],"1,260002,1",10,50,"1,16,30",'',0,true,0,},
	[40023] = {40023,21,[[S型人偶]],"2,90011,1",1,3,"1,27,50",'',0,true,0,},
	[40024] = {40024,21,[[A型人偶]],"2,90010,1",2,10,"1,27,10",'',0,true,0,},
	[40025] = {40025,21,[[T5裝備箱]],"1,250017,1",3,1,"1,27,40",'',0,true,0,},
	[40026] = {40026,21,[[中型原石堆]],"1,240052,1",5,5,"1,27,20",'',0,true,0,},
	[40027] = {40027,21,[[小型結晶堆]],"1,240060,1",4,2,"1,27,48",'',0,true,0,},
	[40028] = {40028,21,[[中型艦種結晶堆]],"1,240054,1",6,5,"1,27,12",'',0,true,0,},
	[40029] = {40029,21,[[深海尖晶]],"1,145001,1",7,10,"1,27,10",'',0,true,0,},
	[40030] = {40030,21,[[皮米材料]],"1,145002,1",8,10,"1,27,15",'',0,true,0,},
	[40101] = {40101,17,[[親潮]],"2,50430,1",50,1,"1,20,600",'',4,true,0,},
	[40102] = {40102,17,[[A型人偶]],"2,90010,1",49,3,"1,20,600",'',0,true,0,},
	[40103] = {40103,17,[[深海結晶．航母*20]],"1,145101,20",48,43,"1,20,60",'',0,false,0,},
	[40104] = {40104,17,[[深海結晶．輕巡*20]],"1,145301,20",47,43,"1,20,60",'',0,false,0,},
	[40105] = {40105,17,[[深海結晶．重巡*20]],"1,145401,20",46,43,"1,20,60",'',0,false,0,},
	[40106] = {40106,17,[[深海結晶．驅逐*20]],"1,145501,20",45,43,"1,20,60",'',0,false,0,},
	[40107] = {40107,17,[[深海結晶．戰艦*20]],"1,145601,20",44,43,"1,20,60",'',0,false,0,},
	[40108] = {40108,17,[[深海結晶．神代]],"1,144008,1",43,10,"1,20,48",'',0,true,0,},
	[40109] = {40109,17,[[深海結晶．銀翼]],"1,144009,1",42,10,"1,20,48",'',0,true,0,},
	[40110] = {40110,17,[[深海結晶．薔薇]],"1,144010,1",41,10,"1,20,48",'',0,true,0,},
	[40111] = {40111,17,[[深海結晶．黑鋒]],"1,144011,1",40,10,"1,20,48",'',0,true,0,},
	[40112] = {40112,17,[[深海原石．神代*2]],"1,143008,2",39,102,"1,20,10",'',0,false,0,},
	[40113] = {40113,17,[[深海原石．銀翼*2]],"1,143009,2",38,102,"1,20,10",'',0,false,0,},
	[40114] = {40114,17,[[深海原石．薔薇*2]],"1,143010,2",37,102,"1,20,10",'',0,false,0,},
	[40115] = {40115,17,[[深海原石．黑鋒*2]],"1,143011,2",36,102,"1,20,10",'',0,false,0,},
	[40116] = {40116,17,[[深海污泥．神代*4]],"1,142008,4",35,139,"1,20,10",'',0,false,0,},
	[40117] = {40117,17,[[深海污泥．銀翼*4]],"1,142009,4",34,139,"1,20,10",'',0,false,0,},
	[40118] = {40118,17,[[深海污泥．薔薇*4]],"1,142010,4",33,139,"1,20,10",'',0,false,0,},
	[40119] = {40119,17,[[深海污泥．黑鋒*4]],"1,142011,4",32,139,"1,20,10",'',0,false,0,},
	[40120] = {40120,17,[[奈米神經元件*500]],"1,135000,500",31,40,"1,20,50",'',0,true,0,},
	[40121] = {40121,17,[[賦絡溶液儲罐]],"1,260001,1",30,999,"1,20,20",'',0,true,0,},
	[40122] = {40122,17,[[BP卡．60min]],"1,260002,1",29,999,"1,20,20",'',0,true,0,},
	[40123] = {40123,17,[[高級深海化箱]],"1,240206,1",48,10,"1,20,150",'',0,true,0,},
	[40124] = {40124,17,[[中級深海化箱]],"1,240205,1",47,20,"1,20,40",'',0,true,0,},
	[40125] = {40125,17,[[深海化材料艦種箱*20]],"1,240207,20",46,40,"1,20,60",'',0,true,0,},
	[40126] = {40126,17,[[初級裝備箱]],"1,240201,1",44,20,"1,20,30",'',0,true,0,},
	[40127] = {40127,17,[[中級裝備箱]],"1,240202,1",45,20,"1,20,100",'',0,true,0,},
	[40201] = {40201,16,[[約克鎮]],"2,10160,1",50,1,"1,21,4500",'',4,true,0,},
	[40202] = {40202,16,[[SBD（貝斯特隊）]],"6,301010001,1",49,1,"1,21,3200",'',0,false,0,},
	[40203] = {40203,16,[[F4F戰鬥機]],"6,301016001,1",48,1,"1,21,3200",'',0,true,0,},
	[40204] = {40204,16,[[S型人偶]],"2,90011,1",47,1,"1,21,3000",'',0,true,0,},
	[40205] = {40205,16,[[A型人偶]],"2,90010,1",46,3,"1,21,600",'',0,true,0,},
	[40206] = {40206,16,[[深海結晶．航母*20]],"1,145101,20",45,43,"1,21,60",'',0,false,0,},
	[40207] = {40207,16,[[深海結晶．輕巡*20]],"1,145301,20",44,43,"1,21,60",'',0,false,0,},
	[40208] = {40208,16,[[深海結晶．重巡*20]],"1,145401,20",43,43,"1,21,60",'',0,false,0,},
	[40209] = {40209,16,[[深海結晶．驅逐*20]],"1,145501,20",42,43,"1,21,60",'',0,false,0,},
	[40210] = {40210,16,[[深海結晶．戰艦*20]],"1,145601,20",41,43,"1,21,60",'',0,false,0,},
	[40211] = {40211,16,[[深海結晶．神代]],"1,144008,1",40,75,"1,21,36",'',0,false,0,},
	[40212] = {40212,16,[[深海結晶．銀翼*5]],"1,144009,5",39,20,"1,21,240",'',0,true,0,},
	[40213] = {40213,16,[[深海結晶．薔薇]],"1,144010,1",38,75,"1,21,36",'',0,false,0,},
	[40214] = {40214,16,[[深海結晶．黑鋒]],"1,144011,1",37,75,"1,21,36",'',0,false,0,},
	[40215] = {40215,16,[[深海原石．神代*2]],"1,143008,2",36,171,"1,21,10",'',0,false,0,},
	[40216] = {40216,16,[[深海原石．銀翼*2]],"1,143009,2",35,171,"1,21,10",'',0,false,0,},
	[40217] = {40217,16,[[深海原石．薔薇*2]],"1,143010,2",34,171,"1,21,10",'',0,false,0,},
	[40218] = {40218,16,[[深海原石．黑鋒*2]],"1,143011,2",33,171,"1,21,10",'',0,false,0,},
	[40219] = {40219,16,[[深海污泥．神代*4]],"1,142008,4",32,139,"1,21,10",'',0,false,0,},
	[40220] = {40220,16,[[深海污泥．銀翼*4]],"1,142009,4",31,139,"1,21,10",'',0,false,0,},
	[40221] = {40221,16,[[深海污泥．薔薇*4]],"1,142010,4",30,139,"1,21,10",'',0,false,0,},
	[40222] = {40222,16,[[深海污泥．黑鋒*4]],"1,142011,4",29,139,"1,21,10",'',0,false,0,},
	[40223] = {40223,16,[[奈米神經元件*200]],"1,135000,200",28,69,"1,21,20",'',0,false,0,},
	[40224] = {40224,16,[[賦絡溶液儲罐]],"1,260001,1",27,999,"1,21,20",'',0,true,0,},
	[40225] = {40225,16,[[BP卡．60min]],"1,260002,1",26,999,"1,21,20",'',0,true,0,},
	[40226] = {40226,16,[[高級深海化箱]],"1,240206,1",45,30,"1,21,150",'',0,true,0,},
	[40227] = {40227,16,[[皮米材料*100]],"1,145002,100",38,25,"1,21,50",'',0,true,0,},
	[40228] = {40228,16,[[深海尖晶*50]],"1,145001,50",37,10,"1,21,50",'',0,true,0,},
	[40229] = {40229,16,[[高級裝備箱]],"1,240203,1",44,5,"1,21,400",'',0,true,0,},
	[50001] = {50001,18,[[唐斯]],"2,50400,1",49,5,"1,23,800",'',4,false,0,},
	[50002] = {50002,18,[[A型人偶]],"2,90010,1",48,1,"1,22,100",'',0,true,0,},
	[50003] = {50003,18,[[深海結晶．航母*8]],"1,145101,8",46,108,"1,22,12",'',0,false,0,},
	[50004] = {50004,18,[[深海結晶．輕巡*8]],"1,145301,8",45,108,"1,22,12",'',0,false,0,},
	[50005] = {50005,18,[[深海結晶．重巡*8]],"1,145401,8",44,108,"1,22,12",'',0,false,0,},
	[50006] = {50006,18,[[深海結晶．驅逐*8]],"1,145501,8",43,108,"1,22,12",'',0,false,0,},
	[50007] = {50007,18,[[深海結晶．戰艦*8]],"1,145601,8",42,108,"1,22,12",'',0,false,0,},
	[50008] = {50008,18,[[深海結晶．神代]],"1,144008,1",41,10,"1,22,24",'',0,true,0,},
	[50009] = {50009,18,[[深海結晶．銀翼]],"1,144009,1",40,10,"1,22,24",'',0,true,0,},
	[50010] = {50010,18,[[深海結晶．薔薇]],"1,144010,1",39,10,"1,22,24",'',0,true,0,},
	[50011] = {50011,18,[[深海結晶．黑鋒]],"1,144011,1",38,10,"1,22,24",'',0,true,0,},
	[50012] = {50012,18,[[深海原石．神代*10]],"1,143008,10",37,20,"1,22,25",'',0,false,0,},
	[50013] = {50013,18,[[深海原石．銀翼*10]],"1,143009,10",36,20,"1,22,25",'',0,false,0,},
	[50014] = {50014,18,[[深海原石．薔薇*10]],"1,143010,10",35,20,"1,22,25",'',0,false,0,},
	[50015] = {50015,18,[[深海原石．黑鋒*10]],"1,143011,10",34,20,"1,22,25",'',0,false,0,},
	[50016] = {50016,18,[[深海污泥．神代*8]],"1,142008,8",33,69,"1,22,10",'',0,false,0,},
	[50017] = {50017,18,[[深海污泥．銀翼*8]],"1,142009,8",32,69,"1,22,10",'',0,false,0,},
	[50018] = {50018,18,[[深海污泥．薔薇*8]],"1,142010,8",31,69,"1,22,10",'',0,false,0,},
	[50019] = {50019,18,[[深海污泥．黑鋒*8]],"1,142011,8",30,69,"1,22,10",'',0,false,0,},
	[50020] = {50020,18,[[賦絡溶液儲罐]],"1,260001,1",26,999,"1,22,10",'',0,true,0,},
	[50021] = {50021,18,[[BP卡．60min]],"1,260002,1",25,999,"1,22,10",'',0,true,0,},
	[50022] = {50022,18,[[賦絡溶液儲罐]],"1,260001,1",28,0,"1,22,10",'',0,false,0,},
	[50023] = {50023,18,[[BP卡．60min]],"1,260002,1",27,0,"1,22,10",'',0,false,0,},
	[50024] = {50024,18,[[科羅拉多]],"2,60380,1",52,1,"1,22,1500",'',4,true,0,},
	[50025] = {50025,18,[[銀翼財團主題基地背景]],"1,680108,1",51,1,"1,23,500",'',0,false,0,},
	[50026] = {50026,18,[[SG雷達]],"6,603018001,1",50,1,"1,23,600",'',0,false,0,},
	[50027] = {50027,18,[[S型人偶]],"2,90011,1",49,1,"1,22,500",'',0,false,0,},
	[50028] = {50028,18,[[奈米神經元件*500]],"1,135000,500",29,40,"1,22,25",'',0,true,0,},
	[50029] = {50029,18,[[高級裝備箱]],"1,240021,1",47,10,"1,22,100",'',0,false,0,},
	[50030] = {50030,18,"BP*1000","1,2,1000",23,9999,"1,22,1",'',0,false,0,},
	[50031] = {50031,18,[[皮米材料*120]],"1,145002,120",27,10,"1,22,30",'',0,true,0,},
	[50032] = {50032,18,[[深海尖晶*40]],"1,145001,40",28,5,"1,22,20",'',0,true,0,},
	[50033] = {50033,18,"BP*2000","1,2,2000",24,9999,"1,23,1",'',0,false,0,},
	[50034] = {50034,18,[[高級深海化箱]],"1,240206,1",46,10,"1,22,75",'',0,true,0,},
	[50035] = {50035,18,[[中級深海化箱]],"1,240205,1",45,20,"1,22,30",'',0,true,0,},
	[50036] = {50036,18,[[深海化材料艦種箱*20]],"1,240207,20",44,40,"1,22,30",'',0,true,0,},
	[50037] = {50037,18,[[初級裝備箱]],"1,240201,1",42,20,"1,22,15",'',0,true,0,},
	[50038] = {50038,18,[[中級裝備箱]],"1,240202,1",43,20,"1,22,50",'',0,true,0,},
	[50039] = {50039,18,[[280B型對空雷達]],"6,601012001,1",47,1,"1,22,600",'',0,true,0,},
	[50101] = {50101,19,[[科羅拉多]],"2,60380,1",50,4,"1,23,1000",'',4,false,0,},
	[50102] = {50102,19,[[A型人偶]],"2,90010,1",48,2,"1,22,100",'',0,true,0,},
	[50103] = {50103,19,[[高級裝備箱]],"1,240021,1",48,5,"1,22,500",'',0,false,0,},
	[50104] = {50104,19,[[深海結晶．航母*8]],"1,145101,8",46,108,"1,22,12",'',0,false,0,},
	[50105] = {50105,19,[[深海結晶．輕巡*8]],"1,145301,8",45,108,"1,22,12",'',0,false,0,},
	[50106] = {50106,19,[[深海結晶．重巡*8]],"1,145401,8",44,108,"1,22,12",'',0,false,0,},
	[50107] = {50107,19,[[深海結晶．驅逐*8]],"1,145501,8",43,108,"1,22,12",'',0,false,0,},
	[50108] = {50108,19,[[深海結晶．戰艦*8]],"1,145601,8",42,108,"1,22,12",'',0,false,0,},
	[50109] = {50109,19,[[深海結晶．神代*10]],"1,144008,10",41,7,"1,22,180",'',0,false,0,},
	[50110] = {50110,19,[[深海結晶．銀翼*5]],"1,144009,5",40,20,"1,23,120",'',0,true,0,},
	[50111] = {50111,19,[[深海結晶．薔薇*10]],"1,144010,10",39,7,"1,22,180",'',0,false,0,},
	[50112] = {50112,19,[[深海結晶．黑鋒*10]],"1,144011,10",38,7,"1,22,180",'',0,false,0,},
	[50113] = {50113,19,[[深海原石．神代*10]],"1,143008,10",37,20,"1,22,25",'',0,false,0,},
	[50114] = {50114,19,[[深海原石．銀翼*10]],"1,143009,10",36,20,"1,22,25",'',0,false,0,},
	[50115] = {50115,19,[[深海原石．薔薇*10]],"1,143010,10",35,20,"1,22,25",'',0,false,0,},
	[50116] = {50116,19,[[深海原石．黑鋒*10]],"1,143011,10",34,20,"1,22,25",'',0,false,0,},
	[50117] = {50117,19,[[深海污泥．神代*8]],"1,142008,8",33,69,"1,22,10",'',0,false,0,},
	[50118] = {50118,19,[[深海污泥．銀翼*8]],"1,142009,8",32,69,"1,22,10",'',0,false,0,},
	[50119] = {50119,19,[[深海污泥．薔薇*8]],"1,142010,8",31,69,"1,22,10",'',0,false,0,},
	[50120] = {50120,19,[[深海污泥．黑鋒*8]],"1,142011,8",30,69,"1,22,10",'',0,false,0,},
	[50121] = {50121,19,[[賦絡溶液儲罐]],"1,260001,1",30,999,"1,23,10",'',0,true,0,},
	[50122] = {50122,19,[[BP卡．60min]],"1,260002,1",29,999,"1,23,10",'',0,true,0,},
	[50123] = {50123,19,[[馬漢]],"2,50090,1",51,1,"1,23,7500",'',4,true,0,},
	[50124] = {50124,19,[[S型人偶]],"2,90011,1",49,1,"1,23,500",'',0,true,0,},
	[50125] = {50125,19,[[奈米神經元件*1000]],"1,135000,1000",29,13,"1,22,50",'',0,false,0,},
	[50126] = {50126,19,[[四聯裝533mm魚雷MK15]],"6,205009001,1",50,1,"1,22,1600",'',0,true,0,},
	[50127] = {50127,19,[[銀翼家具箱]],"1,460103,1",47,10,"1,23,750",'',0,false,0,},
	[50128] = {50128,19,[[高級裝備箱]],"1,240203,1",47,20,"1,23,200",'',0,false,0,},
	[50129] = {50129,19,[[高級深海化箱]],"1,240206,1",46,10,"1,23,75",'',0,false,0,},
	[50201] = {50201,20,[[馬漢]],"2,50090,1",51,1,"1,23,6000",'',4,true,0,},
	[50202] = {50202,20,[[S型人偶]],"2,90011,1",48,2,"1,23,5000",'',0,true,0,},
	[50203] = {50203,20,[[四聯裝533mm魚雷MK15]],"6,205009001,1",45,1,"1,23,5000",'',0,true,0,},
	[50204] = {50204,20,[[CVW-5聯隊]],"6,301001001,1",44,1,"1,23,5000",'',0,true,0,},
	[50212] = {50212,20,"BP*50000","1,2,50000",3,200,"1,23,500",'',0,false,0,},
	[50213] = {50213,20,[[賦絡溶液儲罐]],"1,260001,1",30,100,"1,22,8",'',0,true,0,},
	[50214] = {50214,20,[[BP卡．60min]],"1,260002,1",29,100,"1,22,8",'',0,true,0,},
	[999801] = {999801,9998,[[定點爆破器]],"1,990001,1",1,0,"1,17,10",'',0,true,0,},
	[999802] = {999802,9998,[[地震精密測量儀]],"1,990002,1",2,0,"1,17,50",'',0,true,0,},
	[999803] = {999803,9998,[[重力測量儀]],"1,990003,1",3,0,"1,17,50",'',0,true,0,},
	[999804] = {999804,9998,[[磁力儀]],"1,990004,1",6,0,"1,1,25",'',0,true,0,},
	[999805] = {999805,9998,[[不穩定炸藥]],"1,990005,1",5,0,"1,1,10",'',0,true,0,},
	[999806] = {999806,9998,[[高精度磁力儀]],"1,990006,1",4,0,"1,17,50",'',0,true,0,},
	[999807] = {999807,9998,[[電流勘探儀]],"1,990007,1",7,0,"1,1,25",'',0,true,0,},
	[999808] = {999808,9998,[[全覆蓋偵測儀]],"1,990008,1",8,0,"1,1,100",'',0,true,0,},
	[999901] = {999901,9999,[[S型人偶]],"2,90011,1",12,1,"1,18,100",'',2,false,0,},
	[999902] = {999902,9999,[[A型人偶]],"2,90010,1",18,3,"1,18,20",'',2,true,0,},
	[999904] = {999904,9999,[[賦絡溶液儲罐]],"1,260001,1",7,240,"1,18,2",'',0,true,0,},
	[999905] = {999905,9999,[[高級深海化箱]],"1,240206,1",10,5,"1,18,12",'',0,true,0,},
	[999906] = {999906,9999,[[BP卡．60min]],"1,260002,1",6,240,"1,18,2",'',0,true,0,},
	[999907] = {999907,9999,[[高級裝備箱]],"1,240203,1",11,5,"1,18,15",'',0,true,0,},
	[999909] = {999909,9999,[[奈米神經元件*200]],"1,135000,200",8,5,"1,18,5",'',0,true,0,},
	[999910] = {999910,9999,[[徵招合約]],"1,160001,1",19,2,"1,18,80",'',0,true,0,},
	[999911] = {999911,9999,[[狂想夜·銀河]],"5,950011,1",20,1,"1,18,1000",'',2,true,0,},
	[999912] = {999912,9999,[[皮米材料*​​100]],"1,145002,100",5,20,"1,18,5",'',0,true,0,},
	[999913] = {999913,9999,[[深海尖晶*50]],"1,145001,50",4,20,"1,18,5",'',0,true,0,},
}

function CoinExchangeConfig.GetConfig(key)
	local tb = CoinExchangeConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["shoptype"] = 2,["name"] = 3,["itemid"] = 4,["sequence"] = 5,["inventory"] = 6,["price"] = 7,["condition"] = 8,["hot"] = 9,["insell"] = 10,["nazo"] = 11,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return CoinExchangeConfig