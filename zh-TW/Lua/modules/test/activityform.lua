local ActivityForm  = class("ActivityForm",BaseForm)

function ActivityForm:LUA_OnInit(gameObject,userParamData)
    log("ActivityForm LUA_OnInit")
    self.super:LUA_OnInit(gameObject,userParamData)

    for k,v in pairs(self.injections) do
        print(k,v)
    end

    self.btn = self.injections["Button"]
    self.image = self.injections["Image"]
    self.closeBtn = self.injections["CloseButton"]

    if self.btn == nil then
        print("btn == nil")
    end

	self.btn.onClick:AddListener(function()
        self:OnClick()
    end)

    self.closeBtn.onClick:AddListener(function()
        self:OnClose()
    end)
end

function ActivityForm:Test()
    print("ActivityForm:Test")
    self:Test2()
end

function ActivityForm:Test2()
    print("ActivityForm:Test2")
end

function ActivityForm:OnClick()
    print("ActivityForm:OnClick")
    self:LoadAsset()
end

function ActivityForm:LoadAsset()
    local func = CS.GameFramework.Resource.LoadAssetCallbacks(
        function(assetName, asset, duration, userData)
            self.image.sprite = asset
        end)
     
    local imageName = "Assets/GameMain/UI/UISprites/Common/common_1_icon_states_icon_03.png"
    AssetManager:LoadAysnc4Lua(imageName,typeof(CS.UnityEngine.Sprite),func)
end

return ActivityForm
