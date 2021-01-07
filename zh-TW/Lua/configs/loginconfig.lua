local LoginConfig = {}

LoginConfig.Values = {
	[1] = {1,"2,90010,2;1,3,300",1,0,},
	[2] = {2,"1,280005,1;1,240021,2",0,0,},
	[3] = {3,"1,160001,10;1,1,500",0,0,},
	[4] = {4,"1,240042,2;1,135000,5000",0,0,},
	[5] = {5,"2,90011,1;1,240020,1",1,0,},
	[6] = {6,"5,950006,1;1,3,360",0,0,},
	[7] = {7,"2,60050,1;1,1,1000",1,0,},
}

function LoginConfig.GetConfig(key)
	local tb = LoginConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["id"] = 1,["rewards"] = 2,["specialawards"] = 3,["nazo"] = 4,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return LoginConfig