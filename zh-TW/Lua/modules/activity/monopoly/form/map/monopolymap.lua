local MonopolyMap           = class("MonopolyMap")
local MapChess              = require "Modules/Activity/Monopoly/Form/Map/MonopolyChess"
local MapGrid               = require "Modules/Activity/Monopoly/Form/Map/MonopolyGrid"
local MonopolyPointConfig   = require"Configs/MonopolyPointConfig"

local Game                  = Game
local MakeJointKey          = MakeJointKey

function MonopolyMap:ctor(gameObject)
   if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil : ")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
    self:InjectComponent()
    self:Init()
end

function MonopolyMap:InjectComponent()
    self.Map                = self.injections.Map
    self.MapContainer       = self.injections.MapContainer
    self.Chess              = self.injections.Chess
end

function MonopolyMap:Init()
    self.manager   = Game:GetManager("MonopolyManager")
    self.model     = self.manager:GetModel()
    self.event     = self.manager:GetEvent()
    self.mapConfig = self.model.currMapConfig

    self.mapGrids = {}
    self.currMap = nil
    self.mapChess = MapChess.new(self.Chess)
    self:AddListeners()
end

function MonopolyMap:AddListeners()
    self.event.MonopolyResetEvent:AddListener(self.OnUpdateMonopolyFloor,self)
    self.event.MonopolyDiceEvent:AddListener(self.OnMonopolyDice,self)
    self.event.StartMoveEvent:AddListener(self.OnStartMoveEvent,self)
end

function MonopolyMap:RemoveListeners()
    self.event.MonopolyResetEvent:RemoveListener(self.OnUpdateMonopolyFloor,self)
    self.event.MonopolyDiceEvent:RemoveListener(self.OnMonopolyDice,self)
    self.event.StartMoveEvent:RemoveListener(self.OnStartMoveEvent,self)
end

function MonopolyMap:UpdateData()
    self:LoadMap()
    self:CheckStory()
end

function MonopolyMap:CheckStory()
    self.model:PlayStoryByMapPoint(self.model.currFloor,self.model.currStep,function()
        self:CheckOpenDialog()
    end)
end

function MonopolyMap:LoadMap()
    local func = function(assetName, asset, duration, userData)
        if self.currMap ~= nil then
            GameObject.Destroy(self.currMap.gameObject)
        end

        self.mapGrids = {}
        self.currMap = GameObject.Instantiate(asset.gameObject,self.MapContainer.transform)
        self.currMap.gameObject:SetActive(true)
        local mapGrids = self.currMap.transform:Find("MapGrids")
        local parentPosition = mapGrids.transform.localPosition

        for i = 1,mapGrids.transform.childCount do
            local mapGridGo = mapGrids.transform:GetChild(i -1).gameObject
            local index     = tonumber(mapGridGo.name) + 1
            local mapGrid   = MapGrid.new(mapGridGo,index,parentPosition)
            self.mapGrids[index] = mapGrid
        end
        
        self.mapChess:UpdateMapGrids(self.mapGrids)
    end

    self.mapChess:UpdateChessAsset()
    local currFloor  = self.model.currFloor
    local mapResName = self.model:GetMapResPath(currFloor)
    LuaBridge.LoadAysnc4Lua(mapResName,typeof(CS.UnityEngine.GameObject),func,self.model.resMask)
end

--打开界面时候的检查下一层
function MonopolyMap:CheckOpenDialog()
    -- print("floorState",self.model.floorState)
    if self.model.floorState == self.model.floorStateEnum.None then return end

    local content
    if self.model.floorState == self.model.floorStateEnum.Next then
        content = GetDefaultText("mono_bottom_01")
    elseif self.model.floorState == self.model.floorStateEnum.Reset then
        content = GetDefaultText("mono_bottom_02")
    end

    local func = function(obj) self:ToNextFloor() end
    local params = {title = "",confirmText = GetDefaultText("awasrd_tip_confirm"),cancelText = GetDefaultText("equip_choose_cancel"),message = content}
    LuaBridge.OpenDialog(1,params,nil,func, func, func)
end

function MonopolyMap:ToNextFloor()
    if self.model.floorState == 1 then
        self.manager:NextStage(1)
    elseif self.model.floorState == 2 then
        self.manager:NextStage(2)
    end
end

function MonopolyMap:OnUpdateMonopolyFloor()
    self.model:PlayStoryByMapPoint(self.model.currFloor,self.model.currStep)
    self:LoadMap()
end

function MonopolyMap:OnMonopolyDice(stepList,diceType)
    if diceType ~= self.model.diceType.Specify then return end
    --指定步数的骰子移动
    self.mapChess:StartMove(stepList)
end

function MonopolyMap:OnStartMoveEvent(stepList)
    --其他步数的骰子移动
    self.mapChess:StartMove(stepList)
end

function MonopolyMap:OnRelease()
    self:RemoveListeners()
    for k,v in pairs(self.mapGrids) do
        v:OnRelease()
    end
    self.mapChess = nil
    self.mapGrids = {}
end

return MonopolyMap
