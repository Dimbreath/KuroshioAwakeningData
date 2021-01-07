
local BaseForm = BaseForm
local AcNewYearMoralePayForm = class("AcNewYearMoralePayForm", BaseForm)
local AcNewYearMoralePayItem = require"Modules/Activity/NewYear/MoralePay/AcNewYearMoralePayItem"

function AcNewYearMoralePayForm:LUA_OnInit(gameObject,userParamData)    
	self.injections = ParseInjections(gameObject)
    self.uguiForm   = gameObject:GetComponent(typeof(CS.DarkBoom.LuaUGUIForm))
	self:InjectComponent()
	self:Init()
end

function AcNewYearMoralePayForm:InjectComponent()
    --上方士气值显示部分
    self.MoraleSliderFill = self.injections.MoraleSliderFill
    self.MoraleCurValue = self.injections.MoraleCurValue
    self.MoraleTotalValue = self.injections.MoraleTotalValue
    --中间物资显示item
    self.PrimaryLvMoralePayItem = self.injections.PrimaryLvMoralePayItem
    self.MiddleLvMoralePayItem = self.injections.MiddleLvMoralePayItem
    self.HighLvMoralePayItem = self.injections.HighLvMoralePayItem
    --上缴按钮
    self.PayButton = self.injections.PayButton
    self.PayButtomStyle = self.PayButton.gameObject:GetComponent(typeof(CS.DarkBoom.CommonButtonStyle))
    self.PayText = self.injections.PayText
end

function AcNewYearMoralePayForm:Init()
	self.manager = Game:GetManager("AcNewYearManager")   
    self.model = self.manager:GetModel()
	self.event = self.manager:GetEvent()
    self.primaryLvMoralePayItem = AcNewYearMoralePayItem.new(self.PrimaryLvMoralePayItem)
    self.middleLvMoralePayItem = AcNewYearMoralePayItem.new(self.MiddleLvMoralePayItem)
    self.highLvMoralePayItem = AcNewYearMoralePayItem.new(self.HighLvMoralePayItem)
    self.model.moralePayFormMask = self.uguiForm:GetMask()  
    self.primaryToTurnIn = {["item_id"] = self.model.primaryResItemId,["num"] = self.primaryLvMoralePayItem.CurPayNum}
    self.middleToTurnIn = {["item_id"] = self.model.middleResItemId,["num"] = self.middleLvMoralePayItem.CurPayNum}
    self.highToTurnIn = {["item_id"] = self.model.highResItemId,["num"] = self.highLvMoralePayItem.CurPayNum}
    self.elapseSeconds = 0
    self.isPayNumValid = false
    self:AddListeners()
end

function AcNewYearMoralePayForm:AddListeners()
    self.PayButton.onClick:AddListener(function()
        self:OnPayBtnClick()
    end)
    self.event.MoralePayBtnSateRefresh:AddListener(self.OnMoralePayBtnSateRefresh,self)
    self.event.TurnInResourceFinish:AddListener(self.OnTurnInResourceFinish,self)
    self.event.TurnInResourceError:AddListener(self.OnTurnInResourceError,self)    
end

function AcNewYearMoralePayForm:OnPayBtnClick()
    if self.PayButtonValid then
        local resToturnIn = {}
        if self.primaryLvMoralePayItem.curPayNum > 0 then
            self.primaryToTurnIn["num"] = CS.UnityEngine.Mathf.CeilToInt(self.primaryLvMoralePayItem.curPayNum)
            table.insert(resToturnIn,self.primaryToTurnIn) 
        end
        if self.middleLvMoralePayItem.curPayNum > 0 then
            self.middleToTurnIn["num"] = CS.UnityEngine.Mathf.CeilToInt(self.middleLvMoralePayItem.curPayNum)
            table.insert(resToturnIn,self.middleToTurnIn) 
        end
        if self.highLvMoralePayItem.curPayNum > 0 then
            self.highToTurnIn["num"] = CS.UnityEngine.Mathf.CeilToInt(self.highLvMoralePayItem.curPayNum)
            table.insert(resToturnIn,self.highToTurnIn) 
        end 
        self.manager:ReqTurnInResource(JSON.encode(resToturnIn))
    else
        local msg =''
        if self.model:IsBossLevelOpen() then
           msg = DarkBoom.GameEntry.Localization:GetString("newyear_tips") --BOSS出现期间无法进行上缴
        else
           msg = DarkBoom.GameEntry.Localization:GetString("NewYear_turnin_tips_01") --请先选择需要上缴的物资           
        end
        DarkBoom.GameEntry.UI:OpenMsgTipsUIForm(msg,CS.DarkBoom.SoundEffectType.Tips)
    end
end

function AcNewYearMoralePayForm:LUA_OnOpen(userData)
    self:RefreshMoraleUI()
    self.PayButtonValid = true
    self:SetPayButtonState(false)
    self.primaryLvMoralePayItem:UpdateItem(self.model.primaryResItemId)
    self.middleLvMoralePayItem:UpdateItem(self.model.middleResItemId)
    self.highLvMoralePayItem:UpdateItem(self.model.highResItemId)
    DarkBoomUtility.ToBlur(self.uguiForm.UIForm)
end

function AcNewYearMoralePayForm:SetPayButtonState(valid)
    if self.PayButtonValid == valid then
        return 
    end
    if valid then
        self.PayButtomStyle:SetButtonColor(DarkBoom.ECommonButtonColor.DarkBlue)
        self.PayText.color = DarkBoomUtility.HexToColor("FFFFFFFF")
    else
        self.PayButtomStyle:SetButtonColor(DarkBoom.ECommonButtonColor.Gray)
        self.PayText.color = DarkBoomUtility.HexToColor("FFFEFE33")
    end    
    self.PayButtonValid = valid
end

function AcNewYearMoralePayForm:RefreshMoraleUI()
    local morale = tonumber(self.model.curMorale)
    if morale >= self.model.maxMorale then
       morale = self.model.maxMorale
       self.manager:ReqNewYearInfo()
    end
    self.MoraleSliderFill.transform.localScale = Vector3(morale/self.model.maxMorale,1,1)
    self.MoraleCurValue.text = morale
    self.MoraleTotalValue.text = '/'..self.model.maxMorale
end

function AcNewYearMoralePayForm:OnTurnInResourceFinish(serverdata)
    --刷新士气、上缴数量
    self:RefreshMoraleUI()
    self.primaryLvMoralePayItem:ResetItem()
    self.middleLvMoralePayItem:ResetItem()
    self.highLvMoralePayItem:ResetItem()
    --显示奖励
    DarkBoomUtility.ShowRewardUIForm(serverdata.user)
end

function AcNewYearMoralePayForm:OnTurnInResourceError(str1,str2)
    self.manager:ReqNewYearInfo()
    self.uguiForm:OnCloseForm()
end

function AcNewYearMoralePayForm:OnMoralePayBtnSateRefresh()
    if self.primaryLvMoralePayItem.curPayNum == 0 and self.middleLvMoralePayItem.curPayNum == 0 and self.highLvMoralePayItem.curPayNum == 0 then
        self.isPayNumValid = false        
    else
        self.isPayNumValid = true        
    end    
    if not self.isPayNumValid or self.model:IsBossLevelOpen() then
       self:SetPayButtonState(false)
    else       
       self:SetPayButtonState(true)
    end
end

function AcNewYearMoralePayForm:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
    self.elapseSeconds = self.elapseSeconds + elapseSeconds  
    if self.elapseSeconds > 1 then
        self.elapseSeconds = 0
        if self.model:IsBossLevelOpen() and self.PayButtonValid then
           self:SetPayButtonState(false)
        end
    end
    self.primaryLvMoralePayItem:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
    self.middleLvMoralePayItem:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
    self.highLvMoralePayItem:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
end

function AcNewYearMoralePayForm:RemoveListeners()
    self.PayButton.onClick:RemoveAllListeners()
    self.PayButton.onClick:Invoke()
    self.event.MoralePayBtnSateRefresh:RemoveListener(self.OnMoralePayBtnSateRefresh,self)
    self.event.TurnInResourceFinish:RemoveListener(self.OnTurnInResourceFinish,self)
    self.event.TurnInResourceError:RemoveListener(self.OnTurnInResourceError,self) 
end

function AcNewYearMoralePayForm:LUA_OnClose()
    DarkBoomUtility.RegainBlur(self.uguiForm.UIForm)

    self.primaryLvMoralePayItem:OnRelease()
    self.middleLvMoralePayItem:OnRelease() 
    self.highLvMoralePayItem:OnRelease()

    self.injections = {}
    self.injections = nil
    self.primaryToTurnIn = {}
    self.primaryToTurnIn = nil
    self.middleToTurnIn = {}
    self.middleToTurnIn = nil
    self.highToTurnIn = {}
    self.highToTurnIn = nil
    self.uguiForm = nil

    self:RemoveListeners()

    self.MoraleSliderFill = nil
    self.MoraleCurValue = nil
    self.MoraleTotalValue = nil
    self.PrimaryLvMoralePayItem = nil
    self.MiddleLvMoralePayItem = nil
    self.HighLvMoralePayItem = nil
    self.PayButton = nil
    self.PayButtomStyle = nil
    self.PayText = nil

    self.manager = nil
    self.model = nil
    self.event = nil
end

return AcNewYearMoralePayForm
