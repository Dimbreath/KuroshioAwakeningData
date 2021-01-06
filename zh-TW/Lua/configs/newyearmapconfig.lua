local NewYearMapConfig = {}

NewYearMapConfig.Values = {
	[10010] = {10010,"0,0",100,"1,1,100","krs50021_3101",},
}

function NewYearMapConfig.GetConfig(key)
	local tb = NewYearMapConfig.Values[key]
	if not tb then
		print_error(key)
		return nil
	end
	local config = {["boatid"] = 1,["coordinate"] = 2,["weight"] = 3,["reward"] = 4,["voicetxt"] = 5,}
	for k,v in pairs(config) do
		config[k] = tb[v]
	end
	return config 
end
return NewYearMapConfig