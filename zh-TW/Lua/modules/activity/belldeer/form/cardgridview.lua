local CardGridView = class("CardGridView")

local CardItem = require "Modules/Activity/BellDeer/Form/CardItem"

function CardGridView:ctor(gameObject)
    self.gameObject = gameObject
    self.manager = Game:GetManager("BellDeerManager")
    self.model = self.manager:GetModel()
    self.event = self.manager:GetEvent()
    self.injections = ParseInjections(gameObject)
    self:InjectComponent()
    self:Init()
    self.cardStatus = {Opened = 1, Covered = 2, Extra = 3}
end

function CardGridView:InjectComponent()
    self.CardItemTemplate = self.injections.CardItemTemplate
end

function CardGridView:LUA_OnUpdate(elapseSeconds, realElapseSeconds)
    if self.timers ~= nil and #self.timers ~= 0 then
        for i = #self.timers, 1, -1 do
            self.timers[i].time = self.timers[i].time - elapseSeconds
            if self.timers[i].time <= 0 then
                self.timers[i].func(self, self.timers[i].data)
                table.remove(self.timers, i)
            end
        end
    end
end

function CardGridView:AddListeners()
    self.event.BellDeerUpdateGridEvent:AddListener(self.OnUpdateCardGridView, self)
    self.event.BellDeerGetRewardEvent:AddListener(self.OnUpdateBG, self)
end

function CardGridView:RemoveListeners()
    self.event.BellDeerUpdateGridEvent:RemoveListener(self.OnUpdateCardGridView, self)
    self.event.BellDeerGetRewardEvent:RemoveListener(self.OnUpdateBG, self)
end

function CardGridView:Init()
    local hasReceived = self.model:HasReceivedFinalReward()
    self.cardList = {}
    for i, v in pairs(self.model.cardList) do
        --print_log(i)
        local CardItemTemplate = GameObject.Instantiate(self.CardItemTemplate.gameObject, self.gameObject.transform)
        CardItemTemplate.name = tostring(i)
        CardItemTemplate.gameObject:SetActive(true)
        local cardItem = CardItem.new(CardItemTemplate, i, v.type, v.status)
        if not hasReceived then
            local rewardId = string.split(v.reward, ",")[2]
            local rewardNum = string.split(v.reward, ",")[3]
            local rewardConfig = self.model:GetItemConfig(tonumber(rewardId))
            cardItem:LoadSprites(rewardConfig.icon, rewardNum, self.model:GetItemQuality(tonumber(rewardId)))
        else
            cardItem:LoadSprites()
        end
        table.insert(self.cardList, cardItem)
    end
    self.timers = {}
    self:AddListeners()
end

function CardGridView:OnUpdateBG()
    for i, v in pairs(self.cardList) do
        v:UpdateBg()
        v:RefreshUI()
    end
end

function CardGridView:ClearReward()
    for i, v in pairs(self.cardList) do
        v:ClearReward()
    end
end

function CardGridView:OnUpdateCardGridView(data, user)
    local newData = data.map.mapInfo
    for i, v in pairs(self.model.cardList) do
        local newStatus = newData[tostring(i)].status
        local card = self.cardList[i]
        if newStatus ~= v.status then
            card:UpdateBg()
            if newStatus == self.cardStatus.Opened then
                card:PlayAnim()
                table.insert(self.timers, {["time"] = 0.7, ["func"] = self.RefreshCardUI, ["data"] = {card, newStatus}})
            elseif newStatus == self.cardStatus.Covered then
                card:PlayAnimReversed()
                table.insert(self.timers, {["time"] = 0.7, ["func"] = self.RefreshCardUI, ["data"] = {card, newStatus}})
            else
                card:UpdateBg()
                card:RefreshUI(newStatus)
            end
        end
    end
    table.insert(self.timers, {["time"] = 0.6, ["func"] = self.ShowReward, ["data"] = user})

    self.model:UpdateGridData(data)
    self.event.BellDeerUpdateRewardEvent:Invoke()
end

function CardGridView:RefreshCardUI(data)
    data[1]:UpdateBg()
    data[1]:RefreshUI(data[2])
end

function CardGridView:ShowReward(user)
    DarkBoomUtility.ShowRewardUIForm(user)
end

function CardGridView:GetGameObject()
    return self.gameObject
end

function CardGridView:SetActive(active)
    self.gameObject:SetActive(active)
end

function CardGridView:OnRelease()
    self:RemoveListeners()
    for i, v in pairs(self.cardList) do
        v:OnRelease()
    end
    self.cardList = nil
    self.timers = nil
end

return CardGridView
