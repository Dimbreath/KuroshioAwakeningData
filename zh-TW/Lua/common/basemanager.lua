BaseManager = class("BaseManager")



function BaseManager:AddListeners()

end

function BaseManager:RemoveListeners()

end

function BaseManager:Logout()
    self:RemoveListeners()
end

function BaseManager:Login()
    self:AddListeners()
end



return BaseManager