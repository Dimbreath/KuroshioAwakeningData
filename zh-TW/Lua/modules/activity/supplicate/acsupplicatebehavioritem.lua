local AcSupplicateBehaviorItem  = class("AcSupplicateBehaviorItem")

function AcSupplicateBehaviorItem:ctor(gameObject)
    if IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
end

function AcSupplicateBehaviorItem:InjectComponent()
    self.txtDesc = self.injections.txtDesc
    self.txtGetScore = self.injections.txtGetScore
end

function AcSupplicateBehaviorItem:SetData(desc,getScore)
    self.txtDesc.text = desc
    self.txtGetScore.text = tostring(getScore)
end

function AcSupplicateBehaviorItem:SetActive(active)
    self.gameObject:SetActive(active)
end

return AcSupplicateBehaviorItem
