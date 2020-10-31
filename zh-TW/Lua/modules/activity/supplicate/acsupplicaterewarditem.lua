local AcSupplicateRewardItem  = class("AcSupplicateRewardItem")

function AcSupplicateRewardItem:ctor(gameObject)
    if IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:Init()
end

function AcSupplicateRewardItem:InjectComponent()
    self.itemCell = self.injections.itemCell
    self.imgHasGet = self.injections.imgHasGet
end

function AcSupplicateRewardItem:Init()
	self.manager  = Game:GetManager("AcSupplicateMgr")
	self.model    = self.manager:GetModel()
	self.event    = self.manager:GetEvent()
end


function AcSupplicateRewardItem:SetData(reward,status)
    local datas = DarkBoomUtility.ParseRewardString(reward)
	if datas and datas.Count > 0 then 
		self.itemCell:RefreshData(datas[0],1024)
		DarkBoomUtility.AddItemDetail(self.itemCell.gameObject,datas[0]);
    end
    self.imgHasGet.gameObject:SetActive(status == 1)
end


function AcSupplicateRewardItem:OnRelease()
    self.itemCell = nil
end

return AcSupplicateRewardItem
