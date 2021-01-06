local AcNewYearModel   = class("AcNewYearModel")
local ItemConfig = require"Configs/ItemConfig"
local BattleYearNewConfig = require"Configs/BattleYearNewConfig"
local HarbourInfoConfig = require"Configs/HarbourInfoConfig"
local NewYearMapConfig = require"Configs/NewYearMapConfig"
local BuffConfig = require"Configs/BuffConfig"
local NewYearIntegralConfig = require"Configs/NewYearIntegralConfig"
local DayRankRewardConfig = require"Configs/DayRankRewardConfig"
local RankRewardConfig = require"Configs/RankRewardConfig"

function AcNewYearModel:ctor()
    self:ResetData()
    self:InitEnum()
    self:InitData()
end

function AcNewYearModel:InitEnum()
    self.buffType = 
    {
        Our = 1,
        Enemy = 2,
    }
    self.battleType =
    {
        Normal = 1,
        Boss = 2,
    }
    self.harbourType =
    {
        Story = 2,
        Defend = 7,
        Attack = 8,
        Reward = 9,
    }

    self.harbourStatus =
    {
        Lock = 0,--锁定
        Open = 1,--已开放
        Clear = 2,--已通关
    }
    
    self.awardType = 
    {
    	Daily = 1,
    	Final = 2,
    }
end

function AcNewYearModel:InitData()
    self.acNewYearMainFormId = 7074
	self.integral = 0 
    self.maxMorale = tonumber(GetGlobalText("NewYearMorale"))    
    local resItemData = string.split(GetGlobalText("NewYear_item"),',') 
    self.primaryResItemId = tonumber(resItemData[1])
    self.middleResItemId = tonumber(resItemData[2])
    self.highResItemId = tonumber(resItemData[3])
    self.resItemMaxPayNum = tonumber(GetGlobalText("NewYear_item_max"))
    self.scoreRankShowNum = tonumber(GetGlobalText("NewYearRank"))
    self.enemyMaxMorale = tonumber(GetGlobalText("NewYearMorale_enemy"))
    self.newYearHarbourList = nil
    self.ourBuffTotalList = nil
    self.enemyBuffTotalList = nil
    self.selectOurBuffList = {}
    self.selectEnemyBuffList = {}
    self.isOwnBuff = false                -- 是否我方buff
    self.harbourId = 0
    self:ParseBattleYearNewConfig()
    self:ParseDayRankReward()
    self:ParseFinalRankReward()
end

function AcNewYearModel:ResetData()
    self.defendActivityId = 0
    self.attackActivityId = 0
    self.curMorale = 0 --我方士气
    self.country_counterattack = {} --反攻每个国家进度
    self.can_draw_personal = 0 --是否领取个人反攻奖励 0 不可领取，1 未领取，2 已领取
    self.country_serverattack_num = 0 --全服反攻进度
    self.can_draw_server = 0 --是否领取全服反攻奖励 0 不可领取，1 未领取，2 已领取
    self.reward_npc = 0 --npc奖励 0 无，1 有
    self.harbour_difficulty_passed = {} --各港口已通关的难度，用于显示首通奖励
    self.active_buffs = {} --已激活的任务奖励buff
    self.boss_start_time = 0
    self.boss_end_time = 0
end

function AcNewYearModel:SetInfos(serverData)
    self:ResetData()
    self.defendActivityId = serverData.defend.id
    self.curMorale = serverData.defend.morale_point
    self.attackActivityId = serverData.attack.id
    for k,v in pairs(serverData.attack.country_counterattack) do
        self.country_counterattack[k] = v
    end
    self.can_draw_personal = serverData.attack.can_draw_personal
    self.country_serverattack_num = serverData.attack.country_serverattack_num
    self.can_draw_server = serverData.attack.can_draw_server
    self.reward_npc = serverData.reward_npc
    for k,v in pairs(serverData.harbour_difficulty_passed) do
        self.harbour_difficulty_passed[k] = {}
        for k1,v1 in pairs(v) do
            self.harbour_difficulty_passed[k][v1] = true
        end
    end
    for k,v in pairs(serverData.active_buffs) do
        self.active_buffs[v] = true
    end
	self.boss_start_time = serverData.boss_start_time or 0
	self.boss_end_time = serverData.boss_end_time or 0
end

function AcNewYearModel:GetCurActivityConfig()
    if DarkBoom.ActivitiesMgr.GetInstance():IsActivityOpen(self.defendActivityId) then
        return DarkBoom.ActivitiesMgr.GetInstance():GetActivityConfigData(self.defendActivityId)
    elseif DarkBoom.ActivitiesMgr.GetInstance():IsActivityOpen(self.attackActivityId) then
        return DarkBoom.ActivitiesMgr.GetInstance():GetActivityConfigData(self.attackActivityId)
    else
        print_error("activity is not open!")
        return nil
    end
end

function AcNewYearModel:GetNewYearHarbour(harbourId,difficultyId)
    if self.newYearHarbourList[harbourId] == nil then
        print_error("can`t find config with harbourId:"..harbourId)
        return nil
    end
    if difficultyId <= 0 then
        return self.newYearHarbourList[harbourId][1]
    elseif difficultyId > #self.newYearHarbourList[harbourId] then
        return self.newYearHarbourList[harbourId][#self.newYearHarbourList[harbourId]]
    else
        return self.newYearHarbourList[harbourId][difficultyId]
    end
end

function AcNewYearModel:IsHarbourClear(harbourId,difficultyId)
    if self.harbour_difficulty_passed[harbourId] ~= nil then
        return self.harbour_difficulty_passed[harbourId][difficultyId] or false
    end
    return false
end

function AcNewYearModel:GetHarbourInfo(harbourId)
    return HarbourInfoConfig.GetConfig(harbourId)
end

function AcNewYearModel:GetHarbourStatus(harbourId)
    local config = self:GetHarbourInfo(harbourId)
    local precondi = config.precondi
    local isUnLock = true
    for i,v in ipairs(precondi) do
        isUnLock = isUnLock and DarkBoom.CondiUtility.CheckSingleCondition(v,nil)
    end
    if isUnLock then
        local harbourModel = GameEntry.PlayerData:GetMapById(harbourId)
        local isClear = harbourModel ~= nil and harbourModel.isCleared
        if isClear then
            return self.harbourStatus.Clear
        else
            return self.harbourStatus.Open
        end
    else
        return self.harbourStatus.Lock
    end
end

function AcNewYearModel:ParseBattleYearNewConfig()
    self.newYearHarbourList = {}
    for k,v in pairs(BattleYearNewConfig.Values) do
        local config = BattleYearNewConfig.GetConfig(k)
        if self.newYearHarbourList[config.harbourid] == nil then
            self.newYearHarbourList[config.harbourid] = {}
        end
        self.newYearHarbourList[config.harbourid][config.difficultyid] = config
    end
end

function AcNewYearModel:GetHarbourList(activityId)
    local continent = 0
    local activityConfig = DarkBoom.ActivitiesMgr.GetInstance():GetActivityConfigData(activityId)
    if activityConfig ~= nil then
        continent = tonumber(activityConfig.parameter_2)
    end 
    local list = {}
    for k,v in pairs(HarbourInfoConfig.Values) do
        local config = HarbourInfoConfig.GetConfig(k)
        if config.continent == continent then
            list[k] = config
        end
    end
    return list
end

function AcNewYearModel:GetNpcList()
    local list = {}
    for k,v in pairs(NewYearMapConfig.Values) do
        local config = NewYearMapConfig.GetConfig(k)
        list[k] = config
    end
    return list
end

function AcNewYearModel:GetCountryProcess(countryId)
    local morale = self.country_counterattack[countryId] or 0
    local percent = math.ceil(morale/self.enemyMaxMorale * 100)
    return percent
end

function AcNewYearModel:GetAttackHarbourCountryId(harbourId)
    local battleYearNewConfig = self:GetNewYearHarbour(harbourId,1)
    if battleYearNewConfig == nil then
        return 0
    end
    local morale = string.split(battleYearNewConfig.morale,",")
    return morale[1] or 0
end

--获取反攻完成进度
function AcNewYearModel:GetAttackProcess()
    local process = 0
    local maxProcess = 0
    for k,v in pairs(self.country_counterattack) do
        if v == 0 then
            process = process + 1
        end
        maxProcess = maxProcess + 1
    end
    return process,maxProcess
end

function AcNewYearModel:ParseBuffConfig()
    self.ourBuffTotalList = {}
    self.enemyBuffTotalList = {}
    for k,v in pairs(BuffConfig.Values) do
        local config = BuffConfig.GetConfig(k)
        if config.target == self.buffType.Our then
            table.insert(self.ourBuffTotalList,k)
        elseif config.target == self.buffType.Enemy then
            table.insert(self.enemyBuffTotalList,k)
        end
    end
end

function AcNewYearModel:GetEnemyBuffList()
    if self.enemyBuffTotalList == nil then
        self:ParseBuffConfig()
    end
    return self.enemyBuffTotalList
end

function AcNewYearModel:GetOurBuffList()
    if self.ourBuffTotalList == nil then
        self:ParseBuffConfig()
    end
    return self.ourBuffTotalList
end

function AcNewYearModel:AddSelectBuff(selectList,isEnemy)
    if isEnemy then
        self.selectEnemyBuffList = {}
        for k,v in pairs(selectList) do
            table.insert(self.selectEnemyBuffList,v)
        end
    else
        self.selectOurBuffList = {}
        for k,v in pairs(selectList) do
            table.insert(self.selectOurBuffList,v)
        end
    end

end

function AcNewYearModel:IsActiveBuff(id)
    return self.active_buffs[id] or false
end

function AcNewYearModel:IsSelectBuff(id)
    for i,v in ipairs(self.selectEnemyBuffList) do
        if v == id then
            return true
        end
    end
    for i,v in ipairs(self.selectOurBuffList) do
        if v == id then
            return true
        end
    end
    return false
end

function AcNewYearModel:GetMaxBuffCost()
    local cost = 0
    for k,v in pairs(NewYearIntegralConfig.Values) do
        local config = NewYearIntegralConfig.GetConfig(k)
        if config.integral <= self.integral and config.coin > cost then
            cost = config.coin
        end
    end
    return cost
end

function AcNewYearModel:GetBuffValue(isEnemy)
    local list = {}
    if isEnemy then
        list = self.selectEnemyBuffList
    else
        list =self.selectOurBuffList
    end
    local buffValue = 0
    for i,v in ipairs(list) do
        local config = BuffConfig.GetConfig(v)
        buffValue = buffValue + config.value
    end
    return buffValue
end

function AcNewYearModel:GetSelectBuffJson()
    local json = ""
    for i,v in ipairs(self.selectEnemyBuffList) do
        if json == "" then
            json = v
        else
            json = json..","..v
        end
    end
    for i,v in ipairs(self.selectOurBuffList) do
        if json == "" then
            json = v
        else
            json = json..","..v
        end
    end
    if json ~= "" then
        json = "["..json.."]"
    end
    return json
end

function AcNewYearModel:GetTeamIdByBattleType(harbour_id,type)
    local index = 1
    if type == self.battleType.Normal then
        index = 1
    elseif type == self.battleType.Boss then
        index = 2
    end
    return CS.SLGManager.GetInstance():GetTeamIDByHarbourID(harbour_id,index)
end

function AcNewYearModel:RefreshMorale(data)
	self.curMorale = data.morale  
end

function AcNewYearModel:RefreshIntegral(data) 
	self.integral = data.integral
end

function AcNewYearModel:RefreshRankList(data)
	self.rankList = {}
	for i,v in ipairs(data.list) do
		local rankData = {}
		rankData.rank = v.rank
		rankData.avatar = v.avatar
		rankData.uname = v.uname
		rankData.score = v.score
		rankData.uid = v.uid
		table.insert(self.rankList,rankData)
	end
    self.selfRank = data.self
end

function AcNewYearModel:RefreshRewardCd(data)
	self.dailyAwardCd = data.daily_reward_time
	self.finalAwardCd = data.final_reward_time
end

function AcNewYearModel:ParseRankReward(rankRewardConfig)
	local keysTab = {}
	local zero = nil
	for k,v in pairs(rankRewardConfig.Values) do
		if k == 0 then
		   zero = k
		else
		   table.insert(keysTab,k)
		end
	end
	table.sort(keysTab, function(a,b) return a < b end)
	if zero ~= nil then
	   table.insert(keysTab,zero)
	end

    local rankRewardList = {}
    for k,v in ipairs(keysTab) do
        local config = rankRewardConfig.GetConfig(v)
        --表的一行数据
        local rankRewardData = {}
        rankRewardData.upperLimit = config.upperlimit
        rankRewardData.lowerLimit = config.lowerlimit
        rankRewardData.reward = {}
        --单个奖励字段数据（type、id、num）
        local rewardData = {}
        local dataList = string.split(config.reward,';') 
        for i,j in pairs(dataList) do 
        	local data = string.split(j,',') 
       		rewardData.type = data[1]
        	rewardData.id = data[2]
        	rewardData.num = data[3]
        	table.insert(rankRewardData.reward,rewardData)
        end
        table.insert(rankRewardList,rankRewardData)
    end
    return rankRewardList
end

function AcNewYearModel:ParseDayRankReward()
	self.dayRankRewardList = self:ParseRankReward(DayRankRewardConfig)
end

function AcNewYearModel:ParseFinalRankReward()
    self.finalRankRewardList = self:ParseRankReward(RankRewardConfig)
end

function AcNewYearModel:UpdateBossInfo(bossInfo)
	--print(inspect(bossInfo))
	self.bossInfo = bossInfo
	self.event.UpdateBossInfo:Invoke(self.bossInfo)
end

function AcNewYearModel:IsBossLevelOpen()
    return self.boss_end_time >= DarkBoomUtility.GetServerCrtTime()
end

function AcNewYearModel:GetCurMorale()
    if self:IsBossLevelOpen() then
        return math.ceil(self.curMorale * (self.boss_end_time - DarkBoomUtility.GetServerCrtTime())/(self.boss_end_time - self.boss_start_time))
    end
    return self.curMorale
end

function AcNewYearModel:GetItemConfig(itemId)
  return ItemConfig.GetConfig(itemId)
end

function AcNewYearModel:GetItemInfo(itemId)
	local itemNum = 0
	local config = ItemConfig.GetConfig(itemId)

	if config ~= nil then
		local itemModel = GameEntry.PlayerData.Items:GetItemById(itemId)
		if itemModel ~= nil then
		   itemNum = itemModel.num
		end
	end
	return itemNum
end

return AcNewYearModel