local RewardItem = class("RewardItem")

function RewardItem:ctor(gameObject, plotId, id)
    if IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end
    self.plotId = plotId
    self.id = id
    self.injections = ParseInjections(gameObject)
    self.gameObject = gameObject
    self:InjectComponent()
    self:Init()
end

function RewardItem:InjectComponent()
    self.RewardBtn = self.injections.RewardBtn
    self.StateTxt = self.injections.StateTxt
    self.BgImg = self.injections.BgImg
    self.GoldBgImg = self.injections.GoldBgImg
    self.GiftImg = self.injections.GiftImg
    self.GiftOpenedImg = self.injections.GiftOpenedImg
    self.LightImg = self.injections.LightImg
end

function RewardItem:Init()
    self.manager = Game:GetManager("BellDeerManager")
    self.model = self.manager:GetModel()
    self.event = self.manager:GetEvent()
    self.GiftAnimation = self.GiftImg.gameObject:GetComponent("Animation")
    --self.SetIcon()
    self:RefreshUI()
    self.RewardBtn.onClick:AddListener(
        function()
            self:OnRewardBtnClick()
        end
    )
end

function RewardItem:OnRewardBtnClick()
    if not self.model:HasRewardReceived(self.plotId, self.id) then
        if self.model:HasCompleted(self.plotId, self.id) then
            self.manager:GetReward(self.plotId, self.id)
        else
            --print_log("还没翻完")
        end
    else
        --print_log("已经获取了")
    end
end

function RewardItem:RefreshUI()
    if self.model:HasRewardReceived(self.plotId, self.id) then
        self.StateTxt.text = self.model:GetTextFromDefaut("activity_merrychristmas_13")
        self.GiftImg.gameObject:SetActive(false)
        self.GiftOpenedImg.gameObject:SetActive(true)
        self.GoldBgImg.gameObject:SetActive(true)
        self.BgImg.gameObject:SetActive(false)
        self.LightImg.gameObject:SetActive(true)
    else
        self.GiftImg.gameObject:SetActive(true)
        self.GiftOpenedImg.gameObject:SetActive(false)
        if self.model:HasCompleted(self.plotId, self.id) then
            self.StateTxt.text = self.model:GetTextFromDefaut("activity_merrychristmas_15")
            self.GoldBgImg.gameObject:SetActive(true)
            self.BgImg.gameObject:SetActive(false)
            self.GiftAnimation:Play("Activity_christmas_card_03")
        else
            self.GiftImg.gameObject:SetActive(true)
            self.GiftOpenedImg.gameObject:SetActive(false)
            self.GiftAnimation:Stop("Activity_christmas_card_03")
            self.GoldBgImg.gameObject:SetActive(false)
            self.BgImg.gameObject:SetActive(true)
            if self.plotId == 1 then
                self.StateTxt.text = self.model:GetTextFromDefaut("activity_merrychristmas_17")
            else
                self.StateTxt.text = self.model:GetTextFromDefaut("activity_merrychristmas_16")
            end
        end
    end
end

function RewardItem:OnRelease()
    self.RewardBtn.onClick:RemoveAllListeners()
    self.RewardBtn.onClick:Invoke()
end

return RewardItem
