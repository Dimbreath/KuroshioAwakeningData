local MonopolyTaskItem  = class("MonopolyTaskItem")

function MonopolyTaskItem:ctor(gameObject)
   if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:Init()
end

function MonopolyTaskItem:InjectComponent()
	self.TotalProgress = self.injections.TotalProgress
	self.CurrProgress = self.injections.CurrProgress
	self.RewarNum = self.injections.RewarNum
	self.TaskBtn = self.injections.TaskBtn
	self.TaskDesc = self.injections.TaskDesc
	self.CompletedStatus = self.injections.CompletedStatus
	self.ReceiveStatus = self.injections.ReceiveStatus
	self.GotoStateStatus = self.injections.GotoStateStatus
	self.OtherStatusBG   = self.injections.OtherStatusBG
	self.ReceiveStatusBG = self.injections.ReceiveStatusBG
end

function MonopolyTaskItem:Init()
	self.manager  = Game:GetManager("MonopolyManager")
	self.model    = self.manager:GetModel()
	self.event    = self.manager:GetEvent()
	
    self.TaskBtn.onClick:AddListener(function()
		self:OnTaskBtnClick()
    end)
end

function MonopolyTaskItem:OnTaskBtnClick()
	if self.data.status == 0 then
		print(self.taskConfig.sourceid)
        CS.CommonTranslater.TranslateBySourceId(self.taskConfig.sourceid); 
    elseif self.data.status == 1 then
        self.manager:GetTaskReward(self.data.task_id)
    end
end

function MonopolyTaskItem:SetData(data)
    self.data = data
    self:UpdateState(data)
end

function MonopolyTaskItem:UpdateState(data)
    self.data = data
    self.taskConfig = self.model:GetTaskConfig(data.task_id)
	self.TaskDesc.text = self.taskConfig.taskname
	
	--status -> 0:未完成，1：可领取，2：已领取
	self.OtherStatusBG.gameObject:SetActive(data.status ~= 1)
	self.ReceiveStatusBG.gameObject:SetActive(data.status == 1)

	self.CompletedStatus.gameObject:SetActive(data.status == 2)
	self.ReceiveStatus.gameObject:SetActive(data.status == 1)
	self.GotoStateStatus.gameObject:SetActive(data.status == 0)
	self.CurrProgress.text = string.format("<color=#00FFFF>%s</color><color=#FFFFFF>/%s</color>",data.progress,self.taskConfig.taskcompleteconditionnum)

	local rewardList = string.split(self.taskConfig.taskreward,",")
	
	if  rewardList ~= nil and #rewardList >=3  then
		self.RewarNum.text = tostring(rewardList[3])
	end
end

function MonopolyTaskItem:OnRelease()
	self.TaskBtn.onClick:RemoveAllListeners()
	self.TaskBtn.onClick:Invoke()
end

return MonopolyTaskItem
