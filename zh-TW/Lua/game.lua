Game = class("Game")

	--key = value
	local managers = 
	{
		MonopolyManager   = "Modules/Activity/Monopoly/MonopolyManager",
		AcSupplicateMgr   = "Modules/Activity/Supplicate/AcSupplicateMgr",
		SimulateManager   = "Modules/Simulate/SimulateManager",
		AcNewYearManager  = "Modules/Activity/NewYear/AcNewYearManager",
		BattleManager 	  = "Modules/Battle/BattleManager",
		BellDeerManager = "Modules/Activity/BellDeer/BellDeerManager"
	}

	function Game:Init() 
		self.managerDict = {}
		self:RegisterManager()
	end

	function Game:RegisterManager()
		for key,path in pairs(managers) do
			local manager = self.managerDict[key]
			if not manager then
				manager = require(path).new()
				self.managerDict[key] = manager
			end
		end
	end

	function Game:Login()
		if not self.managerDict or TableLength(self.managerDict) == 0 then
			self:RegisterManager()
		end

		for k,manager in pairs(self.managerDict) do
			manager:Login()
		end
	end

	function Game:Logout()
		if not self.managerDict then
			return
		end

		for k,manager in pairs(self.managerDict) do
			manager:Logout()
		end

		self.managerDict = {}
	end

	function Game:GetManager(key)
		local manager =  self.managerDict[key]

		if not manager then
			local modulePath = managers[key]

			if not modulePath then
				LogError("managerDict can't contain key",key) 
			end
			
			manager = require(modulePath).new()
			self.managerDict[key] = manager
			manager:Init()
		end
		return manager
	end


return Game








