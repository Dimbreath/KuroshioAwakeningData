local AcNewYearScoreRankPanel  = class("AcNewYearScoreRankPanel")

function AcNewYearScoreRankPanel:ctor(gameObject)
    if IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:Init()
end

function AcNewYearScoreRankPanel:InjectComponent()
	self.EmptyRank = self.injections.EmptyRank
	self.RankRoot = self.injections.RankRoot

    self.RankScrollList = self.injections.RankScrollList
    self.RankItem = self.injections.RankItem
    self.SelfItem = self.injections.SelfItem    
end

function AcNewYearScoreRankPanel:Init()
	self.manager = Game:GetManager("AcNewYearManager")
	self.model = self.manager:GetModel()
	self.event = self.manager:GetEvent()

	local OnRenderRankItem = function(index, child)
        local luaview = child:GetComponent(typeof(CS.DarkBoom.LuaView))
        luaview:SetData(index)
    end
    self.RankScrollList.Child = self.RankItem.gameObject
    self.RankScrollList.onItemRender = OnRenderRankItem
    self.RankScrollList.rowSpace = 7

	self:AddListeners()
end

function AcNewYearScoreRankPanel:AddListeners()
	self.event.RefreshRankList:AddListener(self.OnRefreshRankList,self)
end

function AcNewYearScoreRankPanel:OnRefreshRankList()
    local rankCount = TableLength(self.model.rankList)
    if rankCount > 0 then       
        self.EmptyRank.gameObject:SetActive(false)
        self.RankRoot.gameObject:SetActive(true)
        --从小到大排序
        table.sort(self.model.rankList,function(a,b) return a.rank < b.rank end)        
        self.RankScrollList.ChildCount = rankCount
        self.RankScrollList:ReBuild()
        self.RankScrollList.scrollRect.vertical = true
    else
        self.EmptyRank.gameObject:SetActive(true)
        self.RankRoot.gameObject:SetActive(false)
    end
    local selfLuaView = self.SelfItem:GetComponent(typeof(CS.DarkBoom.LuaView))
    selfLuaView:SetData(-1)  
end

function AcNewYearScoreRankPanel:RemoveListeners()
	self.event.RefreshRankList:RemoveListener(self.OnRefreshRankList,self)
end


function AcNewYearScoreRankPanel:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
	
end

function AcNewYearScoreRankPanel:OnRelease()
    self.gameObject = nil
	self.EmptyRank = nil
	self.RankRoot = nil
    self.RankScrollList = nil
    self.RankItem = nil
    self.SelfItem = nil

	self.injections = {}
    self.injections = nil
	self:RemoveListeners()
	
	self.manager = nil  
    self.model = nil
    self.event = nil
end

return AcNewYearScoreRankPanel
