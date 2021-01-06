local CardItem = class("CardItem")

function CardItem:ctor(gameObject, cardId, type, status)
    if IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end
    self.cardId = cardId
    self.type = type
    self.status = status
    self.injections = ParseInjections(gameObject)
    self.gameObject = gameObject
    self:InjectComponent()
    self:Init()
end

function CardItem:InjectComponent()
    self.CardBtn = self.injections.CardBtn
    self.MaskImg = self.injections.MaskImg
    self.RewardImg = self.injections.RewardImg
    self.RewardGO = self.injections.RewardGO
    self.RewardNumTxt = self.injections.RewardNumTxt
    self.BgImg = self.injections.BgImg
    self.GoldBgImg = self.injections.GoldBgImg
    self.ReveivedTxt = self.injections.ReveivedTxt
    self.DoubleImg = self.injections.DoubleImg
    self.LeftRightImg = self.injections.LeftRightImg
    self.UpDownImg = self.injections.UpDownImg
    self.QualityImg = self.injections.QualityImg
    self.CardAnim = self.injections.CardAnim
end

function CardItem:Init()
    self.cardStatus = {
        Opened = 1,
        Covered = 2,
        Extra = 3
    }

    self.cardType = {
        Normal = 1,
        Double = 2,
        LeftRight = 3,
        UpDown = 4
    }

    self.manager = Game:GetManager("BellDeerManager")
    self.model = self.manager:GetModel()
    self.event = self.manager:GetEvent()
    self.CardBtn.onClick:AddListener(
        function()
            self:OnBtnClick()
        end
    )
    self:InitUI()
end

function CardItem:InitUI()
    self.RewardImg.gameObject:SetActive(false)
    self:UpdateBg()
    self:RefreshUI()
    if self.model:HasReceivedFinalReward() then
        self.RewardGO.gameObject:SetActive(false)
    end
end

function CardItem:UpdateBg()
    if self.model:ShouldBeGold(self.cardId) then
        self.CurBg = self.GoldBgImg
        self.GoldBgImg.gameObject:SetActive(true)
        self.BgImg.gameObject:SetActive(false)
    else
        self.CurBg = self.BgImg
        self.GoldBgImg.gameObject:SetActive(false)
        self.BgImg.gameObject:SetActive(true)
    end
end

function CardItem:OnBtnClick()
    local data = self.model.cardList[self.cardId]
    --print_log(data.status)
    if data.status ~= self.cardStatus.Opened then
        self.manager:FlipCard(self.cardId)
    else
        --print_log("已经翻开了")
    end
end

function CardItem:PlayAnim()
    for key, value in pairs(self.CardAnim) do
        value.time = 0
        value.speed = 1
    end
    self.CardAnim:Play("Activity_christmas_card_01")
end

function CardItem:PlayAnimReversed()
    for key, value in pairs(self.CardAnim) do
        value.time = self.CardAnim.clip.length
        value.speed = -1
    end
    self.CardAnim:Play("Activity_christmas_card_01")
end

function CardItem:RefreshUI(status)
    if status ~= nil then
        self.status = status
    end
    --print_log(self.cardId, self.status)
    if self.status == self.cardStatus.Opened then
        self.CurBg.gameObject:SetActive(true)
        self.RewardGO.gameObject:SetActive(true)
        self.MaskImg.gameObject:SetActive(false)
        self.ReveivedTxt.gameObject:SetActive(true)
        self.DoubleImg.gameObject:SetActive(false)
    elseif self.status == self.cardStatus.Covered then
        self.CurBg.gameObject:SetActive(false)
        self.MaskImg.gameObject:SetActive(true)
        self.RewardGO.gameObject:SetActive(false)
        self.ReveivedTxt.gameObject:SetActive(false)
        self.DoubleImg.gameObject:SetActive(false)
    else
        self.CurBg.gameObject:SetActive(false)
        self.MaskImg.gameObject:SetActive(true)
        self.RewardGO.gameObject:SetActive(true)
        self.ReveivedTxt.gameObject:SetActive(false)
        self.DoubleImg.gameObject:SetActive(true)
    end
end

function CardItem:ClearReward()
    self.RewardGO.gameObject:SetActive(false)
end

function CardItem:LoadSprites(rewardItem, rewardNum, rewardQuality)
    local goldBgPath =
        string.format("Assets/GameMain/UI/UISprites/Christmas/%s.png", "merrychristmas_1_puzzles_cp_" .. self.cardId)
    LuaBridge.LoadAysnc4Lua(
        goldBgPath,
        typeof(CS.UnityEngine.Sprite),
        function(assetName, asset, userData)
            self.GoldBgImg.sprite = asset
        end,
        self.model.resMask
    )
    if rewardItem ~= nil then
        local itemPath = string.format("Assets/GameMain/UI/UIImages/Icons/%s.png", rewardItem)
        LuaBridge.LoadAysnc4Lua(
            itemPath,
            typeof(CS.UnityEngine.Sprite),
            function(assetName, asset, userData)
                self.RewardImg.sprite = asset
                self.RewardNumTxt.text = rewardNum
                self.RewardImg.gameObject:SetActive(true)
            end,
            self.model.resMask
        )
        local bgPath =
            string.format(
            "Assets/GameMain/UI/UISprites/Christmas/%s.png",
            "merrychristmas_1_puzzles_bg_" .. self.cardId
        )
        local maskPath =
            string.format(
            "Assets/GameMain/UI/UISprites/Christmas/%s.png",
            "merrychristmas_1_puzzles_mask_" .. self.cardId
        )
        LuaBridge.LoadAysnc4Lua(
            bgPath,
            typeof(CS.UnityEngine.Sprite),
            function(assetName, asset, userData)
                self.BgImg.sprite = asset
            end,
            self.model.resMask
        )

        LuaBridge.LoadAysnc4Lua(
            maskPath,
            typeof(CS.UnityEngine.Sprite),
            function(assetName, asset, userData)
                self.MaskImg.sprite = asset
            end,
            self.model.resMask
        )
    end
end

function CardItem:OnRelease()
    self.CardBtn.onClick:RemoveAllListeners()
    self.CardBtn.onClick:Invoke()
end

return CardItem
