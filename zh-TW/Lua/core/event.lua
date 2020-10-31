Event = class("Event")

function Event:ctor()
    self.listeners = {}
    self.listenersOnce = {}
end

function Event:AddListener(callBack,obj)
    assert(type(callBack) == "function","callBack must be function , now is "..type(callBack))
    local has, value = self:HasValue(self.listeners,callBack,obj)
    if not has then
        if value then
            table.insert(value.callBacks,callBack)
        else
            local callBacks = {}
            table.insert(callBacks,callBack)
            table.insert(self.listeners,{obj = obj, callBacks = callBacks})
        end
    else
        LogError("重复的回掉函数添加",callBack)
    end
end

function Event:AddListenerOnce(callBack,obj)
    assert(type(callBack) == "function","callBack must be function , now is "..type(callBack))
    local has, value = self:HasValue(self.listenersOnce,callBack,obj)
    if not has then
        if value then
            table.insert(value.callBacks,callBack)
        else
            local callBacks = {}
            table.insert(callBacks,callBack)
            table.insert(self.listenersOnce,{obj = obj, callBacks =callBacks})
        end
    else
        LogError("重复的回掉函数添加",callBack)
    end
end

function Event:HasValue(tb, callBack,obj)
    for k,v in pairs(tb) do
        if v.obj == obj  then
            if TableHasValue(v.callBacks,callBack) then
                return true,v
            end
            return false,v
        end
    end
    return false
end

function Event:Dump()
    local tab = {listeners = {}, listenersOnce = {}}
    for k,v in pairs(self.listenersOnce) do
        table.insert(tab.listenersOnce,v.callBacks)
    end
    for  k,v in pairs(self.listeners) do
        table.insert(tab.listeners,v.callBacks)
    end
    print(vardump(tab))
end

function Event:RemoveListener(callBack,obj)
    assert(type(callBack) == "function","callBack must be function , now is "..type(callBack))
    local has, value = self:HasValue(self.listenersOnce,callBack,obj)
    if has and value then
        TableSafeDelete(value.callBacks,callBack)
        if table.nums(value.callBacks) <=0 then
            TableSafeDelete(self.listenersOnce,value)
        end
    end
    has,value = self:HasValue(self.listeners,callBack,obj)
    if has and value then
        TableSafeDelete(value.callBacks, callBack)
        if table.nums(value.callBacks) <= 0 then
            TableSafeDelete(self.listeners,value)
        end
    end
end

function Event:Invoke(...)
    if table.nums(self.listeners)>0 then
        for k,v in pairs(self.listeners) do
            for i,j in pairs(v.callBacks) do
                if v.obj then
                    j(v.obj,...)
                else
                    j(...)
                end
            end
        end
    end
    if table.nums(self.listenersOnce)>0 then
        for k,v in pairs(self.listenersOnce) do
            for i,j in pairs(v.callBacks) do
                if v.obj then
                    j(v.obj,...)
                else
                    j(...)
                end
            end
        end
    end
    self.listenersOnce = {}
end

function Event:ClearAllListener()
    self.listeners = {}
    self.listenersOnce = {}
end

function Event:Clear()
    self.listeners = nil
    self.listenersOnce = nil
end