local ActivityBase = require"Modules/Activity/ActivityBase"
local ActivityTokenShop  = class("ActivityTokenShop", ActivityBase)
local ActivityConfig = require "Configs/ActivityConfig"
local GlobalConfig = require "Configs/GlobalConfigConfig"
local TokenShopModel     = require("Modules/Activity/TokenShop/TokenShopModel")
local ItemConfig = require "Configs/ItemConfig"
local ACTIVITYSHOPINFO = "/CoinExchange/getShopInfo"
local DefaultConfig = require"Configs/DefaultConfig"
local ActivityTokenShopItem = require "Modules/Activity/TokenShop/ActivityTokenShopItem"

function ActivityTokenShop:OnInit(gameObject,mask)
    self.super:OnInit(gameObject, mask)
    self.mask = mask
    self.gameObject = gameObject
    self:InjectComponent()
    self.model = TokenShopModel.new()
    self.ShopItemList = {}
end

function ActivityTokenShop:InjectComponent()    
    self.TitleDes = self.injections.TitleDes
    self.TimeText = self.injections.TimeText
    self.GoGetBtn = self.injections.GoGetBtn
    self.TokenIcon = self.injections.TokenIcon
    self.TokenNumText = self.injections.TokenNumText
    self.ContentRoot = self.injections.ContentRoot
    self.CommodityCell = self.injections.CommodityCell
    
    -- 开放接口，暂不调用
    self.BoatImg = self.injections.BoatImg
end

function ActivityTokenShop:OnOpen(tagId)
    self.ActivityCfg = ActivityConfig.GetConfig(tagId)
    if (self.ActivityCfg ~= nil) then
        local ItemIdStrs = string.split(self.ActivityCfg.parameter_1, ',')
        if (#ItemIdStrs > 0) then
            self.CoinId = tonumber(ItemIdStrs[1])
            -- 加载代币图标
            self.TokenIcon.gameObject:SetActive(false)
            local costItemConfig = ItemConfig.GetConfig(self.CoinId)
            local assetPath = string.format("Assets/GameMain/UI/UIImages/Icons/%s.png",costItemConfig.icon)
            LuaBridge.LoadAysnc4Lua(assetPath,typeof(CS.UnityEngine.Sprite),
	        function(assetName, asset, userData)
		        self.TokenIcon.sprite = asset
		        self.TokenIcon.gameObject:SetActive(true)
	        end,self.mask)
        end
        self.ShopId = tonumber(self.ActivityCfg.parameter_3)
    end

    self:SetActivityTimeText(tagId)

    -- 前往获取
    self.GoGetBtn.onClick:RemoveAllListeners()
    self.GoGetBtn.onClick:AddListener(function()
        -- 跳转招募
        CS.CommonTranslater.TranslateBySourceId(2)
    end)

    -- 获得商品数据
    self:RefreshShopDataAndUI()
end

function ActivityTokenShop:SetActivityTimeText(tagId)
    local activityTimeText = CS.DarkBoom.LuaActivityBridge.GetActivityTime(tagId)
    local endTimeText = string.split(activityTimeText, '-')
    if #endTimeText > 1 then
        self.TitleDes.text = string.format(DefaultConfig.GetConfig("blackshop_text_01_lua").value, endTimeText[2])
    end
    local activityData = CS.DarkBoom.LuaActivityBridge.GetActivityData(tagId)

    local showDate = DarkBoomUtility.GetTimeByUnix(activityData.show)
    local disappearDate = DarkBoomUtility.GetTimeByUnix(activityData.disappear)
    self.DisappearTime = activityData.disappear
    self.TimeText.text = string.format("%s.%s.%s-%s.%s.%s",showDate.Year, showDate.Month, showDate.Day, disappearDate.Year, disappearDate.Month, disappearDate.Day)
end

function ActivityTokenShop:RefreshCoinNum()
    local item = GameEntry.PlayerData.Items:GetItemById(self.CoinId)
    local coinNum = 0
    if (item ~= nil) then
        coinNum = item.num
    end
    self.TokenNumText.text = tostring(coinNum)
end

function ActivityTokenShop:RefreshShopDataAndUI()
    self:RefreshCoinNum()
    local form = CS.UnityEngine.WWWForm()
    form:AddField("shop_id", self.ShopId)
    WebRequest.SendRequest(ACTIVITYSHOPINFO,form,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        self.model:ParseData(data)
        self:RefreshTokenItem()
    end)
end

function ActivityTokenShop:RefreshTokenItem()
    for i, data in pairs(self.model.shopInfo) do
        if  self.ShopItemList[i] == nil then
            local go = GameObject.Instantiate(self.CommodityCell.gameObject,self.ContentRoot)
			go:SetActive(true)
			go.transform.localScale = Vector3.one
            local shopItem = ActivityTokenShopItem.new(go)
            self.ShopItemList[i] = shopItem
        end
        self.ShopItemList[i]:SetCell(data, self.DisappearTime, function()
            self:RefreshShopDataAndUI()
        end, self.mask)
    end
end

function ActivityTokenShop:OnRelease()
    self.GoGetBtn.onClick:RemoveAllListeners()
    self.GoGetBtn.onClick:Invoke()
    for i,v in pairs(self.ShopItemList) do
        v:OnRelease()
    end
    self.ShopItemList = {}
    self.ShopItemList = nil
    self.injections = {}
    self.injections = nil
    self.model = nil
end

return ActivityTokenShop