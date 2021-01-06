local MainUIView = class("MainUIView")

function MainUIView:ctor(gameObject)
    self.gameObject = gameObject
    self.manager = Game:GetManager("BellDeerManager")
    self.model = self.manager:GetModel()
    self.event = self.manager:GetEvent()
    self.injections = ParseInjections(gameObject)
    self:InjectComponent()
    self:Init()
    self.dollClickable = true
end

function MainUIView:InjectComponent()
    self.DescTxt = self.injections.DescTxt
    self.TimeTxt = self.injections.TimeTxt
    self.FinalRewardBtn = self.injections.FinalRewardBtn
    self.FinalRewardTxt = self.injections.FinalRewardTxt
    self.FinalRewardImg = self.injections.FinalRewardImg
    self.DollTxt = self.injections.DollTxt
    self.DollSkeleton = self.injections.DollSkeleton
    self.DollBtn = self.injections.DollBtn
end

function MainUIView:Init()
    local start, endT = self.model:GetActivityDuration()
    self.TimeTxt.text = start .. " - " .. endT
    self.DescTxt.text = self.model:GetDescription()
    self.FinalRewardBtn.onClick:AddListener(
        function()
            self:OnGetRewardClick()
        end
    )
    self.DollBtn.onClick:AddListener(
        function()
            self:OnDollClick()
        end
    )
    self:LoadDoll()
    self:AddListeners()
    self.timers = {}
end

function MainUIView:LUA_OnUpdate(elapseSeconds, realElapseSeconds)
    if self.timers ~= nil and #self.timers ~= 0 then
        for i = #self.timers, 1, -1 do
            self.timers[i].time = self.timers[i].time - elapseSeconds
            if self.timers[i].time <= 0 then
                self.timers[i].func(self)
                table.remove(self.timers, i)
            end
        end
    end
end

function MainUIView:RefreshUI()
    if self.model:HasReceivedFinalReward() then
        self.FinalRewardTxt.text = self.model:GetTextFromDefaut("activity_merrychristmas_13")
        self.FinalRewardImg.gameObject:SetActive(true)
        self:LoadDoll()
    else
        if self.model:HasAllReceived() then
            self.FinalRewardTxt.text = self.model:GetTextFromDefaut("activity_new_text_04")
            self.FinalRewardImg.gameObject:SetActive(true)
        else
            self.FinalRewardTxt.text = self.model:GetFinalRewardTipsText()
            self.FinalRewardImg.gameObject:SetActive(false)
        end
    end
    self.DollTxt.text = self.model:GetDollText()
end

function MainUIView:AddListeners()
    self.event.BellDeerGetRewardEvent:AddListener(self.RefreshUI, self)
end

function MainUIView:RemoveListeners()
    self.event.BellDeerGetRewardEvent:RemoveListener(self.RefreshUI, self)
end

function MainUIView:OnGetRewardClick()
    if self.model:HasAllReceived() then
        self.manager:GetFinalReward()
    else
        --print_log("还没有全部翻完")
    end
end

function MainUIView:OnDollClick()
    if (self.dollClickable) then
        self.DollTxt.text = self.model:GetDollText()
        self:PlayAnim("victory", false)
        self.dollClickable = false
        table.insert(self.timers, {["time"] =1.3, ["func"] = self.PlayStand})
    end
end

function MainUIView:PlayStand()
    self:PlayAnim("stand", true)
    self.dollClickable = true
end

function MainUIView:LoadDoll()
    local function loadComplete(assetName, asset, userData)
        print(assetName)
        self.DollSkeleton.skeletonDataAsset = asset
        self:PlayAnim("stand", true)
    end

    local path = self.model:GetSpineAssetPath()

    if path == "" then
        return
    end

    LuaBridge.LoadAysnc4Lua(path, typeof(CS.Spine.Unity.SkeletonDataAsset), loadComplete, self.model.resMask)
end

function MainUIView:PlayAnim(name, loop)
    if self.DollSkeleton == nil then
        return
    end

    self.DollSkeleton:Initialize(true)
    self.DollSkeleton.AnimationState:SetAnimation(0, name, loop)
end

function MainUIView:GetGameObject()
    return self.gameObject
end

function MainUIView:SetActive(active)
    self.gameObject:SetActive(active)
end

function MainUIView:OnRelease()
    self:RemoveListeners()
    self.FinalRewardBtn.onClick:RemoveAllListeners()
    self.FinalRewardBtn.onClick:Invoke()
    self.DollBtn.onClick:RemoveAllListeners()
    self.DollBtn.onClick:Invoke()
    self.timers = nil
end

return MainUIView
