-- @yanfei 2019.4.10
local xluautil = require 'xlua/util'
local util = {}

util.iter = function(container_)
                local iter = container_:GetEnumerator()
                return function()
                    while iter:MoveNext() do
                        return iter.Current
                    end
                end
            end

util.pair = function(container_)
    local iter = container_:GetEnumerator()
    local i = 0
    return function()
        while iter:MoveNext() do
            i = i + 1
            return i, iter.Current
        end
    end
end


local csluascript = CS.DarkBoom.GameEntry.Lua
util.cs_coroutine = function(...)
    return csluascript:StartCoroutine(xluautil.cs_generator(...))
end
util.cs_stopcoroutine = function(routine_)
    csluascript:StopCoroutine(routine_)
end

util.wrapmethod = function(thisa, thismethod) 
    if thisa.___methodname_wrapmethod___ == nil then
        thisa.___methodname_wrapmethod___ = function(a, b) thismethod(thisa, a, b) end
    end
    print('register wrapmethod---------------------------------')
    return thisa.___methodname_wrapmethod___
end

return util