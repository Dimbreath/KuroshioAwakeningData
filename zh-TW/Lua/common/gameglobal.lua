--赋值C#组件
--- Import CS
---@type CS.DarkBoom
DarkBoom        	= CS.DarkBoom
UnityEngine         = CS.UnityEngine
GameEntry       	= CS.DarkBoom.GameEntry
Debug           	= CS.UnityEngine.Debug
LuaBridge       	= CS.DarkBoom.LuaBridge
GameObject      	= CS.UnityEngine.GameObject
Transform       	= CS.UnityEngine.Transform
RectTransform       = CS.UnityEngine.RectTransform
Random          	= CS.UnityEngine.Random
Time            	= CS.UnityEngine.Time
Color           	= CS.UnityEngine.Color
Color32         	= CS.UnityEngine.Color32
Application     	= CS.UnityEngine.Application
Vector2         	= CS.UnityEngine.Vector2
Vector3         	= CS.UnityEngine.Vector3
Quaternion      	= CS.UnityEngine.Quaternion
DOTween         	= CS.DG.Tweening.DOTween
Camera          	= CS.UnityEngine.Camera
ColorUtility    	= CS.UnityEngine.ColorUtility
WebRequest      	= CS.DarkBoom.LuaWebRequest
SpineModel      	= CS.DarkBoom.SpineModel
DarkBoomUtility 	= CS.DarkBoom.DarkBoomUtility
AssetUtility    	= CS.DarkBoom.AssetUtility
LuaActivityBridge   = CS.DarkBoom.LuaActivityBridge

--Common ItemChange Event
ItemChangeEvent = Event.new()
UpdateEvent     = Event.new()

local DefaultConfig = require"Configs/DefaultConfig"
local GlobalConfigConfig = require"Configs/GlobalConfigConfig"

function GetDefaultText(key)
	local config = DefaultConfig.GetConfig(key)
	return config.value
end

function GetGlobalText(key)
	local config = GlobalConfigConfig.GetConfig(key)
	return config.value
end

