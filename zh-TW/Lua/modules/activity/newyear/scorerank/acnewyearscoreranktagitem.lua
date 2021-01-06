local AcNewYearScoreRankTagItem  = class("AcNewYearScoreRankTagItem")

function AcNewYearScoreRankTagItem:ctor(gameObject)
    if IsGameObjectNull(gameObject) then
       print_error("gameObject == nil")
       return
    end

    self.injections = ParseInjections(gameObject)
    self.gameObject = gameObject
    self:InjectComponent()
    self:AddListeners()
end

function AcNewYearScoreRankTagItem:InjectComponent()
    self.Icon = self.injections.Icon
    self.Name = self.injections.Name
    self.SelectedEffect = self.injections.SelectedEffect
    self.Btn = self.injections.Btn
end

function AcNewYearScoreRankTagItem:Init(btnClickFuc)
    self.BtnClick = btnClickFuc
end

function AcNewYearScoreRankTagItem:AddListeners()
    self.Btn.onClick:AddListener(function()
        self:OnBtnClick()
    end)
end

function AcNewYearScoreRankTagItem:OnBtnClick()
    self.BtnClick()
end

function AcNewYearScoreRankTagItem:UpdateSelectEffect(isSelected)
    if isSelected then
       self.Icon.color = Color(1,1,1,1)
       self.Name.color = Color(1,1,1,1)  
       self.SelectedEffect.gameObject:SetActive(true)
    else
       self.Icon.color = Color(1,1,1,0.5)  
       self.Name.color = Color(1,1,1,0.5) 
       self.SelectedEffect.gameObject:SetActive(false)
    end
end

function AcNewYearScoreRankTagItem:RemoveListeners()
    self.Btn.onClick:RemoveAllListeners()
    self.Btn.onClick:Invoke()
end

function AcNewYearScoreRankTagItem:OnRelease()
    self.injections = {}
    self.injections = nil

    self:RemoveListeners()

    self.gameObject = nil
    self.Icon = nil
    self.Name = nil
    self.SelectedEffect = nil
    self.Btn = nil
end

return AcNewYearScoreRankTagItem
