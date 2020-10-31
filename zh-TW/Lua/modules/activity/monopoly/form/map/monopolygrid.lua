local MonopolyGrid  = class("MonopolyGrid")
local AssetManager  = AssetManager

function MonopolyGrid:ctor(gameObject,mapIndex,parentPosition)
    self.gameObject = gameObject
    self.mapIndex   = mapIndex
    self.parentPos  = parentPosition
    self.manager    = Game:GetManager("MonopolyManager")
    self.model      = self.manager:GetModel()
end

function MonopolyGrid:GetLocalPosition()
    local position = self.gameObject.transform.localPosition
    position = position + self.parentPos + Vector3(-2,22,0)
    return position
end

function MonopolyGrid:IsEnd()
    return self.gridId == self.maxGrid
end

function MonopolyGrid:IsStart()
    return self.gridId == 1
end

function MonopolyGrid:GetGameObject()
   return self.gameObject
end

function MonopolyGrid:SetActive(active)
    self.gameObject:SetActive(active)
end

function MonopolyGrid:OnRelease()
  
end

return MonopolyGrid
