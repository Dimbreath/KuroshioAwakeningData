local util = require 'xluautil'
local DarkBoom = CS.DarkBoom
local Tweening = CS.DG.Tweening
xlua.hotfix(DarkBoom.LobbyForm, 'OnPause',
function(self,msg)
	base(self):OnPause();
	self.NoticeItem:Clear();
     CS.CharacterSoundUtility.CloseCrtCharacterSound();
end
)

xlua.hotfix(DarkBoom.LobbyForm, 'OnResume',
function(self,msg)

	print('DarkBoom.LobbyForm 123')
	base(self):OnResume();
	self.NoticeItem:Init();
	for k,v in pairs(self.tweeners) do
		v:Kill();
	end
end
)