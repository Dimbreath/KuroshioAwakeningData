local util = require 'xluautil'
local DarkBoom = CS.DarkBoom
local UnityEngine = CS.UnityEngine

local GameEntry = DarkBoom.GameEntry
local tmp = {}
xlua.hotfix(DarkBoom.StageMsg, 'OnDisable',
function(self)

	self._bossIcon.color = UnityEngine.Color(self._bossIcon.color.r, self._bossIcon.color.g, self._bossIcon.color.b, 0);
	self._icon.color = UnityEngine.Color(self._icon.color.r, self._icon.color.g, self._icon.color.b, 1);
	GameEntry.Event:Unsubscribe(DarkBoom.CanBlinkEventArgs.EventId, tmp[self]);
	tmp[self] = nil;
end
)

xlua.hotfix(DarkBoom.StageMsg, 'OnEnable',
function(self)
	if tmp[self] == nil then
		  tmp[self] =  function(p1,p2) 
		  self:OnActionChenga(p1,p2) 
		 end
	 end
	 GameEntry.Event:Subscribe(DarkBoom.CanBlinkEventArgs.EventId, tmp[self]);
end)


xlua.hotfix(DarkBoom.StageMsg, 'SetIcon',
function(self,force)
	-- printerror("SetIcon Start")
	self:RefreshButtonClick(force);

	if self._iconN ~= nil and self._iconN ~= "" then 
		-- printerror("SetIcon icon Unload")
		DarkBoom.DarkBoomUtility.UnLoadSprite(self._iconN);
	end

	if self:isBoss() then
		-- printerror("SetIcon isBoss Handler")
		self._iconN = DarkBoom.DarkBoomUtility.LoadSprite(self._icon, "icon_1004", "SLG", "icon_1001", true);
	
	else
		-- printerror("SetIcon not BossHandler" .. force )
		if force == 0 then 
			-- printerror("SetIcon"..force.."icon_1001" )
			self._iconN = DarkBoom.DarkBoomUtility.LoadSprite(self._icon, "icon_1001", "SLG", "icon_1001", true);
		elseif force == 1 then 
			-- printerror("SetIcon"..force .."icon_1002")
			self._iconN = DarkBoom.DarkBoomUtility.LoadSprite(self._icon, "icon_1002", "SLG", "icon_1001", true);
		elseif force == 21 or force == 22  or force == 23  or force == 24  then 
			-- printerror("SetIcon"..force.. "icon_1003")
			self._iconN = DarkBoom.DarkBoomUtility.LoadSprite(self._icon, "icon_1003", "SLG", "icon_1001", true);
		end
	end
end)