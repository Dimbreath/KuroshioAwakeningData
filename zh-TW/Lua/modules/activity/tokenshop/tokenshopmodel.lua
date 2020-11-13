local TokenShopModel = class("TokenShopModel")
local CoinExchangeConfig = require "Configs/CoinExchangeConfig"
function TokenShopModel:ctor()
    self.todayCoinGet = 0
    self.weekCoinGet = 0
    self.weekCoinGetLimit = 0
    self.shopInfo = {}
end

function TokenShopModel:ParseData(data)
    local ShopInfoModel = {}
    for i,v in ipairs(data.shopInfo) do
        local itemdata = {}
        itemdata.id = v.id
        itemdata.stock = v.stock
        itemdata.shopId = v.shopId
        local coinCfg = CoinExchangeConfig.GetConfig(tonumber(v.id))
        if coinCfg == nil then
            itemdata.sequence = 0
        else
            itemdata.sequence = coinCfg.sequence
        end
        table.insert(ShopInfoModel, itemdata)
    end
    table.sort(ShopInfoModel, function(a, b) return a.sequence > b.sequence end)
    self.shopInfo = ShopInfoModel
    self.todayCoinGet = data.todayCoinGet
    self.weekCoinGet = data.weekCoinGet
    self.weekCoinGetLimit = data.weekCoinGetLimit
end

return TokenShopModel