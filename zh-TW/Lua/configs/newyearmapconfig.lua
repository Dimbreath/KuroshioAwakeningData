local NewYearMapConfig = {}

NewYearMapConfig.Values = {
	[10120] = {10120,"138,582",100,"1,24,10000","krs10120_3502",},
	[10290] = {10290,"-295,-505",100,"1,135000,100","krs10290_3502",},
	[30140] = {30140,"351,306",100,"1,240040,1","krs30140_3501",},
	[30180] = {30180,"125,-298",5,"1,3,50","krs30180_3502",},
	[30330] = {30330,"-513,-47",5,"1,1,10","krs30330_3503",},
	[50140] = {50140,"-71,340",100,"1,240016,1","krs50140_3501",},
	[60060] = {60060,"-260,693",100,"1,2,10000","krs60060_3501",},
}

function NewYearMapConfig.GetConfig(key)
	local tb = NewYearMapConfig.Values[key]
	if not tb then
		print_error(string.format("key type is %s,key = %s",type(key),key))
		return nil
	end
	local config = {["boatid"] = 1,["coordinate"] = 2,["weight"] = 3,["reward"] = 4,["voicetxt"] = 5,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return NewYearMapConfig