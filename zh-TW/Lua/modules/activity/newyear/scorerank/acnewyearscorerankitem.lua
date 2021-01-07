local AcNewYearScoreRankItem  = class("AcNewYearScoreRankItem")
local HeadConfig = require"Configs/HeadConfig"

function AcNewYearScoreRankItem:LUA_Init(gameObject)
    if IsGameObjectNull(gameObject) then
       print_error("gameObject == nil")
       return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:Init()
end

function AcNewYearScoreRankItem:InjectComponent()
    self.ItemBtn = self.injections.ItemBtn
    self.Name = self.injections.Name
    self.CharIcon = self.injections.CharIcon
    self.Score = self.injections.Score
    self.SelfFlag = self.injections.SelfFlag
    self.Rank = self.injections.Rank
    self.Rank_1 = self.injections.Rank_1
    self.Rank_2 = self.injections.Rank_2
    self.Rank_3 = self.injections.Rank_3
    self.LoseRank = self.injections.LoseRank
end

function AcNewYearScoreRankItem:Init()
    self.manager = Game:GetManager("AcNewYearManager")
    self.model = self.manager:GetModel() 
    self.rankSpecial = {self.Rank_1,self.Rank_2,self.Rank_3} 
    self:AddListeners()
end

function AcNewYearScoreRankItem:AddListeners()
    self.ItemBtn.onClick:AddListener(function()
        self:OnItemBtnClick()
    end)
end

function AcNewYearScoreRankItem:OnItemBtnClick()
    if self.isSelf then
       return
    end
    if self.selfInList then
       return
    end
    DarkBoom.FriendModelManager.GetInstance():TryOpenFriendInfoForm(tostring(self.rankData.uid))
end

function AcNewYearScoreRankItem:LUA_SetData(obj)
    self.index = tonumber(obj)
    self.isSelf = self.index == -1
    local rankData = {}
    --获取数据
    if self.isSelf then
        rankData.score = self.model.selfRank.score
        rankData.avatar = DarkBoom.GameEntry.PlayerData.avatar.Value
        rankData.uname = DarkBoom.GameEntry.PlayerData.Name.Value
        rankData.rank = self.model.selfRank.rank
        self.SelfFlag.gameObject:SetActive(false) 
    else
        rankData = self.model.rankList[self.index + 1]   
        rankData.avatar = tonumber(rankData.avatar)
        self.selfInList = rankData.uid == DarkBoom.GameEntry.PlayerData.UserId.Value
        self.SelfFlag.gameObject:SetActive(self.selfInList)   
    end
    --前三名特殊显示
    for i,v in ipairs(self.rankSpecial) do
        if rankData.rank == i then
           v.gameObject:SetActive(true)
        else
           v.gameObject:SetActive(false)  
        end
    end

    if self.isSelf then
       if rankData.rank <= 0 then      --己方未上榜
          self.Rank.gameObject:SetActive(false)
          self.LoseRank.gameObject:SetActive(true)
       else   --己方第四名后排名
          self.LoseRank.gameObject:SetActive(false)
          self.Rank.text = rankData.rank
          self.Rank.gameObject:SetActive(true)
       end
    else
        if rankData.rank > TableLength(self.rankSpecial) then  --排行列表第四名后排名
           self.Rank.text = rankData.rank
           self.Rank.gameObject:SetActive(true)
        else
           self.Rank.gameObject:SetActive(false)
        end
    end

    --名字、头像、积分显示
    self.Name.text = rankData.uname
    self.Score.text = rankData.score
    local config = HeadConfig.GetConfig(rankData.avatar)
    self.CharIcon.gameObject:SetActive(false)
    if config ~= nil then
        DarkBoom.BoatAssetUtility.LoadBoatLay(DarkBoomUtility.TryLongParse(config.resource), self.CharIcon, self.model.rankFormMask, false,function()
            self.CharIcon.gameObject:SetActive(true)
        end)
    end
    self.rankData = rankData
end

function AcNewYearScoreRankItem:LUA_Close()
    self:RemoveListeners()
    self.manager = nil
    self.model = nil
    self.rankSpecial = {}
    self.rankSpecial = nil
    self.rankData = nil

    self.gameObject = nil
    self.ItemBtn = nil
    self.Name = nil
    self.CharIcon = nil
    self.Score = nil
    self.SelfFlag = nil
    self.Rank = nil
    self.Rank_1 = nil
    self.Rank_2 = nil
    self.Rank_3 = nil
    self.LoseRank = nil

    self.injections = {}
    self.injections = nil    
end

function AcNewYearScoreRankItem:RemoveListeners()
    self.ItemBtn.onClick:RemoveAllListeners()
    self.ItemBtn.onClick:Invoke()
end

return AcNewYearScoreRankItem