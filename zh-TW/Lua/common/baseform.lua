BaseForm = class("BaseForm")

function BaseForm : LUA_OnInit(gameObject,userParamData)
   
end

function BaseForm:OnClose(uguiForm)
    if  IsGameObjectNull(uguiForm) then
        print_error("uguiForm == nil")
        return 
    end

    uguiForm:OnCloseForm()
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