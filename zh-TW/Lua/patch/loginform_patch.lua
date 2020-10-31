local util = require 'xluautil'

local DarkBoom = CS.DarkBoom
local GameEntry = DarkBoom.GameEntry
local PlayerPrefs = CS.UnityEngine.PlayerPrefs
local GameFrameworkLog = CS.GameFramework.GameFrameworkLog
local PrefabLoadSingleton = DarkBoom.PrefabLoadUtility.GetInstance()
local AssetUtility = DarkBoom.AssetUtility


--xlua.private_accessible(DarkBoom.LoginForm)

xlua.hotfix(DarkBoom.LoginForm, 'OnInit',
function(self, userData)
    base(self):OnInit(userData)

    self.m_loginSDKPage:OnInit(userData)

    self.m_loginSDKPage.RealEnterGame = function()
        GameEntry.UI:OpenMsgTipsUIForm('这是热补丁先执行原函数：：', DarkBoom.SoundEffectType.Tips)
        self:RealEnterGame() 
    end
    
    self.m_loginServerPage:OnInit(userData)

    if (PrefabLoadSingleton:HasPrefab(AssetUtility.GetUIFormAsset("LoginForm"))) then
        PrefabLoadSingleton:UnLoadPrefab(AssetUtility.GetUIFormAsset("LoginForm"))
    end

    printerror('LoginForm.OnInit patch over')
end)

xlua.hotfix(DarkBoom.LoginForm, "OnOpen",
function(self, userData)
    base(self):OnOpen(userData)
    self.procedureLogin = userData
    if self.procedureLogin == nil then
        printerror('ProcedureMenu is invalid when open MenuForm.')
    end
    self:SubscribeEvent()
    self.m_loginSDKPage:OnOpen()
    self:ShowLoginOrServer(true)
    printerror('LoginForm.OnOpen patch over')
end)

xlua.hotfix(DarkBoom.LoginForm, "OnClose",
function(self, userData)
    self:UnSubscribeEvent()
    self.m_loginSDKPage:OnClose()
    self.procedureLogin = nil
    base(self):OnClose(userData)
    printerror('LoginForm.OnClose patch over')
end)


-- xlua.hotfix(DarkBoom.LoginForm, "SubscribeEvent",
-- function(self)
--     GameEntry.Event:Subscribe(DarkBoom.ShowServerListEventArgs.EventId, xxx)
--     printerror('LoginForm.SubscribeEvent patch over')
-- end)

-- xlua.hotfix(DarkBoom.LoginForm, "UnSubscribeEvent",
-- function(self)
--     GameEntry.Event:Unsubscribe(DarkBoom.ShowServerListEventArgs.EventId, xxx)
--     printerror('LoginForm.UnSubscribeEvent patch over')
-- end)

xlua.hotfix(DarkBoom.LoginForm, "RefreshLogin",
function(self, sender_, eventargs_)
    self:ShowLoginOrServer(not eventargs_.show)
    printerror('LoginForm.RefreshLogin patch over')
end)

xlua.hotfix(DarkBoom.LoginForm, "RealEnterGame",
function(self)
    self.procedureLogin:StartGame()

    local d = DarkBoom.LoginDataMgr.GetInstance().LoginModel
    local sws = string.format("ws://%s", d.socket_dns)
    GameEntry.WebSocket:ConnectMainWebSocket(sws, 
        function(arg) 
            local rms = DarkBoom.WSRegisterMessageSend(1, 3)
            GameEntry.WebSocket:SendMainWebSocket("register", rms, function() end)
        end)

    printerror('LoginForm.RealEnterGame patch over')
end)

xlua.hotfix(DarkBoom.LoginForm, "ShowLoginOrServer",
function(self, bSHowLogin)
    self.m_loginSDKPage:SetActive(bSHowLogin)
    self.m_loginServerPage:SetActive(not bSHowLogin)
    printerror('LoginForm.ShowLoginOrServer patch over')
end)
