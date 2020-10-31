local AcSupplicateTaskRewardItem  = class("AcSupplicateTaskRewardItem")

function AcSupplicateTaskRewardItem:ctor(gameObject)
    if IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:Init()
end

function AcSupplicateTaskRewardItem:InjectComponent()
    self.itemCell = self.injections.itemCell
end

function AcSupplicateTaskRewardItem:Init()
	self.manager  = Game:GetManager("AcSupplicateMgr")
	self.model    = self.manager:GetModel()
	self.event    = self.manager:GetEvent()
end


function AcSupplicateTaskRewardItem:SetData(data)
    self.itemCell:RefreshData(data,self.model.resMask)
    DarkBoomUtility.AddItemDetail(self.itemCell.gameObject,data);
end


function AcSupplicateTaskRewardItem:OnRelease()
    self.itemCell = nil
end

return AcSupplicateTaskRewardItem
