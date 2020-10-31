local ActivitySupplicateEntry  = class("ActivitySupplicateEntry")
local TaskItem = require"Modules/Activity/Supplicate/AcSupplicateTaskItem"
local RewardItem = require"Modules/Activity/Supplicate/AcSupplicateRewardItem"

function ActivitySupplicateEntry:OnInit(gameObject,mask)
	self.injections = ParseInjections(gameObject)
    self.mask = mask
	self.gameObject = gameObject

	self:InjectComponent()
	self:Init(mask)
end

function ActivitySupplicateEntry:InjectComponent()
	self.btnSupplicate = self.injections.btnSupplicate
	self.imgSupplicateAnime = self.injections.imgSupplicateAnime
	self.txtSupplicateCost = self.injections.txtSupplicateCost
	self.traReward = self.injections.traReward
	self.traTask = self.injections.traTask
	self.taskItem = self.injections.taskItem
	self.rewardItem = self.injections.rewardItem
	self.btnTotal = self.injections.btnTotal
	self.avatar = self.injections.avatar
	self.txtRemainTime = self.injections.txtRemainTime
end

function ActivitySupplicateEntry:Init(mask)
	self.manager = Game:GetManager("AcSupplicateMgr")
    self.model = self.manager:GetModel()
    self.event = self.manager:GetEvent()
	self.model.resMask = mask
	self:AddListeners()
	
	self.taskItemList = {}
	self.rewardItemList = {}
	self.init = false
	self.timeDelta = 0
end

function ActivitySupplicateEntry:AddListeners()
	self.btnSupplicate.onClick:AddListener(function()
			self:PlayClickAnime()
		end)
	self.btnTotal.onClick:AddListener(function()
		LuaBridge.OpenUIForm(230)
	end)
	self.event.SupplicateInfoEvent:AddListener(self.OnSupplicateInfoEvent,self)
	self.event.GetRandRewardEvent:AddListener(self.OnSupplicateEvent,self)
	self.event.UpdateTaskInfoEvent:AddListener(self.OnTaskInfoEvent,self)
	UpdateEvent:AddListener(self.Update,self)
end

function ActivitySupplicateEntry:RemoveListeners()
	self.btnSupplicate.onClick:RemoveAllListeners()
	self.btnSupplicate.onClick:Invoke()
	self.btnTotal.onClick:RemoveAllListeners()
	self.btnTotal.onClick:Invoke()
	self.event.SupplicateInfoEvent:RemoveListener(self.OnSupplicateInfoEvent,self)
	self.event.GetRandRewardEvent:RemoveListener(self.OnSupplicateEvent,self)
	self.event.UpdateTaskInfoEvent:RemoveListener(self.OnTaskInfoEvent,self)
	UpdateEvent:RemoveListener(self.Update,self)
end

function ActivitySupplicateEntry:OnOpen(tagId)
	self.tagId = tagId
	self.model:SetTagId(tagId)
	self.manager:ReqSupplicateInfo(tagId)
	if self.init == false then
		local resourceId = self.model:GetResourceId()
		self.avatar:LoadAvatar(resourceId,CS.Config.AvatarScene.None,true)
		self.init = true
	end
end

function ActivitySupplicateEntry:Update()
	self.timeDelta = self.timeDelta + Time.deltaTime
	if self.timeDelta > 1 then
		self.timeDelta = 0
		local curTime = DarkBoomUtility.GetServerCrtTime()
		local endTime = self.model.countDown
		local remainTime = endTime - curTime
		if remainTime <= 0 then
			remainTime = 0
		end
		self.txtRemainTime.text = GetDefaultText("activity_new_text_09")..DarkBoomUtility.ToDayHourMinuteSecond(remainTime)
	end
end

function ActivitySupplicateEntry:OnSupplicateInfoEvent()
	self:RefreshTaskInfo()
	self:RefreshRewardInfo()
	self:RefreshScoreInfo()
end

function ActivitySupplicateEntry:OnSupplicateEvent()
	self:RefreshRewardInfo()
	self:RefreshScoreInfo()
end

function ActivitySupplicateEntry:OnTaskInfoEvent()
	self:RefreshTaskInfo()
	self:RefreshScoreInfo()
end

function ActivitySupplicateEntry:OnClickSupplicate()
	if not self.model:CanSupplicate() then
		local itemName = self.model:GetScoreName()
		local notEnough = string.gsub(GetDefaultText("common_resource_not_enough"),"{0}","")
		GameEntry.UI:OpenMsgTipsUIForm(itemName..notEnough, CS.DarkBoom.SoundEffectType.Tips)
		return
	end
	local actId = self.model:GetTagId()
	if actId == 0 then return end
	self.manager:ReqSupplicate(actId)
end

function ActivitySupplicateEntry:PlayClickAnime()
	self.btnSupplicate.enabled = false
	self.imgSupplicateAnime:Play("activity_supplicate",-1,0)
	CS.DG.Tweening.DOVirtual.DelayedCall(0.5, function()
		self:OnClickSupplicate()
		self.btnSupplicate.enabled = true
	end, false)
end

function ActivitySupplicateEntry:RefreshScoreInfo()
	local curScore = self.model:GetCurScore()
	local costScore = self.model:GetCostScore()
	if curScore >= costScore then
		self.txtSupplicateCost.text = string.format("<color=#00FFFF>%s</color><color=#FFFFFF>/%s</color>",curScore,costScore)
	else
		self.txtSupplicateCost.text = string.format("<color=#FF64A5>%s</color><color=#FFFFFF>/%s</color>",curScore,costScore)
	end
end

function ActivitySupplicateEntry:RefreshTaskInfo()
    for group, data in pairs(self.model.serverTaskList) do
		if self.taskItemList[group] == nil then
	        local go = GameObject.Instantiate(self.taskItem.gameObject,self.traTask.transform)
			go:SetActive(true)
			go.transform.localScale = Vector3.one
			local grid = TaskItem.new(go)
			self.taskItemList[group] = grid
		end
		self.taskItemList[group]:SetData(data)
    end
end

function ActivitySupplicateEntry:RefreshRewardInfo()
	local showList = self.model:GetShowRewardList()
	for i,v in ipairs(showList) do
		if self.rewardItemList[v.id] == nil then
			local go = GameObject.Instantiate(self.rewardItem.gameObject,self.traReward.transform)
			go:SetActive(true)
			go.transform.localScale = Vector3.one
			local grid = RewardItem.new(go)
			self.rewardItemList[v.id] = grid
		end
		local status = self.model:GetRewardStatus(v.id)
		self.rewardItemList[v.id]:SetData(v.reward,status)
	end
end

function ActivitySupplicateEntry:RefreshUI()
   
end

function ActivitySupplicateEntry:OnRelease()
	self:RemoveListeners()

	for k,v in pairs(self.taskItemList) do
		v:OnRelease()
	end

	for k,v in pairs(self.rewardItemList) do
		v:OnRelease()
	end

	self.taskItemList = {}
	self.taskItemList = nil

	self.rewardItemList = {}
	self.rewardItemList = nil
	self.injections = {}
	self.injections = nil
	self.manager = nil
	self.event = nil
	self.model = nil
end

function ActivitySupplicateEntry:SetActive(show)
	self.gameObject:SetActive(show);
end

return ActivitySupplicateEntry