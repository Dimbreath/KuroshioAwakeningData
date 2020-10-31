local util = require 'xluautil'

local DarkBoom = CS.DarkBoom
local MailForm = DarkBoom.MailForm

xlua.private_accessible(DarkBoom.MailForm)

xlua.hotfix(DarkBoom.MailForm, 'EmptyCheck',
function(self)
	self:SetMailPaper(false);
	 if(self._mailItems.Count > 0) then
		 self:SetMailPaper(true);
		 self:CanGetCheck();
	 else
		self:SetMailPaper(false);
		self._deleteAll.interactable = false;
		self._getAll.interactable = false;
    end
end)