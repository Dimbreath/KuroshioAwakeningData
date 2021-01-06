local ActivityBellDeerEntry = class("ActivityBellDeerEntry")

function ActivityBellDeerEntry:OnInit(gameObject, mask)
    self.mask = mask
    self.gameObject = gameObject
    self.injections = ParseInjections(gameObject)
    self:InjectComponent()
    self:Init(mask)
end

function ActivityBellDeerEntry:InjectComponent()
    self.ActContent = self.injections.ActContent
    self.Time = self.injections.Time
    self.BtnGo = self.injections.BtnGo
    self.BtnRedPoint = self.injections.RedPoint
end

function ActivityBellDeerEntry:Init(mask)
    self.manager = Game:GetManager("BellDeerManager")
    self.model = self.manager:GetModel()
    self.event = self.manager:GetEvent()
    self.model.resMask = mask
    self.BtnGo.onClick:AddListener(
        function()
            if self.model:IsActivityInTime() and self.model.inited then
                if not self.model:HasReceivedFinalReward() then
                    self.model:PlayStory(
                        "merrychristmas_story_start",
                        function()
                            LuaBridge.OpenUIForm(5540)
                        end
                    )
                else
                    LuaBridge.OpenUIForm(5540)
                end
            else
                GameEntry.UI:OpenMsgTipsUIForm(self.model:GetTextFromDefaut("tips_source_activity"))
            end
        end
    )
    self:AddListeners()
end

function ActivityBellDeerEntry:AddListeners()
    self.event.BellDeerInfoEvent:AddListener(self.OnGetActivityInfo, self)
end

function ActivityBellDeerEntry:RemoveListeners()
    self.event.BellDeerInfoEvent:RemoveListener(self.OnGetActivityInfo, self)
end

function ActivityBellDeerEntry:OnGetActivityInfo()
    local redPoint = self.manager:HaveRedPoint()
    self.BtnRedPoint.gameObject:SetActive(redPoint)
end

function ActivityBellDeerEntry:OnOpen(tagId)
    self.tagId = tagId
    self.model.tagId = tagId
    if self.model:IsActivityInTime() then
        self.manager:GetBellDeerActivityInfo()
    end
    self.ActContent.text = GetDefaultText("activity_merrychristmas_09")
    self.Time.text = GetDefaultText("coinexchange_dec_1") .. CS.DarkBoom.LuaActivityBridge.GetActivityTime(tagId)
end

function ActivityBellDeerEntry:RefreshUI()
end

function ActivityBellDeerEntry:OnRelease()
    self:RemoveListeners()
    self.BtnGo.onClick:RemoveAllListeners()
    self.BtnGo.onClick:Invoke()

    self.injections = {}
    self.injections = nil
    self.gameObject = nil
    self.manager = nil
    self.model = nil
    self.event = nil
end

function ActivityBellDeerEntry:SetActive(show)
    self.gameObject:SetActive(show)
end

return ActivityBellDeerEntry
