--[[
public static void ChangeUIParent(Transform trn, Transform parent)
{
    if (parent == null || trn == null) return;

    UGuiGroupHelper uGuiGroupHelper = parent.GetComponentInParent<UGuiGroupHelper>();

    if (uGuiGroupHelper == null)
    {
        return;
    }

    if (uGuiGroupHelper.IsBlur && trn.gameObject.layer != BlurUILayer)
    {
        trn.gameObject.SetLayerRecursively(BlurUILayer);
    }
    else if (!uGuiGroupHelper.IsBlur && trn.gameObject.layer != UILayer)
    {
        trn.gameObject.SetLayerRecursively(UILayer);
    }
    trn.SetParent(parent);
}
--]]

local util = require 'xluautil'

local DarkBoom = CS.DarkBoom
local GameEntry = DarkBoom.GameEntry
local PlayerPrefs = CS.UnityEngine.PlayerPrefs
local GameFrameworkLog = CS.GameFramework.GameFrameworkLog
local PrefabLoadSingleton = DarkBoom.PrefabLoadUtility.GetInstance()
local AssetUtility = DarkBoom.AssetUtility

xlua.private_accessible(DarkBoom.DarkBoomUtility)

xlua.hotfix(DarkBoom.DarkBoomUtility, 'ChangeUIParent',
function(trn,parent)
	
	if (parent == nil or trn == nil) then
		return
	end
	local uGuiGroupHelper = parent.gameObject:GetComponentInParent(typeof(DarkBoom.UGuiGroupHelper))

	if (uGuiGroupHelper == nil) then
        return
    end

	 if (uGuiGroupHelper.IsBlur and (trn.gameObject.layer ~= DarkBoom.DarkBoomUtility.BlurUILayer)) then
        CS.UnityExtension.SetLayerRecursively(trn.gameObject, DarkBoom.DarkBoomUtility.BlurUILayer)
    elseif ((not uGuiGroupHelper.IsBlur) and (trn.gameObject.layer ~= DarkBoom.DarkBoomUtility.UILayer)) then
        CS.UnityExtension.SetLayerRecursively(trn.gameObject, DarkBoom.DarkBoomUtility.UILayer)
    end
    
    trn:SetParent(parent)
end)