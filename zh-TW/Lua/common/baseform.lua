BaseForm = class("BaseForm")

-- function BaseForm:Init(gameObject,userParamData)
--     self:LUA_OnInit(gameObject,userParamData)
-- end

function BaseForm : LUA_OnInit(gameObject,userParamData)
    self.injections = ParseInjections(gameObject)
    self.gameObject = gameObject
    self.uguiForm = gameObject:GetComponent(typeof(CS.DarkBoom.LuaUGUIForm))
end

function BaseForm:GetMask( ... )
    if  IsGameObjectNull(self.uguiForm) then
        print_error("self.uguiForm == nil")
        return 0
    end

    return self.uguiForm:OnMask()
end

function BaseForm:OnClose()
    if  IsGameObjectNull(self.uguiForm) then
        print_error("self.uguiForm == nil")
        return 
    end

    print("OnClose")
    self.uguiForm:OnCloseForm()
end

function BaseForm : LUA_OnStack(userData)

end

function BaseForm : LUA_OnBeforeOpen()

end

function BaseForm : LUA_OnOpen(userData)

end

function BaseForm : LUA_OnPause()

end

function BaseForm : LUA_OnResume()

end

function BaseForm : LUA_OnCover()

end

function BaseForm : LUA_OnReveal()

end

function BaseForm : LUA_OnRefocus(userData)

end

function BaseForm : LUA_OnUpdate(elapseSeconds,realElapseSeconds)

end

function BaseForm : LUA_OnDepthChanged(depthInUIGroup)

end

function BaseForm : LUA_OnBack(obj)
  
end

function BaseForm : LUA_OnHelp(obj)

end

function BaseForm : LUA_InternalSetVisible(visible)

end

function BaseForm : LUA_OnClose(userData)

end

return BaseForm