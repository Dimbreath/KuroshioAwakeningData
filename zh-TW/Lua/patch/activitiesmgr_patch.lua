local DarkBoom = CS.DarkBoom

xlua.private_accessible(DarkBoom.ActivitiesMgr)

xlua.hotfix(DarkBoom.ActivitiesMgr, 'PlayerLevelUp',
function(self,level)
	print('register PlayerLevelUp 0000')
	local iter = self.m_AllTasks.Values:GetEnumerator()
	print('register PlayerLevelUp 22222')
	while iter:MoveNext() do
		print('register PlayerLevelUp 333')
		local item = iter.Current
		print('register PlayerLevelUp 44444')
		if (item.completedType == 1) then
			print('register PlayerLevelUp 55555')
        	local conditionLevel = tonumber(item.completedPara)
        	print('register PlayerLevelUp 66666')
	        if (conditionLevel <= level) then
	        	print('register PlayerLevelUp 7777')
	            item.repeatCount = item.repeatCount + 1
	        	item.state =DarkBoom.ActivityTaskState.Completed
	        end
        end
	end

end)