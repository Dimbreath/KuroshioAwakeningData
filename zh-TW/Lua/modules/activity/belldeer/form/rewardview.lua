local RewardView = class("RewardView")
local RewardItem = require "Modules/Activity/BellDeer/Form/RewardItem"

function RewardView:ctor(gameObject)
    self.gameObject = gameObject
    self.manager = Game:GetManager("BellDeerManager")
    self.model = self.manager:GetModel()
    self.event = self.manager:GetEvent()
    self.injections = ParseInjections(gameObject)
    self:InjectComponent()
    self:Init()
end

function RewardView:InjectComponent()
    self.RewardItem11 = self.injections.RewardItem11
    self.RewardItem12 = self.injections.RewardItem12
    self.RewardItem13 = self.injections.RewardItem13
    self.RewardItem14 = self.injections.RewardItem14
    self.RewardItem21 = self.injections.RewardItem21
    self.RewardItem22 = self.injections.RewardItem22
    self.RewardItem23 = self.injections.RewardItem23
    self.RewardItem24 = self.injections.RewardItem24
end

function RewardView:Init()
    self:AddListeners()
    self.rewardItemList = {}
    self.rewardItemList["11"] = RewardItem.new(self.RewardItem11, 1, 1)
    self.rewardItemList["12"] = RewardItem.new(self.RewardItem12, 1, 2)
    self.rewardItemList["13"] = RewardItem.new(self.RewardItem13, 1, 3)
    self.rewardItemList["14"] = RewardItem.new(self.RewardItem14, 1, 4)
    self.rewardItemList["21"] = RewardItem.new(self.RewardItem21, 2, 1)
    self.rewardItemList["22"] = RewardItem.new(self.RewardItem22, 2, 2)
    self.rewardItemList["23"] = RewardItem.new(self.RewardItem23, 2, 3)
    self.rewardItemList["24"] = RewardItem.new(self.RewardItem24, 2, 4)

end

function RewardView:RefreshUI(plotId, id)
    local key = tostring(plotId) .. id
    self.rewardItemList[key]:RefreshUI()
end

function RewardView:RefreshAll()
    for i, v in pairs(self.rewardItemList) do
        v:RefreshUI()
    end
end

function RewardView:AddListeners()
    self.event.BellDeerGetRewardEvent:AddListener(self.RefreshUI, self)
    self.event.BellDeerUpdateRewardEvent:AddListener(self.RefreshAll, self)
end

function RewardView:RemoveListeners()
    self.event.BellDeerUpdateRewardEvent:RemoveListener(self.RefreshAll, self)
    self.event.BellDeerGetRewardEvent:RemoveListener(self.RefreshUI, self)
end

function RewardView:IsEnd()
    return self.gridId == self.maxGrid
end

function RewardView:IsStart()
    return self.gridId == 1
end

function RewardView:GetGameObject()
    return self.gameObject
end

function RewardView:SetActive(active)
    self.gameObject:SetActive(active)
end

function RewardView:OnRelease()
    self:RemoveListeners()
    for i, v in pairs(self.rewardItemList) do
        v:OnRelease()
    end
    self.rewardItemList = nil
end

return RewardView
