local util = require 'xluautil'

local DarkBoom = CS.DarkBoom
local LoginModel = DarkBoom.LoginModel
local LoginDataMgr = DarkBoom.LoginDataMgr

xlua.hotfix(DarkBoom.LoginDataMgr, 'get_IsNewRole',
function(self)
    if(LoginDataMgr:GetInstance().LoginModel.created == 0) then
        return true
    else
        return false
    end
end)