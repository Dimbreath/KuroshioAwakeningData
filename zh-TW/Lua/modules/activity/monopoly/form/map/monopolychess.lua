local MonopolyChess  = class("MonopolyChess")

function MonopolyChess:ctor(gameObject)
    self.manager   = Game:GetManager("MonopolyManager")
    self.model     = self.manager:GetModel()
    self.event     = self.manager:GetEvent()

    self.tempStep  = 0
    self.ChessObj  = gameObject
    self.spine = self.ChessObj.gameObject:GetComponent(typeof(CS.Spine.Unity.SkeletonGraphic))
end

function MonopolyChess:LoadChess()
    local function loadComplete(assetName, asset,  userData)
        print(assetName)
        self.spine.skeletonDataAsset = asset
        self:PlayAnim()
    end
    
    local path = self.model:GetSpineAssetPath()

    if path == "" then 
        return
    end

    LuaBridge.LoadAysnc4Lua(path,typeof(CS.Spine.Unity.SkeletonDataAsset),loadComplete,self.model.resMask)
end

function MonopolyChess:UpdateMapGrids(mapGrids)
    self.mapGrids = mapGrids
    self:UpdateChessPosition()
end

function MonopolyChess:UpdateChessAsset()
    self:LoadChess()
end

function MonopolyChess:PlayAnim()
    if self.spine == nil then
        return
    end

    self.spine:Initialize (true);
    self.spine.AnimationState:SetAnimation (0,"Walk", true);
end

function MonopolyChess:UpdateChessPosition()
    local currMapGrid = self:GetGridInfo(self.model.currStep)
    self.ChessObj.transform.localPosition = currMapGrid:GetLocalPosition()

    local nextStep = self:NextStep()
    local nextGrid = self:GetGridInfo(nextStep)
    if nextGrid then 
        local nextGridPos = nextGrid:GetLocalPosition()
        local rotateVector = self:RotateVector(self.ChessObj.transform.localPosition,nextGridPos)
        self.ChessObj.transform:DORotate(rotateVector, 0.05) --只转0、180两个角度。
    end
end

function MonopolyChess:NextStep()
    return self.model.currStep + 1
end

function MonopolyChess:StartMove(stepList)
    self.stepIndex = 1
    --移格子用
    self.tempStep  = 0
    self.stepCount = 0
    self.stepList = stepList
    self.tempStep = self.model.currStep
    self.model.walkState = self.model.walkType.Walking
    self:UpdateStepData()
end

function MonopolyChess:UpdateStepData()
    local data = self.stepList[self.stepIndex]

    if not data then
        self:MoveEnd()
        return
    end

    self.data = data
    --0:未结束，1：结束
    self.endStatus = data.endStatus
    self.stepCount = data.point
    self:Move()
end

function MonopolyChess:MoveEnd()
    self.stepIndex  = 1
    self.model.walkState = self.model.walkType.Idle
end

function MonopolyChess:Move()
    local nextStep = self.tempStep + 1

    if nextStep > self.model.currFloorMaxStep then 
        self:MoveRoundCompolete()
        return 
    end

    local nextGrid = self:GetGridInfo(nextStep)

    if nextGrid == nil then
        self:MoveRoundCompolete()
        return
    end

    local nextGridPos = nextGrid:GetLocalPosition()
    local rotateVector = self:RotateVector(self.ChessObj.transform.localPosition,nextGridPos)
    -- --只转0、180两个角度。
    self.ChessObj.transform:DORotate(rotateVector, 0.05)

    local tween = self.ChessObj.transform:DOLocalMove(nextGridPos,0.2)
    tween:OnComplete(function()
        self.tempStep       = nextStep
        self.stepCount      = self.stepCount - 1

        if self.stepCount > 0 then
            self:Move()
        else
            self:MoveRoundCompolete()
        end
    end)
end

function MonopolyChess:RotateVector(currPos,targetPos)
    if currPos == nil or targetPos == nil then
        return Vector3.zero
    end

    if targetPos.x - currPos.x > 0 then
        return Vector3.zero
    else
        return Vector3(0,180,0)
    end
end

function MonopolyChess:MoveRoundCompolete()
    self.model.currStep = self.tempStep

    self.model:PlayStoryByMapPoint(self.model.currFloor,self.model.currStep,function()
        self:CheckMoveDialog(function()
            self.stepIndex = self.stepIndex + 1
            self:UpdateStepData()
        end)
    end)
end

--走格子检查
function MonopolyChess:CheckMoveDialog(callBack)
    local model = 1
    local message = ""
    local confirmText = ""
    
    if self.endStatus == 1 then
        confirmText = GetDefaultText("mono_bottom_01")
        self.manager:NextStage(self.model.floorStateEnum.Next)
    elseif self.endStatus == 2 then
        confirmText = GetDefaultText("mono_bottom_02")
        self.manager:NextStage(self.model.floorStateEnum.Reset)
    else
        confirmText = GetDefaultText("awasrd_tip_confirm")
    end
    
    local items = {}
    for i,v in ipairs(self.data.itemList) do
        if v.id ~= nil and v.id ~= "" then
            table.insert(items,string.format("%s,%s,%s,",1,v.id,v.num))
        else
            print_error("奖励存在空物品")
        end
    end

    message = self.model:GetItemMessage(self.model.currFloor,self.model.currStep,self.data.itemList,self.data.rand_id)
    local params = {title = "",confirmText = confirmText,cancelText = "",message = message}

    local func = function(obj)  self:ToNextFloorWithCallBack(callBack) end
    LuaBridge.OpenDialog(model,params,items,func ,func, func)
end

function MonopolyChess:ToNextFloorWithCallBack(callBack)
    self:ToNextFloor()
    if callBack then
        callBack()
    end
end

function MonopolyChess:ToNextFloor()
    -- print("ToNextFloor",self.model.floorState)
    if self.model.floorState == 1 then
        self.manager:NextStage(1)
    elseif self.model.floorState == 2 then
        self.manager:NextStage(2)
    end
end

function MonopolyChess:GetGridInfo(gridId)
    if gridId > self.model.currFloorMaxStep then print_error("gridId > self.model.currFloorMaxStep") return nil end

    local configId = MakeJointKey(self.model.currFloor,gridId)
    local config = self.model:GetMonopolyPointConfig(configId)

    if config then
        local mapId = config.mapid
        local mapGrid = self.mapGrids[mapId]

        if mapGrid then
            return mapGrid,configId,config
        else
            print_error("mapGrid = nil,mapId = ",mapId)
        end
    else
        print_error("config = nil",self.model.currFloor,gridId)
    end
end

return MonopolyChess



