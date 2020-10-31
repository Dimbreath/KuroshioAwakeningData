local this = class("FirstRechargeView",BaseForm)

function this:init()
    -- self.gameObject = gameObject
    -- self.uguiform = self.gameObject:GetComponent("LuaGuiForm")
end

function this : LUA_OnInit(injections)
    print("FirstRechargeView LUA_OnInit")

    for key, value in pairs(injections) do
        print(key, value)
        if key == "LuaButton" then 
            self.image = value
        elseif key == "LuaButton2" then
            value.onClick:AddListener(function()
                --self:LoadAsset()
                self:OnServer()
            end)
        end
    end
    -- self.text = injections["LuaText"]
    -- print(self.text.gameObject.name)
    -- self.text.text = "1111111"
end

function this:OnClickBtn()
    print("onClick")
end

function this:LoadAsset()
    local func = CS.GameFramework.Resource.LoadAssetCallbacks(
        function(assetName, asset, duration, userData)
            self.image.sprite = asset
        end,
        function()

        end)

    local imageName = "Assets/GameMain/UI/UISprites/Common/common_1_icon_states_icon_03.png"
    AssetManager:LoadAysnc4Lua(imageName,typeof(CS.UnityEngine.Sprite),func)
end


function this:OnServer()
    local GETBANNARLIST = "/banner/getBannerList";

    WebRequest.SendRequest(GETBANNARLIST,nil,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        print_r(data)
    end)
end

return this