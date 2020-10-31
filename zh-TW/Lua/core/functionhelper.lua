function print_log(...)
	local logStr = string.format( "%s\n%s",GetParamsString(...),debug.traceback())
	Debug.Log(logStr)
end

function print_error(...)
	local logStr = string.format( "%s\n%s",GetParamsString(...),debug.traceback())
    Debug.LogError(logStr)
end

function print_warning(...)
	local logStr = string.format( "%s\n%s",GetParamsString(...),debug.traceback())
	Debug.LogWarning(logStr)
end

local tconcat = table.concat
local tinsert = table.insert
local srep = string.rep
local type = type
local pairs = pairs
local tostring = tostring
local next = next
function print_r(root)
	local cache = {  [root] = "." }
	local function _dump(t,space,name)
		local temp = {}
		for k,v in pairs(t) do
			local key = tostring(k)
			if cache[v] then
				tinsert(temp,"+" .. key .. " {" .. cache[v].."}")
			elseif type(v) == "table" then
				local new_key = name .. "." .. key
				cache[v] = new_key
				tinsert(temp,"+" .. key .. _dump(v,space .. (next(t,k) and "|" or " " ).. srep(" ",#key),new_key))
			else
				tinsert(temp,"+" .. key .. " [" .. tostring(v).."]")
			end
		end
		return tconcat(temp,"\n"..space)
	end
	print(_dump(root, "",""))
end

function GetParamsString(...)
	local str = ""
	local args = {...}
	for i,v in ipairs(args) do
		if str == "" then
			str = tostring(v)
		else
			str = string.format( "%s, %s",str,v)
		end
	end
	return str
end

function ParseInjections(gameObject)
	local temp = {}

    if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return temp
    end

    local luaInjection = gameObject:GetComponent(typeof(CS.DarkBoom.LuaInjection))

    if  IsGameObjectNull(luaInjection) then
        print_error("luaInjection == nil : " .. gameObject.name)
        return temp
    end

    local injections = luaInjection:GetInjections()
    
    if not injections then
		print_error("injections == nil : " .. gameObject.name)
        return temp
    end
   
	for i = 0, injections.Count - 1 do
		local injection = injections[i]
		local name = injection.name
		if (name == nil or name == "") and injection.value ~= nil then
			name = injection.value.name
		end

        if name ~= nil and name ~= "" then
			temp[name] = injection.component
		end
    end
    return temp
end

function JsonDecode(data)
	return JSON.decode (data)
end

function IsGameObjectNull(obj)
	return LuaBridge.IsGameObjectNull(obj)
end


function MakeJointKey(mainKey,subKey)
	return (mainKey << 32) + subKey
end

	