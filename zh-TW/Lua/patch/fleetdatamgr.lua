local util = require 'xluautil'
local DarkBoom = CS.DarkBoom
local UnityEngine = CS.UnityEngine

local GameEntry = DarkBoom.GameEntry


xlua.hotfix(DarkBoom.FleetDataMgr, 'AcceptApply',
function(self,id)
	 print("FleetDataMgr。AcceptApply")
	 local GameEntry = 
	  DarkBoom.FleetRequest.AcceptApplication(id, function()
           		print("hehehe")
				self.applyMembersModel:Remove(id);
				print("heaaaaa")
				print(self)
				print(GameEntry.Event)
				GameEntry.Event:Fire(self, CS.GameFramework.ReferencePool.Acquire(typeof(DarkBoom.FleetDataMgr.FleetApplyersEventArgs)));
			end, 
			function(err_code, err_msg) 
				print(err_code)
				print(type(err_code))
				print(err_code == 61098)
               if err_code == "63033" or err_code == "61098" then 
               	print(err_code)
               		self.applyMembersModel:Remove(id);
               			GameEntry.Event:Fire(self, CS.GameFramework.ReferencePool.Acquire(typeof(DarkBoom.FleetDataMgr.FleetApplyersEventArgs)));
               end
             
            end);
end)

