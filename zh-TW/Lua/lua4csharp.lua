--C# 调用的全局函数定义在这个文件

function Update()
    if UpdateEvent then
        UpdateEvent:Invoke()
    end
end

function LateUpdate()
    
end

function FixedUpdate()
   
end

function LuaGC()
    collectgarbage("collect")
end

function OnApplicationPause(pause)
    print("Lua4CSharp -> OnApplicationPause",pause)
end

function OnItemChange()
    ItemChangeEvent:Invoke()
    --print("OnItemChange")
end

function Login()
    -- print("Lua4CSharp -> Login")
    Game:Login()
end

function RestartGame()
    -- print("Lua4CSharp -> RestartGame")
    Game:Logout()
end

function HaveMonopolyRedPoint()
    local monopolyManager = Game:GetManager("MonopolyManager")
    return monopolyManager:HaveRedPoint();
end

function HaveSupplicateRedPoint()
    -- local supplicateManager = Game:GetManager("AcSupplicateModel")
    return false
end