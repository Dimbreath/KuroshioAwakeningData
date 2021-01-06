-----播放criware代码示例----------------------------
-- function Test:PlayCriware()
--  criManaMovieMaterial.player.Stop()
-- 	local rawImageMat = self.CirwareImage.material
-- 	local criManaMovieMaterial = LuaBridge.GetOrAddComponent(self.CirwareImage.gameObject,typeof(CS.CriManaMovieMaterial))
-- 	local videoPath = LuaBridge.GetCriwareAssetPath("chouka_ten_purple",0)
-- 	criManaMovieMaterial.player:SetFile(nil, videoPath);
-- 	criManaMovieMaterial.material = rawImageMat
-- 	self.CirwareImage.material = criManaMovieMaterial.material
-- 	criManaMovieMaterial.player:Prepare()
-- 	criManaMovieMaterial.player:Start();
-- end


----播放音效示例--------------------------
-- DarkBoomUtility.PlayBGM("worldmap_main",nil)

------创建物品示例--------------------------------------
-- self.ItemCell:RefreshDataLua(1,10,1,1024)
-- self.ItemCell:RefreshDataLua(1,10,1,0,1024)
-- self.ItemCell:RefreshDataWithGettedLua(1,10,1,0,true,1024)
-- self.ItemCell:RefreshDataWithTipsLua(1,10,1,0,true,1024)
-- self.ItemCell:RefreshDataByAllParamLua(1,10,1,0,true,true,1024)

-----EventTrigger4Lua 示例-------------------------------
-- function Test:InitTriggerFunc()
--     self.onClick = function()
--         print("onClick")
--     end
--     self.onDrag = function()
--         print("onDrag")
--     end
-- end

-- function Test:AddListeners()
--     self.TestButton:onDrag('+',self.onDrag)
--     self.TestButton:onClick('+',self.onClick)
-- end

-- function Test:RemoveListeners()
--     self.TestButton:onDrag('-',self.onDrag)
--     self.TestButton:onClick('-',self.onClick)
-- end


