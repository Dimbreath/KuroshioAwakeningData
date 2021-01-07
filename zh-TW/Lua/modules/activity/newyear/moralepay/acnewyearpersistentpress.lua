local AcNewYearPersistentPress  = class("AcNewYearPersistentPress")

function AcNewYearPersistentPress:ctor(gameObject)
   if  IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end

    self.injections = ParseInjections(gameObject)
	self.gameObject = gameObject
	self:InjectComponent()
	self:Init()
end

function AcNewYearPersistentPress:InjectComponent()
	self.trigger = self.injections.trigger
end

function AcNewYearPersistentPress:Init()
	self.isPressed = false
	self.processPress = false
	self.isPersistentPressed = false
	self.pressedTime = 0

	self.delayTime = 0.2
	self.deltaTime = 0.1
	self.index = 0

	self.poinerDown = function(data)
		self:OnPointerDown(data)
	end
    self.trigger:onPointerDown('+',self.poinerDown)

    self.poinerExit = function(data)
		self:OnPointerExit(data)
	end
    self.trigger:onPointerExit('+',self.poinerExit)

    local poinerUp = function(data)
		self:OnPointerUp(data)
	end
    self.trigger:onPointerUp('+',self.poinerExit)	
end

function AcNewYearPersistentPress:SetPressFunc(func)
	self.pressFunc = func
end

function AcNewYearPersistentPress:OnPointerDown(data)
   self.isPressed = true
   self.processPress = true
   self.isPersistentPressed = false
   self.pressedTime = Time.realtimeSinceStartup
   self.index = 0
end

function AcNewYearPersistentPress:OnPointerExit(data)
    self.isPressed = false
    if not self.isPersistentPressed then
      return
    end
    self.isPersistentPressed = false  
end

function AcNewYearPersistentPress:OnPointerUp(data)
	self.isPressed = false
    if not self.isPersistentPressed then
      return
    end
    self.isPersistentPressed = false  
end

function AcNewYearPersistentPress:LUA_OnUpdate(elapseSeconds,realElapseSeconds)
	if not self.isPressed or not self.processPress then
		return
	end
	local maxCountPerFrame = 100
	while(Time.realtimeSinceStartup - self.pressedTime >= (self.index == 0 and self.deltaTime or self.deltaTime))
    do
      self.pressedTime = Time.realtimeSinceStartup
      self.isPersistentPressed = true
      if self.pressFunc ~= nil then
         self.pressFunc()
      end
      maxCountPerFrame = maxCountPerFrame -1
      if maxCountPerFrame < 0 then
      	 break
      end
      if self.deltaTime < 0 then
         self.processPress = false
      end
      self.index = self.index + 1
    end
    if self.index > 0 and self.deltaTime < 0 then
       self.processPress = true
    end
end

function AcNewYearPersistentPress:OnRelease()
    self.injections = {}
    self.trigger:onPointerDown('-',self.poinerDown)
    self.trigger:onPointerExit('-',self.poinerExit)
    self.trigger:onPointerUp('-',self.poinerExit)	
    self.poinerDown = nil
    self.poinerExit = nil
    self.injections = nil
    self.trigger = nil
    self.pressFunc = nil
end

return AcNewYearPersistentPress
