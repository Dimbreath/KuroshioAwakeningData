local SimulateForm  = class("SimulateForm", BaseForm)

local LuaBridge = LuaBridge
local DarkBoomUtility = DarkBoomUtility
function SimulateForm:LUA_OnInit(gameObject,userParamData)
	self.injections = ParseInjections(gameObject)
	self.uguiForm   = gameObject:GetComponent(typeof(CS.DarkBoom.LuaUGUIForm))
	self.resMask    = self.uguiForm:GetMask()
	self:InjectComponent()
end

function SimulateForm:InjectComponent()
	self.scrollList = self.injections.ScrollView
	self.cradTemplate = self.injections.Item
	self.CirwareImage = self.injections.CirwareImage
	self.SkeletonGraphic = self.injections.SkeletonGraphic
	self.PlayCriwareBtn = self.injections.PlayCriwareBtn
	self.PlaySkeleteBtn = self.injections.PlaySkeleteBtn
	self.StoryInputField     = self.injections.StoryInputField
	self.StoryButton    = self.injections.StoryButton
	self.ChangeTitleBtn = self.injections.ChangeTitleBtn
end

function SimulateForm:LUA_OnOpen(userData)
	self.scrollList.Child = self.cradTemplate.gameObject
	self.scrollList.ChildCount = 100

	local itemRender = function(index, child)
		local luaview = child:GetComponent(typeof(CS.DarkBoom.LuaView))
		luaview:SetData(index)
	end

	self.scrollList.onItemRender = itemRender
	self.scrollList:ReBuild()
	self:AddListeners()

	-- self.uguiForm
end

function SimulateForm:LUA_OnClose()
	self:RemoveListeners()
end

function SimulateForm:PlayCriware()
	--criManaMovieMaterial.player.Stop();
	local rawImageMat = self.CirwareImage.material
	local criManaMovieMaterial = LuaBridge.GetOrAddComponent(self.CirwareImage.gameObject,typeof(CS.CriManaMovieMaterial))
	local videoPath = LuaBridge.GetCriwareAssetPath("chouka_ten_purple",0)
	criManaMovieMaterial.player:SetFile(nil, videoPath);
	criManaMovieMaterial.material = rawImageMat
	self.CirwareImage.material = criManaMovieMaterial.material
	criManaMovieMaterial.player:Prepare()
	criManaMovieMaterial.player:Start();
end

function SimulateForm:PlaySkelete()
	local function loadComplete(assetName, asset,  userData)
        print(assetName)
        self.SkeletonGraphic.skeletonDataAsset = asset
		self.SkeletonGraphic:Initialize (true);
		self.SkeletonGraphic.AnimationState:SetAnimation (0,"Idle", true);
    end
    
    local path = "Assets/GameMain/Spine/CharacterSmall/common_1002000/skeleton_SkeletonData.asset"

    if path == "" then 
        return
    end

    LuaBridge.LoadAysnc4Lua(path,typeof(CS.Spine.Unity.SkeletonDataAsset),loadComplete,self.resMask)
end

function SimulateForm:AddListeners()
    self.PlayCriwareBtn.onClick:AddListener(function() 
		self:PlayCriware()
	end)

	self.PlaySkeleteBtn.onClick:AddListener(function() 
		self:PlaySkelete()
	end)

	self.StoryButton.onClick:AddListener(function()
		self:PlayStory()
	end)

	self.ChangeTitleBtn.onClick:AddListener(function()
		LuaBridge.SetMenuTitle(self.uguiForm,"memories_1_head_tittle")
	end)
end

function SimulateForm:PlayStory()
	print(self.StoryInputField.text)

	local function playEnd()
		print("playEnd")
	end
	local tb = {}
	table.insert(tb,tonumber(self.StoryInputField.text))
	LuaBridge.PlayStory(tb,playEnd)
end

function SimulateForm:RemoveListeners()
    self.PlayCriwareBtn.onClick:RemoveAllListeners()
	self.PlayCriwareBtn.onClick:Invoke()

	self.PlaySkeleteBtn.onClick:RemoveAllListeners()
	self.PlaySkeleteBtn.onClick:Invoke()

	self.StoryButton.onClick:RemoveAllListeners()
	self.StoryButton.onClick:Invoke()

	self.ChangeTitleBtn.onClick:RemoveAllListeners()
	self.ChangeTitleBtn.onClick:Invoke()
end

return SimulateForm