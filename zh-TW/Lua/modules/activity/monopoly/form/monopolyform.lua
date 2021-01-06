local BaseForm = BaseForm
local MonopolyForm  	= class("MonopolyForm", BaseForm)
local MapView           = require"Modules/Activity/Monopoly/Form/Map/MonopolyMap"
local TaskView          = require"Modules/Activity/Monopoly/Form/Task/MonopolyTaskView"
local UIView            = require"Modules/Activity/Monopoly/Form/UI/MonopolyUIView"
local TopUI             = require"Modules/Activity/Monopoly/Form/UI/MonopolyTopUI"

function MonopolyForm:LUA_OnInit(gameObject,userParamData)
	self.injections = ParseInjections(gameObject)
    self.uguiForm   = gameObject:GetComponent(typeof(CS.DarkBoom.LuaUGUIForm))
	self:InjectComponent()
	self:Init()
end

function MonopolyForm:Init()
	self.manager = Game:GetManager("MonopolyManager")
    self.model = self.manager:GetModel()
	self.event = self.manager:GetEvent()

    self.model.resMask = self.uguiForm:GetMask()
    self.mapView  = MapView.new(self.MapView)
    self.taskView = TaskView.new(self.TaskView)
    self.uiView   = UIView.new(self.UIView)
    self.topUI    = TopUI.new(self.TopUI)
end

function MonopolyForm:LUA_OnOpen(userData)
    self.model:InitWorkState()
    self.uiView:UpdateData()
    self.taskView:UpdateData()
    self.mapView:UpdateData()
    self.topUI:UpdateData()
end

function MonopolyForm:InjectComponent()
	self.MapView  = self.injections.Map
    self.TaskView = self.injections.Task
    self.UIView   = self.injections.MainUI
    self.TopUI    = self.injections.TopUI
end

function MonopolyForm:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
    self.topUI:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
end

function MonopolyForm:LUA_OnClose()
    self.mapView:OnRelease()
    self.taskView:OnRelease()
    self.uiView:OnRelease()
    self.topUI:OnRelease()

    self.topUI    = nil
    self.uiView   = nil
    self.mapView  = nil
    self.taskView = nil

    self.injections = {}
    self.injections = nil
    self.uguiForm   = nil
end

return MonopolyForm
