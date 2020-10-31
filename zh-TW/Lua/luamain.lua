uimgr = require "ui/uimgr"
local util = require 'xluautil'

printlog = CS.UnityEngine.Debug.Log
printerror = CS.UnityEngine.Debug.LogError
printwarn = CS.UnityEngine.Debug.LogWarning
PlayerPrefs = CS.UnityEngine.PlayerPrefs
DarkBoom = CS.DarkBoom
GameEntry = DarkBoom.GameEntry
DarkBoomUtility = CS.DarkBoom.DarkBoomUtility
AssetUtility = DarkBoom.AssetUtility
Image = CS.UnityEngine.UI.Image
Color =  CS.UnityEngine.Color

local checkme = require 'patch/checkme'

local main = {}
main.init = function() 
				printlog('luamain init')
			end

main.logout = function()
				printlog('luamain logout')
				checkme.logout()
			  end

return main

