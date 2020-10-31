local util = require 'xluautil'

local DarkBoom = CS.DarkBoom
local GameEntry = DarkBoom.GameEntry
local SLGManager = CS.SLGManager
local UIFormId = DarkBoom.UIFormId
local DarkBoomUtility = DarkBoom.DarkBoomUtility
local OpenUIFormSuccessEventArgs = CS.UnityGameFramework.Runtime.OpenUIFormSuccessEventArgs

local tmpHandler
local tmpHandler2

xlua.hotfix(DarkBoom.ProcedureSLG, 'OnEnter',
function(self,procedureOwner)
	base(self):OnEnter(procedureOwner)	

	tmpHandler2 = function(sender,e) 
			   self:OnOpenUiFormSuccess( sender,  e)
	end

	GameEntry.Event:Subscribe(OpenUIFormSuccessEventArgs.EventId, tmpHandler2)
	
	local slgManager = SLGManager:GetInstance()
	if(slgManager._isBattleBack) then
		self.isLoadingForm = true;
		self.isSLGForm = true;
		DarkBoom.UIExtension.OpenUIForm(GameEntry.UI,UIFormId.SLGForm,self)
		slgManager._isBattleBack = false;
		
		if (self._slgbgm ~= nil) then
			GameEntry.Sound:StopSound(self._slgbgm)
		end
		local bgm = slgManager._defineHarbourData.Bgm
		if (string.len(bgm) == 0) then
			self._slgbgm = DarkBoomUtility.PlayBGM('slg_main')
		else
			self._slgbgm = DarkBoomUtility.PlayBGM(bgm)
		end
	else
	  if(GameEntry.PlayerData.CurrentHarbourId.Value ~= 0) then
          self:ChangeFormState(true)
      else
          self:ChangeFormState(false)
      end
	end
	--[[
	--]]
end)


xlua.hotfix(DarkBoom.ProcedureSLG, 'OnLeave',
	function(self,procedureOwner,isShutdown)



		base(self):OnLeave(procedureOwner,isShutdown)



		if GameEntry.Event:Check(OpenUIFormSuccessEventArgs.EventId,  tmpHandler2 ) then
			GameEntry.Event:Unsubscribe(OpenUIFormSuccessEventArgs.EventId,  tmpHandler2 )
		end
		
		


		if(self.m_WorldMapForm ~= nil and self.m_WorldMapForm.Available) then

	                self.m_WorldMapForm:Close()
	                self.m_WorldMapForm = nil
		end
		
			
		if(self.m_SLGForm ~= nil and self.m_SLGForm.Available) then
	                self.m_SLGForm:Close()
	                self.m_SLGForm = nil
		end
		

		if self._mapbgm ~= nil then
	       if(GameEntry.Sound:StopSound(self._mapbgm) == true) then
	            self._mapbgm = nil
		   end
		end
		

	    if(self._slgbgm ~= nil ) then		--and self._slgbgm.HasValue == true
	       if(GameEntry.Sound:StopSound(self._slgbgm) == true) then
	            self._slgbgm = nil
		   end
		end
		
	    self._mapbgm = nil
	    self._slgbgm = nil
		
end)



