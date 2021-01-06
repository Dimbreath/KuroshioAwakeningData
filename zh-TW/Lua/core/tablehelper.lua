function table.nums(t)
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end
    return count
end

function table.keys(hashtable)
    local keys = {}
    for k, v in pairs(hashtable) do
        keys[#keys + 1] = k
    end
    return keys
end

function table.values(hashtable)
    local values = {}
    for k, v in pairs(hashtable) do
        values[#values + 1] = v
    end
    return values
end

function table.merge(dest, src)
    for k, v in pairs(src) do
        dest[k] = v
    end
end

function table.merges(dest, src)
    for k, v in pairs(src) do
        if not dest[k] then
            dest[k] = v
        end
    end
end

function table.addrange(dest, src)
    for k,v in pairs(src) do
        print(v)
        table.insert(dest,v)
    end
end

function table.insertto(dest, src, begin)
    begin = CheckInt(begin)
    if begin <= 0 then
        begin = #dest + 1
    end

    local len = #src
    for i = 0, len - 1 do
        dest[i + begin] = src[i + 1]
    end
end

function table.indexof(array, value, begin)
    for i = begin or 1, #array do
        if array[i] == value then return i end
    end
    return false
end

function table.keyof(hashtable, value)
    for k, v in pairs(hashtable) do
        if v == value then return k end
    end
    return nil
end

function table.removebyvalue(array, value, removeall)
    local c, i, max = 0, 1, #array
    while i <= max do
        if array[i] == value then
            table.remove(array, i)
            c = c + 1
            i = i - 1
            max = max - 1
            if not removeall then break end
        end
        i = i + 1
    end
    return c
end

function table.removebyindex(array, value, removeall)
    local c, i, max = 0, 1, #array
    while i <= max do
        if i == value then
            table.remove(array, i)
            c = c + 1
            i = i - 1
            max = max - 1
            if not removeall then break end
        end
        i = i + 1
    end
    return c
end

function table.map(t, fn)
    for k, v in pairs(t) do
        t[k] = fn(v, k)
    end
end

function table.walk(t, fn)
    for k,v in pairs(t) do
        fn(v, k)
    end
end

function table.filter(t, fn)
    for k, v in pairs(t) do
        if not fn(v, k) then t[k] = nil end
    end
end

function table.unique(t, bArray)
    local check = {}
    local n = {}
    local idx = 1
    for k, v in pairs(t) do
        if not check[v] then
            if bArray then
                n[idx] = v
                idx = idx + 1
            else
                n[k] = v
            end
            check[v] = true
        end
    end
    return n
end

function table.deep_copy(orig)
    local copy
    if type(orig) == "table" then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deep_copy(orig_key)] = deep_copy(orig_value)
        end
        setmetatable(copy, deep_copy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

function TableHasValue(tab,value, counting)
    if not tab or not value then
        return false
    end
    local count = 0
    for k,v in pairs(tab) do
        if v == value then
            count = count +1
            if not counting then
                break
            end
        end
    end
    return count>0
end

function TableHasKey(tab, key)
    if not tab or not key then
        return false
    end
    for  k,v in pairs(tab) do
        if k == key then
            return true
        end
    end
    return false
end

function TableLength(tab)
    if not tab then
        return 0
    end
    local count = 0
    for k,v in pairs(tab) do
        if v then
            count = count +1
        end
    end
    return count
end

function TableSafeDelete(tab, value,removeAll)
    if not tab or not value then
        return false
    end
    local remove = {}
    for k, v in pairs(tab) do
        if v == value then
            --print("TableSafeDelete functon ===> ",v)
            --print("remove",k)
            --table.insert(remove,k)
            table.remove(tab,k)
            if not removeAll then
                break
            end
        end
    end
end

--sort key迭代
function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
      i = i + 1
      if a[i] == nil then return nil
      else return a[i], t[a[i]]
      end
    end
    return iter
  end

