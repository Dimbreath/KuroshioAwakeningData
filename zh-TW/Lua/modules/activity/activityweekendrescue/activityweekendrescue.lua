local ActivityBase = require"Modules/Activity/ActivityBase"
local ActivityConfig = require "Configs/ActivityConfig"
local ActivityWeekendRescue = class("ActivityWeekendRescue", ActivityBase)

local function FormatTimeForDisplay(timeStr1, timeStr2, showYear)
	 
	local result = ""
    local date1 = DarkBoomUtility.GetDateTime(timeStr1)
	local date2 = DarkBoomUtility.GetDateTime(timeStr2)

	if showYear then
		result = string.format("%04d.%02d.%02d - %04d.%02d.%02d",date1.Year, date1.Month, date1.Day, date2.Year, date2.Month, date2.Day)
	else
		result = string.format(GetDefaultText("activity_resource_05"), date1.Month, date1.Day, date1.Hour, date1.Minute, date2.Month, date2.Day, date2.Hour, date2.Minute)
	end
	return result
end

local function ClickConfirm()
	CS.CommonTranslater.TranslateBySourceId(tonumber(ActivityWeekendRescue.ActivityCfg.parameter_3)) 
end
function ActivityWeekendRescue:InitText()

	local tagIdTable = string.split(self.ActivityCfg.parameter_1, ',')
	if #tagIdTable < 3 then return end
	local activityConfig1 = ActivityConfig.GetConfig(tonumber(tagIdTable[1]))
	local activityConfig2 = ActivityConfig.GetConfig(tonumber(tagIdTable[2]))
	local activityConfig3 = ActivityConfig.GetConfig(tonumber(tagIdTable[3]))
	if activityConfig1 then
		self.injections.TextTitle1.text = activityConfig1.name
		self.injections.TextTime1.text = FormatTimeForDisplay(activityConfig1.start, activityConfig1["end"])
	end
	if activityConfig2 then
		self.injections.TextTitle2.text = activityConfig2.name
		self.injections.TextTime2.text = FormatTimeForDisplay(activityConfig2.start, activityConfig2["end"])
	end
	if activityConfig3 then
		self.injections.TextTitle3.text = activityConfig3.name
		self.injections.TextTime3.text = FormatTimeForDisplay(activityConfig3.start, activityConfig3["end"])
	end
	
	self.injections.TextTimeMain.text = FormatTimeForDisplay(self.ActivityCfg.start, self.ActivityCfg["end"], true)
	
end

function ActivityWeekendRescue:OnInit(gameObject,mask)
    
    self.injections = ParseInjections(gameObject)
    self.mask = mask
    self.gameObject = gameObject
end
function ActivityWeekendRescue:OnOpen(tagId)
    self.ActivityCfg = ActivityConfig.GetConfig(tagId)
    if self.ActivityCfg ~= nil then
		self:InitText()
		self.injections.ConfirmButton.onClick:RemoveAllListeners()
		self.injections.ConfirmButton.onClick:AddListener(ClickConfirm)
    end
end
function ActivityWeekendRescue:OnRelease()
    self.injections.ConfirmButton.onClick:RemoveAllListeners()
    self.injections = nil
end

function ActivityWeekendRescue:SetActive(show)
    self.gameObject:SetActive(show);
end
return ActivityWeekendRescue