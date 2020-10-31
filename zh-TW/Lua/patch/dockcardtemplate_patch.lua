local util = require 'xluautil'

local DarkBoom = CS.DarkBoom
local Tweener = CS.DG.Tweening
local Animation = CS.UnityEngine.Animation
local UnityEngine = CS.UnityEngine

xlua.hotfix(DarkBoom.DockCardTemplate, 'RefreshByDetailState',
function(self,showDetailState,isAnim)
	self.showDetailState = showDetailState;

		if not isAnim then
			if self.showDetailState == 1 then 
            	self.proDetail:SetActive(true);
	        else
	        	self.proDetail:SetActive(false);
	        end
	    
			if showDetailState == 1 then
				self.proDetailAnimation:get_Item("dock_property2").time = self.proDetailAnimation:get_Item("dock_property2").length;
				self.proDetailAnimation:get_Item("dock_property2").speed = 1;
				self.proDetailAnimation:Play("dock_property2");
			end
			return;
		end
        
		
        self.proDetailAnimation:Stop();

        if self.showDetailState == 1 then
           self.proDetail:SetActive(true);

           self.proDetailAnimation:get_Item("dock_property2").time = 0;
           self.proDetailAnimation:get_Item("dock_property2").speed = 1;
           self.proDetailAnimation:Play("dock_property2");
        else
           self.proDetailAnimation:get_Item("dock_property2").time = self.proDetailAnimation:get_Item("dock_property2").length;
           self.proDetailAnimation:get_Item("dock_property2").speed = -1;
           self.proDetailAnimation:Play("dock_property2");


            if self.showDetailState == 3 then
                self:ShowExpAdd(true);
                self:PlayExpAddAniamtion();
                local nextexp = DarkBoomUtility.GetExpLv(self.charInfo.character_id, self.charInfo.lv);
                if nextexp == 0 then 
                	nextexp = 1;
                else
                	nextexp = nextexp;
                end
                
                self.expAddPercent.text = self.charInfo.exp .. "/" .. nextexp;
                self.expAddProgress.transform.localScale = UnityEngine.Vector3(self.charInfo.exp / nextexp, 1, 1);
                self.expAddUp.text = "Exp+" .. self.charInfo.addExp;
            end

            Tweener.DOVirtual.DelayedCall(self.proDetailAnimation:get_Item("dock_property2").length, function()
               self.proDetail:SetActive(false);
            end
            );
        end
end)