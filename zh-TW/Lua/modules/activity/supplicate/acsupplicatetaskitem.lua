local AcSupplicateTaskItem  = class("AcSupplicateTaskItem")
local DefaultConfig = require"Configs/DefaultConfig"
local TaskRewardItem = require"Modules/Activity/Supplicate/AcSupplicateTaskRewardItem"
function AcSupplicateTaskItem:ctor(gameObject)
    if IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:Init()
end

function AcSupplicateTaskItem:InjectComponent()
	self.txtDesc = self.injections.txtDesc
	self.txtProgress = self.injections.txtProgress
	self.imgProgress = self.injections.imgProgress
	self.imgProgressBg = self.injections.imgProgressBg
	self.traReward = self.injections.traReward
	self.txtScore = self.injections.txtScore
	self.imgHighLight = self.injections.imgHighLight
	self.txtStatus = self.injections.txtStatus
	self.btnTask = self.injections.btnTask
	self.taskRewardItem = self.injections.taskRewardItem
end

function AcSupplicateTaskItem:Init()
	self.manager  = Game:GetManager("AcSupplicateMgr")
	self.model    = self.manager:GetModel()
	self.event    = self.manager:GetEvent()
	self.act_id = self.model:GetTagId()
    self.btnTask.onClick:AddListener(function()
		self:OnTaskBtnClick()
	end)
	self.taskRewardList = {}
end

function AcSupplicateTaskItem:OnTaskBtnClick()
	print(self.taskConfig.sourceid)
	if self.data.status == self.model.taskStatus.Not and self.taskConfig.sourceid ~= 0 then	
		LuaBridge.CloseUIForm(5040)
        CS.CommonTranslater.TranslateBySourceId(self.taskConfig.sourceid); 
    elseif self.data.status == self.model.taskStatus.Can then
        self.manager:ReqFinishTask(self.act_id,self.data.task_id)
    end
end

function AcSupplicateTaskItem:SetData(data)
    self.data = data
    self:UpdateState(data)
end

function AcSupplicateTaskItem:UpdateState(data)
    self.data = data
    self.taskConfig = self.model:GetTaskConfig(data.task_id)
	self.txtDesc.text = self.taskConfig.taskdesc
	self.imgHighLight.gameObject:SetActive(data.status == self.model.taskStatus.Can)
	local bgSize = self.imgProgressBg.transform.sizeDelta
	if data.progress >= self.taskConfig.taskcompleteconditionnum then
		local progress = self.taskConfig.taskcompleteconditionnum
		self.txtProgress.text = string.format("<color=#00FFFF>%s</color><color=#FFFFFF>/%s</color>",progress,self.taskConfig.taskcompleteconditionnum)
		self.imgProgress.transform.sizeDelta = bgSize
	else
		self.txtProgress.text = string.format("<color=#FF64A5>%s</color><color=#FFFFFF>/%s</color>",data.progress,self.taskConfig.taskcompleteconditionnum)
		local x = data.progress / self.taskConfig.taskcompleteconditionnum
		if x > 1 then x = 1 end
		self.imgProgress.transform.sizeDelta = Vector2(bgSize.x * x,bgSize.y)	
	end
	self.txtScore.text = tostring(self.model:GetTaskScore(data.group,data.task_id))
	if data.status == self.model.taskStatus.Not and self.taskConfig.sourceid ~= 0 then
		self.txtStatus.text = DefaultConfig.GetConfig("activity_new_text_05").value
	elseif data.status == self.model.taskStatus.Not and self.taskConfig.sourceid == 0 then
		self.txtStatus.text = DefaultConfig.GetConfig("activity_new_text_06").value
	elseif data.status == self.model.taskStatus.Can then
		self.txtStatus.text = DefaultConfig.GetConfig("activity_new_text_04").value
	else
		self.txtStatus.text = ""
	end
	self:UpdateReward(self.taskConfig.taskreward)
end

function AcSupplicateTaskItem:UpdateReward(reward)
	local datas = DarkBoomUtility.ParseRewardString(reward)
	for k,v in pairs(self.taskRewardList) do
		v.gameObject:SetActive(false)
	end
	for k,v in pairs(datas) do
		if self.taskRewardList[k] == nil then
			local go = GameObject.Instantiate(self.taskRewardItem.gameObject,self.traReward.transform)
			local grid = TaskRewardItem.new(go)
			self.taskRewardList[k] = grid
		end
		self.taskRewardList[k].gameObject:SetActive(true)
		self.taskRewardList[k]:SetData(v)
	end
end

function AcSupplicateTaskItem:OnRelease()
	self.btnTask.onClick:RemoveAllListeners()
	self.btnTask.onClick:Invoke()

	for k,v in pairs(self.taskRewardList) do
		v:OnRelease()
	end

	self.taskRewardList = {}
	self.taskRewardList = nil
end

return AcSupplicateTaskItem
