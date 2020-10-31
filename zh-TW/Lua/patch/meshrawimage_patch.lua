local util = require 'xluautil'

local DarkBoom = CS.DarkBoom
local GameEntry = DarkBoom.GameEntry
local PlayerPrefs = CS.UnityEngine.PlayerPrefs
local GameFrameworkLog = CS.GameFramework.GameFrameworkLog
local PrefabLoadSingleton = DarkBoom.PrefabLoadUtility.GetInstance()
local AssetUtility = DarkBoom.AssetUtility


xlua.private_accessible(CS.MeshRawImage)
xlua.private_accessible(CS.MeshRawImage.DiceInfo)
xlua.private_accessible(CS.LitJson.JsonData)

xlua.hotfix(CS.MeshRawImage, 'LoadJson',
function(self)
    --printerror('MeshRawImage.LoadJson patch over')
	
	--printerror(CS.LitJson.JsonMapper)
	
	--printerror(CS.LitJson.JsonMapper.ToObject)
	
	--printerror(CS.MeshRawImage.defaultJsonsString)
	
	--JsonData jd = JsonMapper.ToObject(defaultJsonsString);
	local jd = CS.LitJson.JsonMapper.ToObject(CS.MeshRawImage.defaultJsonsString)

	local info2 = jd["info"]
	local dices = jd["dices"]

	local iter = jd.inst_object:GetEnumerator()	
	while iter:MoveNext() do
		local k = iter.Current.Key
		local v = iter.Current.Value

		if k == "info" then
			info2 = v
		end

		if k == "dices" then
			dices = v
		end
	end

	if self.texture == nil then
		self.info = CS.MeshRawImage.DiceInfo(info2, 2048, 2048)
	else
		self.info = CS.MeshRawImage.DiceInfo(info2, self.texture.width, self.texture.height)
	end
	---[[
    self:InitializeDices(self.info, dices)
    self:SetKey(self.key)
	--]]
end)