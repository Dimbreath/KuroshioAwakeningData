local SimulateItem  = class("SimulateItem")

function SimulateItem:LUA_Init(gameObject)
    if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:AddListeners()
end

function SimulateItem:InjectComponent()
    self.TestButton = self.injections.TestButton
    self.Text       = self.injections.Text
end

local LuaBridge = LuaBridge

local BTN_GOTO_BATTLE = function(self)
    self.manager = Game:GetManager("SimulateManager")
    self.manager:ReuqestBattle()
end

local BTN_GOTO_SLG = function(self)
    
end

local TEST = function(self)
   local actManager = LuaBridge.GetActivitiesMgr()
   local tagDatalist = actManager:GetTagDatas(false)
   
   for i = 0, tagDatalist.Count - 1 do
       local tagData = tagDatalist[i]
       print(tagData.tagName)
   end

end

local BtnTable = 
{
	[0] =  BTN_GOTO_BATTLE,
    [1] = BTN_GOTO_SLG,
    [2] = TEST,
}

local BtnName = 
{
    [0] = "BATTLE",
    [1] = "SLG",
    [2] = "TEST",
}

function SimulateItem:LUA_SetData(obj)
    self.index = tonumber(obj)
    
    if BtnName[self.index] then
        self.Text.text = BtnName[self.index]
    else
        self.Text.text = tostring(self.index)
    end
end

function SimulateItem:LUA_Close()
    self:RemoveListeners()
end

function SimulateItem:AddListeners()
    self.TestButton.onClick:AddListener(function() 
		self:OnClickBtn() 
	end)
end


function SimulateItem:OnClickBtn()
   print(self.index)

   local func = BtnTable[self.index]

   if func then
        func(self)
    end
end

function SimulateItem:RemoveListeners()
    self.TestButton.onClick:RemoveAllListeners()
	self.TestButton.onClick:Invoke()
end

return SimulateItem