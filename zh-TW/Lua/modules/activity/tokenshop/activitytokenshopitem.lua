local ActivityBase = require"Modules/Activity/ActivityBase"
local ActivityTokenShopItem  = class("ActivityTokenShopItem")
local CoinExchangeConfig = require "Configs/CoinExchangeConfig"
local GlobalConfig = require "Configs/GlobalConfigConfig"
local ItemConfig = require "Configs/ItemConfig"
local DefaultConfig = require"Configs/DefaultConfig"
local TOKENCONFIRMBUY = "/CoinExchange/exchange"

function ActivityTokenShopItem:ctor(gameObject)
    self.injections = ParseInjections(gameObject)
    self.gameObject = gameObject
    self:InjectComponent()    
end

function ActivityTokenShopItem:InjectComponent()    
    self.ItemName = self.injections.ItemName
    self.ItemIcon = self.injections.ItemIcon
    self.QualityImg = self.injections.QualityImg
    self.BuyBtn = self.injections.BuyBtn
    self.SoldOutTrans = self.injections.SoldOutTrans
    self.OnSaleTrans = self.injections.OnSaleTrans
    self.CanvasGroup = self.injections.CanvasGroup
    self.NumText = self.injections.SaleText
    self.CoinIcon = self.injections.CoinIcon
    self.CoinPrice = self.injections.CoinPrice
end
--id, stock, shopId
function ActivityTokenShopItem:SetCell(itemInfo, disappearTime, closeCallBack, mask)
    self.mask = mask
    local coinExchange = CoinExchangeConfig.GetConfig(tonumber(itemInfo.id))
    if coinExchange == nil then
        print(string.format("商品未配表", itemInfo.id))
        return
    end

    self.ItemName.text = coinExchange.name
    self.CanvasGroup.alpha = 1
    self.SoldOutTrans.gameObject:SetActive(false)
    self.OnSaleTrans.gameObject:SetActive(false)
    self.IsSoldOut = false
    if coinExchange.inventory > 0 then
        if itemInfo.stock > 0 then
            self.OnSaleTrans.gameObject:SetActive(true)
            self.OnSaleTrans.text = string.format(DefaultConfig.GetConfig("blackshop_text_05").value, itemInfo.stock, coinExchange.inventory)
        else
            self.SoldOutTrans.gameObject:SetActive(true)
            self.CanvasGroup.alpha = 0.5
            self.IsSoldOut = true
        end
    end

    local itemData = DarkBoom.ResourceUnit(tostring(coinExchange.itemid))
    local token = DarkBoom.ResourceUnit(tostring(coinExchange.price))
    local tokenConfig = ItemConfig.GetConfig(token.item_id)
    if itemData == nil or token == nil then
        return
    end

    self.ItemId = itemData.item_id
    self.BuyNum = itemData.num
    self.BuyItemType = itemData.item_type
    self.CostItemId = token.item_id
    self.ItemPrice = token.num
    self.CoinPrice.text = tostring(token.num)
    self.Stock = itemInfo.stock

    self.ItemIcon.gameObject:SetActive(false)
    DarkBoomUtility.ShowItemIcon(itemData.item_id, 0, 0, itemData.item_type, self.ItemIcon, self.QualityImg, nil, nil, self.mask, 
        function() 
            self.ItemIcon.gameObject:SetActive(true) 
        end)

    self.CoinIcon.gameObject:SetActive(false)
    local tokenPath = string.format("Assets/GameMain/UI/UIImages/Icons/%s.png",tokenConfig.icon_small_2)
    LuaBridge.LoadAysnc4Lua(tokenPath,typeof(CS.UnityEngine.Sprite),
    function(assetName, asset, userData)
        self.CoinIcon.sprite = asset
        self.CoinIcon.gameObject:SetActive(true)
    end,self.mask)

    self.BuyBtn.onClick:RemoveAllListeners()
    self.BuyBtn.onClick:AddListener(
        function() 
            self:OnItemClick() 
        end) 
    self.BuyCallBack = closeCallBack
    self.stock = itemInfo.stock
    self.CommodityId = itemInfo.id
    self.DisappearTime = disappearTime
end

function ActivityTokenShopItem:OnItemClick()
    local curTime = DarkBoomUtility.GetServerCrtTime()
    if curTime > self.DisappearTime then
        local tipStr = GetDefaultText("activity_map_tips_02")
        GameEntry.UI:OpenMsgTipsUIForm(tipStr)
        return
    end

    local max = 0
    if self.IsSoldOut == false then
        max = self.stock
    else
        return
    end
    local buyParams = {
        curCount = 1,
        maxCount = max,
        startCount = 1,
        costItemID = self.CostItemId,
        buyItemID = self.ItemId,
        costLabel = "",
        costCount = self.ItemPrice,
        buyItemType = self.BuyItemType,
        buyNumber = self.BuyNum,
        titleType = 2,
    }
    LuaBridge.OpenBuyItem(buyParams, function(curCount, costCount, UGuiform)
        local form = CS.UnityEngine.WWWForm()
        form:AddField("commodity_id", self.CommodityId)
        form:AddField("num", curCount)
        WebRequest.SendRequest(TOKENCONFIRMBUY,form,function(serverdata)
            DarkBoomUtility.ShowRewardUIForm(serverdata.user)
            self.BuyCallBack()
        end)
    end)
end

function ActivityTokenShopItem:OnRelease()
    self.BuyBtn.onClick:RemoveAllListeners()
    self.BuyBtn.onClick:Invoke()
    self.injections = {}
    self.injections = nil
end
return ActivityTokenShopItem