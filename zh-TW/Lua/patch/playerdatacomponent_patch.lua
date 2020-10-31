local util = require 'xlua/util'

local DarkBoom = CS.DarkBoom
local GameEntry = DarkBoom.GameEntry
local DarkBoomUtility = DarkBoom.DarkBoomUtility

xlua.private_accessible(DarkBoom.PlayerDataComponent)

util.hotfix_ex(DarkBoom.PlayerDataComponent, 'UpdateData',
function(self, userModify, jsonData)
	self:UpdateData(userModify, jsonData)

    if (jsonData:ContainsKey("last_favorability_time")) then
        self.LastFavorabilityTime.Value = userModify.last_favorability_time;
    end
end)

xlua.hotfix(DarkBoom.PlayerDataComponent, 'AddFavorabilityValue',
function(self)
	local serverTime = DarkBoomUtility.GetServerCrtTime();
    local lastTime = self.LastFavorabilityTime.Value;

    local serverTimeStr = DarkBoomUtility.GetTimeByUnix(serverTime);
    --Debug.LogError("服务器时间: " + serverTimeStr);
    local lastTimeStr = DarkBoomUtility.GetTimeByUnix(lastTime);
    --Debug.LogError("秘书舰最后加好感的时间: " + lastTimeStr);
    --printerror(serverTimeStr.Ticks .. '    ' .. lastTimeStr.Ticks);

    local addValue = self.ConfigFavorabilityValue;
    local total = 0;
    if (serverTimeStr.Ticks > lastTimeStr.Ticks)then
        if serverTimeStr.Hour > lastTimeStr.Hour or serverTimeStr.Day > lastTimeStr.Day then
            total = total + ((60 - lastTimeStr.Minute) * addValue / 60);
        end
        if serverTimeStr.Day > lastTimeStr.Day then 
            if(24 - lastTimeStr.Hour  > 1) then 
                total = total + (addValue *( 24 - lastTimeStr.Hour  - 1));
            end
            total = total + (addValue * serverTimeStr.Hour)
        elseif (serverTimeStr.Hour - lastTimeStr.Hour > 1)then
            total = total + (addValue * (serverTimeStr.Hour - lastTimeStr.Hour - 1));
        end
    end

    --printerror(123);
    --printerror(getIntPart(total))
    return getIntPart(total)
end)

function getIntPart(x)
    if x<= 0 then
        return math.ceil(x)
    end
    if math.ceil(x) == x then
        x = math.ceil(x)
    else
        x = math.ceil(x)-1
    end


    return x
end 