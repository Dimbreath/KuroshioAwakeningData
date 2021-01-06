local AcNewYearScoreAwardPanel  = class("AcNewYearScoreAwardPanel")

function AcNewYearScoreAwardPanel:ctor(gameObject)
   if IsGameObjectNull(gameObject) then
      print_error("gameObject == nil")
      return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:Init()
end

function AcNewYearScoreAwardPanel:InjectComponent()
    self.AwardSrollLst = self.injections.AwardSrollLst
    self.AwardItem = self.injections.AwardItem
    self.SelfAwardItem = self.injections.SelfAwardItem
    self.CountDown = self.injections.CountDown
end

function AcNewYearScoreAwardPanel:Init()
	self.manager = Game:GetManager("AcNewYearManager")
	self.model = self.manager:GetModel()
	self.event = self.manager:GetEvent()

    self.AwardSrollLst.Child = self.AwardItem.gameObject
    self.AwardSrollLst.rowSpace = 9

    self.elapseSeconds = 0
    self.awardCd = 0

	self:AddListeners()
end

function AcNewYearScoreAwardPanel:AddListeners()
	self.event.RefreshAwardCd:AddListener(self.OnRefreshAwardCd,self)
end

function AcNewYearScoreAwardPanel:InitAwardData(rewardType)
    self.isDailyAward = rewardType == self.model.awardType.Daily
    if self.isDailyAward then
       self.awardList = self.model.dayRankRewardList
    else
       self.awardList = self.model.finalRankRewardList
    end

    local OnRenderAwardItem = function(index, child)
        local luaview = child:GetComponent(typeof(CS.DarkBoom.LuaView))
        local paramTab = {}
        if self.isDailyAward then
           table.insert(paramTab,self.model.awardType.Daily)
        else
           table.insert(paramTab,self.model.awardType.Final)          
        end
        table.insert(paramTab,index)   
        luaview:SetData(paramTab)
    end
    self.AwardSrollLst.onItemRender = OnRenderAwardItem
end

function AcNewYearScoreAwardPanel:OnRefreshAwardCd()
    if self.isDailyAward then
       self.awardCd = self.model.dailyAwardCd
    else
       self.awardCd = self.model.finalAwardCd
    end 
end

function AcNewYearScoreAwardPanel:ShowAwardUI()
    if not self.isInit then       
       self:ShowAwardList()
    else
       self.AwardSrollLst.scrollRect.verticalNormalizedPosition = 1
    end
    self:ShowSelfAward()
end

function AcNewYearScoreAwardPanel:ShowAwardList()
    self.awardCount = TableLength(self.awardList)   
    self.AwardSrollLst.ChildCount = self.awardCount
    self.AwardSrollLst:ReBuild()
    self.AwardSrollLst.scrollRect.vertical = true    
    self.isInit = true
end

function AcNewYearScoreAwardPanel:ShowSelfAward()
    local selfLuaView = self.SelfAwardItem:GetComponent(typeof(CS.DarkBoom.LuaView))
    local paramTab = {}
    if self.isDailyAward then
        table.insert(paramTab,self.model.awardType.Daily)
    else
        table.insert(paramTab,self.model.awardType.Final)          
    end
    table.insert(paramTab,-1)
    selfLuaView:SetData(paramTab)  
end

function AcNewYearScoreAwardPanel:RefreshSelfAward()
    self:ShowSelfAward()
end

function AcNewYearScoreAwardPanel:RemoveListeners()
    self.event.RefreshAwardCd:RemoveListener(self.OnRefreshAwardCd,self)
end

function AcNewYearScoreAwardPanel:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
    if self.awardCd == nil then
       return
    end
	self.elapseSeconds = self.elapseSeconds + elapseSeconds  
    if self.elapseSeconds > 1 then
        self.elapseSeconds = 0
        local remainTime = self.awardCd - DarkBoomUtility.GetServerCrtTime()
        if remainTime < 0 then
            if self.isDailyAward then
               --重新获取时间
               self.manager:ReqGetRankInfo()
            else
               --活动结束
            end                            
        else
            if self.isDailyAward then
               self.CountDown.text = DarkBoomUtility.ToHourMinuteSecond(remainTime)
            else
               self.CountDown.text = DarkBoomUtility.ToDayHourMinuteSecondNew(remainTime)
            end
        end    
    end
end

function AcNewYearScoreAwardPanel:OnRelease()
    self.gameObject = nil
    self.AwardSrollLst = nil
    self.AwardItem = nil
    self.SelfAwardItem = nil
    self.CountDown = nil

	self.injections = {}
    self.injections = nil
	self:RemoveListeners()

    self.manager = nil  
    self.model = nil
    self.event = nil
end

return AcNewYearScoreAwardPanel
