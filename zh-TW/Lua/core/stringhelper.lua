function NumberToStringemicolon(num) --分号隔开 例如 1000,000
    if num < 999999 then
        return NumFormat(num,",")
    else
        num = math.floor(num/1000)
        return tostring(num) .. "k"
    end
end

function NumFormat(num,deperator)
    local str1 =""
    local str = tostring(num)
    local strLen = string.len(str)

    if deperator == nil then
        deperator = ","
    end
    deperator = tostring(deperator)

    for i=1,strLen do
        str1 = string.char(string.byte(str,strLen+1 - i)) .. str1
        if math.fmod(i,3) == 0 then
            --下一个数 还有
            if strLen - i ~= 0 then
                str1 = ","..str1
            end
        end
    end
    return str1
end

function string.IsNullOrEmpty(str)
    return str == nil or str == ''
end
--function SubUTF8String(str, start, len)
--    local firstResult = ""
--    local strResult = ""
--    local maxLen = string.len(str)
--    start = start - 1
--    local preSite = 1
--    if start > 0 then
--        for i = 1, maxLen do
--            local s_dropping = string.byte(str, i)
--            if not s_dropping then
--                local s_str = string.sub(str, preSite, i - 1)
--                preSite = i + 1
--                break
--            end
--            if s_dropping < 128 or (i + 1 - preSite) == 3 then
--                local s_str = string.sub(str, preSite, i)
--                preSite = i + 1
--                firstResult = firstResult..s_str
--                local curLen = utfstrlen(firstResult)
--                if (curLen == start) then
--                    break
--                end
--            end
--        end
--    end
--    preSite = string.len(firstResult) + 1
--    local startC = preSite
--    for i = startC, maxLen do
--        local s_dropping = string.byte(str, i)
--        if not s_dropping then
--            local s_str = string.sub(str, preSite, i - 1)
--            preSite = i
--            strResult = strResult..s_str
--            return strResult
--        end
--        if s_dropping < 128 or (i + 1 - preSite) == 3 then
--            local s_str = string.sub(str, preSite, i)
--            preSite = i + 1
--            strResult = strResult..s_str
--            local curLen = utfstrlen(strResult)
--            if (curLen == len) then
--                return strResult
--            end
--        end
--    end
--    return strResult
--end
function SubStringUTF8(str, startIndex, endIndex)--截取中英混合UTF8字符串，不论中英长度均为1
    if startIndex < 0 then
        startIndex = SubStringGetTotalIndex(str) + startIndex + 1;
    end

    if endIndex ~= nil and endIndex < 0 then
        endIndex = SubStringGetTotalIndex(str) + endIndex + 1;
    end

    if endIndex == nil then
        return string.sub(str, SubStringGetTrueIndex(str, startIndex));
    else
        return string.sub(str, SubStringGetTrueIndex(str, startIndex), SubStringGetTrueIndex(str, endIndex + 1) - 1);
    end
end


function SubStringGetTotalIndex(str)--获取中英混合UTF8字符串的真实字符数量
    local curIndex = 0;
    local i = 1;
    local lastCount = 1;
    repeat
        lastCount = SubStringGetByteCount(str, i)
        i = i + lastCount;
        curIndex = curIndex + 1;
    until(lastCount == 0);
    return curIndex - 1;
end

function SubStringGetTrueIndex(str, index)
    local curIndex = 0;
    local i = 1;
    local lastCount = 1;
    repeat
        lastCount = SubStringGetByteCount(str, i)
        i = i + lastCount;
        curIndex = curIndex + 1;
    until(curIndex >= index);
    return i - lastCount;
end

--返回当前字符实际占用的字符数
function SubStringGetByteCount(str, index)
    local curByte = string.byte(str, index)
    local byteCount = 1;
    if curByte == nil then
        byteCount = 0
    elseif curByte > 0 and curByte <= 127 then
        byteCount = 1
    elseif curByte>=192 and curByte<=223 then
        byteCount = 2
    elseif curByte>=224 and curByte<=239 then
        byteCount = 3
    elseif curByte>=240 and curByte<=247 then
        byteCount = 4
    end
    return byteCount;
end

----------------HTML Start
string._htmlspecialchars_set = {}
string._htmlspecialchars_set["&"] = "&amp;"
string._htmlspecialchars_set["\""] = "&quot;"
string._htmlspecialchars_set["'"] = "&#039;"
string._htmlspecialchars_set["<"] = "&lt;"
string._htmlspecialchars_set[">"] = "&gt;"

function string.htmlspecialchars(input)
    for k, v in pairs(string._htmlspecialchars_set) do
        input = string.gsub(input, k, v)
    end
    return input
end

function string.restorehtmlspecialchars(input)
    for k, v in pairs(string._htmlspecialchars_set) do
        input = string.gsub(input, v, k)
    end
    return input
end

function string.nl2br(input)
    return string.gsub(input, "\n", "<br />")
end

function string.text2html(input)
    input = string.gsub(input, "\t", "    ")
    input = string.htmlspecialchars(input)
    input = string.gsub(input, " ", "&nbsp;")
    input = string.nl2br(input)
    return input
end

--[[
    解析 ”a,b; c,d;e,f"格式的字符串
]]
function string.split(str)
    local result = {}

    if str == "" or str == '' then
        print_error("传入的字符串为空")
        return result
    end

    local arr = string.split(str,";")
    for k,v in pairs(arr) do
        local tmp = string.split(v,",")
        if tmp then
            table.insert( result,tmp)
        end
    end
    return result
end

function string.split(input, delimiter)
    input = tostring(input)

    if input == "" or input == '' then
        print_error("传入的字符串为空")
    end

    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

function string.ltrim(input)
    return string.gsub(input, "^[ \t\n\r]+", "")
end

function string.rtrim(input)
    return string.gsub(input, "[ \t\n\r]+$", "")
end

function string.trim(input)
    input = string.gsub(input, "^[ \t\n\r]+", "")
    return string.gsub(input, "[ \t\n\r]+$", "")
end

function string.ucfirst(input)
    return string.upper(string.sub(input, 1, 1)) .. string.sub(input, 2)
end

local function urlencodechar(char)
    return "%" .. string.format("%02X", string.byte(char))
end
function string.urlencode(input)
    -- convert line endings
    input = string.gsub(tostring(input), "\n", "\r\n")
    -- escape all characters but alphanumeric, '.' and '-'
    input = string.gsub(input, "([^%w%.%- ])", urlencodechar)
    -- convert spaces to "+" symbols
    return string.gsub(input, " ", "+")
end

function string.urldecode(input)
    input = string.gsub (input, "+", " ")
    input = string.gsub (input, "%%(%x%x)", function(h) return string.char(CheckNumber(h,16)) end)
    input = string.gsub (input, "\r\n", "\n")
    return input
end

function string.utf8len(input)
    local len  = string.len(input)
    local left = len
    local cnt  = 0
    local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    while left ~= 0 do
        local tmp = string.byte(input, -left)
        local i   = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end
        cnt = cnt + 1
    end
    return cnt
end

function string.formatnumberthousands(num)
    local formatted = tostring(CheckNumber(num))
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end