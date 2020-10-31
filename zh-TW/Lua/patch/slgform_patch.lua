  local util = require 'xlua/util'
local DarkBoom = CS.DarkBoom
local UnityEngine = CS.UnityEngine
xlua.private_accessible(DarkBoom.SLGForm)

xlua.hotfix(DarkBoom.SLGForm, 'ClearSLG',
function(self)
	print("SLGForm")
 	self.m_CurSLGAction = DarkBoom.SLGAction.None;
 	if self._stages ~= nil then 
		print("self._stages"..self._stages.Count)
 		for i=0,self._stages.Count-1 do
 			print(i)
 			print(self._stages[i])
 			self._stages[i]:UnloadMap();
 		end
 		self._stages:Clear();
    end
    if self._specialStages ~= nil then 
    	print("self._specialStages"..self._specialStages.Count)
    	for i=0,self._specialStages.Count - 1 do
    		print(i)
    		print(self._specialStages[i])
    		self._specialStages[i]:UnloadMap();
    	end
 		self._specialStages:Clear();
    end

    if self._slgMapN ~= nil and self._slgMapN ~= "" then
    	print(self._slgMapN)
    	local slgMapString = tostring(self._slgMapN)
	   	DarkBoom.GameEntry.Resource:UnloadAsset(slgMapString);
	    self._slgMapN = "";
	end
end
)

-- xlua.hotfix(DarkBoom.SLGForm, 'CloseTeamAnim',
-- function(self,clickIn)
-- 	print(' CloseTeamAnim')
-- 	return util.cs_generator(function(clickIn)
-- 		local teamAnim = self._teamRoot:GetComponent(typeof(UnityEngine.Animation));
-- 	    teamAnim["slg_jianduizhankaitiao"].speed = -1;
-- 	    teamAnim["slg_jianduizhankaitiao"].time = teamAnim["slg_jianduizhankaitiao"].length;
-- 	    teamAnim:Play("slg_jianduizhankaitiao");

-- 	    local list = self._teamScroll:GetList();
-- 	    if list ~= nil then
-- 	    	local anim
-- 	    	for i=0,list.Count - 1 do
	    	
-- 	            anim = list[i]:GetComponent(typeof(UnityEngine.Animation));
-- 	            anim["slg_xiaoduizhankaitiao"].time = anim["slg_xiaoduizhankaitiao"].length;
-- 	            anim["slg_xiaoduizhankaitiao"].speed = -1;
-- 	            anim:Play("slg_xiaoduizhankaitiao");
-- 	      	end  
-- 	    end
	   
-- 	    self._teamScroll.ChildCount = 0;
-- 	    self._teamScroll:ReBuild();
-- 	    self._teamRoot:SetActive(false);

-- 	    if clickIn == true then 
	    
-- 	        self:ResetMenu(true);
	           
-- 	    end 
-- 	      coroutine.yield(UnityEngine.WaitForSeconds(0.1))
-- 	 end)
-- end)