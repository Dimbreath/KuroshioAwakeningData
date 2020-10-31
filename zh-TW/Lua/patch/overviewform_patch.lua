local util = require 'xluautil'

local DarkBoom = CS.DarkBoom
local GameEntry = DarkBoom.GameEntry
local LoginModel = DarkBoom.LoginModel
local LoginDataMgr = DarkBoom.LoginDataMgr
local Animation = CS.UnityEngine.Animation
local IOverview = DarkBoom.IOverview
local GlobalConfigList = CS.Config.GlobalConfigList
local DOVirtual = CS.DG.Tweening.DOVirtual

xlua.private_accessible(DarkBoom.OverviewForm)

xlua.hotfix(DarkBoom.OverviewForm, 'OnLeftClick',
function(self, go)
    if (self.curAnimPlayInterval > 0) then
        return;
    end

    self.curAnimPlayInterval = self.animPlayInterval;

    local anim2 = self._standView:GetComponent(typeof(Animation));
    if (self.animNode.isPlaying)then
    
        self.animNode["overview_uishow"].time = 0;
        self.animNode.Play("overview_uishow");

        local iOverview = self._infoView:GetComponent(typeof(IOverview));
        iOverview:PlayEnterFx();

        _standView:GetComponent(typeof(IOverview)).PlayEnterFx(1);

        self:OnLeftAnimComplete();
    else
        self.animNode:Play("overview_uihide");
        self.animNode:PlayQueued("overview_uishow");

        local dForm = DarkBoom.UIExtension.GetUIForm(GameEntry.UI, DarkBoom.UIFormId.DockForm);

        local iOverview = self._infoView:GetComponent(typeof(IOverview));

        --string GetHashCode Lua调用不了
        --local str = CS.System.String('s');
        --str = 'boatstar_limit';
        --printerror(str:GetHashCode());

        --读表GlobalConfig
        local starLimit = GlobalConfigList.getInst():GetDic()[565829836];

        local tempIndex = dForm.curIndex - 1;
        if (tempIndex < 0) then
            tempIndex = dForm.ShowList.Count - 1;
        end

        self._standView:GetComponent(typeof(IOverview)):PlayExitThenEnter(1);

        --local time = 0.19;

        --延迟之后 self不知道指到哪里了
        --DOVirtual:DelayedCall(time, self.OnLeftAnimComplete);

        local func = function() 
            local of = DarkBoom.UIExtension.GetUIForm(GameEntry.UI, DarkBoom.UIFormId.OverviewForm)
            of:OnLeftAnimComplete()
        end

        DOVirtual.DelayedCall(0.2, func)
        --CS.MovementEffects.Timing.CallDelayed(time, func)
    end
end)

xlua.hotfix(DarkBoom.OverviewForm, 'OnRightClick',
function(self, go)
    if (self.curAnimPlayInterval > 0) then
        return;
    end

    self.curAnimPlayInterval = self.animPlayInterval;

    local anim2 = self._standView:GetComponent(typeof(Animation));
    if (self.animNode.isPlaying)then
    
        self.animNode["overview_uishow"].time = 0;
        self.animNode.Play("overview_uishow");

        local iOverview = self._infoView:GetComponent(typeof(IOverview));
        iOverview:PlayEnterFx();

        _standView:GetComponent(typeof(IOverview)).PlayEnterFx(2);

        self:OnLeftAnimComplete();
    else
        self.animNode:Play("overview_uihide");
        self.animNode:PlayQueued("overview_uishow");

        local dForm = DarkBoom.UIExtension.GetUIForm(GameEntry.UI, DarkBoom.UIFormId.DockForm);

        local iOverview = self._infoView:GetComponent(typeof(IOverview));
        local starLimit = GlobalConfigList.getInst():GetDic()[565829836];

        local tempIndex = dForm.curIndex + 1;
        if (tempIndex >= dForm.ShowList.Count) then
            tempIndex = 0;
        end

        self._standView:GetComponent(typeof(IOverview)):PlayExitThenEnter(2);

        --local time = 0.19;

        local func = function() 
            local of = DarkBoom.UIExtension.GetUIForm(GameEntry.UI, DarkBoom.UIFormId.OverviewForm)
            of:OnRightAnimComplete()
        end

        DOVirtual.DelayedCall(0.2, func)
        --CS.MovementEffects.Timing.CallDelayed(time, func)
    end
end)