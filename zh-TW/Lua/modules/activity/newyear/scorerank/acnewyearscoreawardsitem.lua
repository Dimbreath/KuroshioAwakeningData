local AcNewYearScoreAwardsItem  = class("AcNewYearScoreAwardsItem")

function AcNewYearScoreAwardsItem:LUA_Init(gameObject)
    if IsGameObjectNull(gameObject) then
       print_error("gameObject == nil")
       return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:Init()
end

function AcNewYearScoreAwardsItem:InjectComponent()
    self.RankLower = self.injections.RankLower
    self.RankUpper = self.injections.RankUpper
    self.AwardRoot = self.injections.AwardRoot
    self.LoseRank = self.injections.LoseRank
end

function AcNewYearScoreAwardsItem:Init()
    self.manager = Game:GetManager("AcNewYearManager")
    self.model = self.manager:GetModel()  
    self:AddListeners()
end

function AcNewYearScoreAwardsItem:AddListeners()

end

function AcNewYearScoreAwardsItem:LUA_SetData(obj)
    self.index = obj[2]
    self.isDailyAward = obj[1] == self.model.awardType.Daily
    self.isSelf = self.index == -1
    local awardData = {}
    if self.isSelf then
        local awardList = self.isDailyAward and self.model.dayRankRewardList or self.model.finalRankRewardList
        awardData = self:GetSelfRankAward(awardList) 
        if self.model.selfRank.rank <=0 then
           self.LoseRank.gameObject:SetActive(true)
           self.RankUpper.gameObject:SetActive(false)
        else
           self.RankUpper.text = self.model.selfRank.rank
           self.LoseRank.gameObject:SetActive(false)
           self.RankUpper.gameObject:SetActive(true)
        end     
    else
        awardData = self.isDailyAward and self.model.dayRankRewardList[self.index + 1] or self.model.finalRankRewardList[self.index + 1]
        if awardData.upperLimit <=0 then
           self.LoseRank.gameObject:SetActive(true)
           self.RankUpper.gameObject:SetActive(false)
        else
           self.RankLower.text = awardData.lowerLimit
        self.RankUpper.text = awardData.upperLimit 
           self.LoseRank.gameObject:SetActive(false)
           self.RankUpper.gameObject:SetActive(true)
        end                
    end 
    self:SetAwardShowUI(awardData)
end

function AcNewYearScoreAwardsItem:SetAwardShowUI(awardData)
    if awardData == nil then
       return
    end
    local cloneTab = self:Clone(TableLength(awardData.reward))
    for k,v in pairs(cloneTab) do
        local data = awardData.reward[k] 
        local itemCell = v:GetComponent(typeof(CS.DarkBoom.ItemCell))      
        itemCell:RefreshDataLua(data.id,data.num,data.type, self.model.rankFormMask)
        itemCell:SetItemSize(DarkBoom.ItemSize.Size_0_7)
        DarkBoomUtility.AddItemDetail(v.gameObject, tonumber(data.id), DarkBoom.ItemCellType.Item)
    end    
end

function AcNewYearScoreAwardsItem:GetSelfRankAward(awardList)    
    local selfRank = self.model.selfRank.rank
    for k,v in pairs(awardList) do
        if selfRank >= v.upperLimit and selfRank <= v.lowerLimit then          
           return v
        end
    end
end

function AcNewYearScoreAwardsItem:Clone(needCount)
    local tab = {}
    local clone = self.AwardRoot.transform:GetChild(0)
    if clone == nil then
        return
    end
    local curCount = self.AwardRoot.transform.childCount
    if curCount < needCount then
        for i = 0,curCount - 1,1 do
            local child = self.AwardRoot.transform:GetChild(i)
            child.gameObject:SetActive(true)
            table.insert(tab,child)      
        end 
        while(self.AwardRoot.transform.childCount < needCount)
        do
           local go = GameObject.Instantiate(clone,self.AwardRoot.transform)
           go.gameObject:SetActive(true)
           table.insert(tab,go.transform)
        end        
    else
        for i = 0,needCount - 1,1 do
            local child = self.AwardRoot.transform:GetChild(i)
            child.gameObject:SetActive(true)
            table.insert(tab,child)    
        end
        for i = needCount,curCount - 1,1 do
            local child = self.AwardRoot.transform:GetChild(i)
            child.gameObject:SetActive(false)    
        end
    end
    return tab
end


function AcNewYearScoreAwardsItem:LUA_Close()
    self.manager = nil
    self.model = nil

    self.RankLower = nil
    self.RankUpper = nil
    self.AwardRoot = nil
    self.LoseRank = nil

    self.injections = {}
    self.injections = nil
    self:RemoveListeners()
end

function AcNewYearScoreAwardsItem:RemoveListeners()

end

return AcNewYearScoreAwardsItem