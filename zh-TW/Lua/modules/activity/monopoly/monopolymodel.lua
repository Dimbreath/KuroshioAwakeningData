local MonopolyModel         = class("MonopolyModel")
local ActivityConfig        = require"Configs/ActivityConfig"
local MonopolyMapConfig     = require"Configs/MonopolyMapConfig"
local GlobalConfig          = require"Configs/GlobalConfigConfig"
local TaskConfig            = require"Configs/TaskConfig" 
local CommodityConfig       = require"Configs/CommodityConfig"
local ItemConfig            = require "Configs/ItemConfig"
local MonopolyPointConfig   = require"Configs/MonopolyPointConfig"
local MonorewardConfig      = require"Configs/MonorewardConfig"
local math = math

function MonopolyModel:ctor()
    self:InitEnum()
    self:InitData()
end 

function MonopolyModel:InitEnum(  )
    self.diceType = 
    {
      Single = 1,
      Double = 2,
      Specify = 3,
    }

    self.floorStateEnum = 
    {
      None = 0,
      Next = 1,
      Reset = 2,
    }

    self.walkType = 
    {
      Idle = 0,
      Walking = 1,
    }

    self.EventType = 
    {
      Rand = 2,
    }
end

function MonopolyModel:InitWorkState()
  self.walkState = self.walkType.Idle
end

function MonopolyModel:InitData()
  self.tagId     = 0
  self.resMask   =  0
  self.walkState = self.walkType.Idle
  self.openStatus = true
end

function MonopolyModel:ResetData()
    self.taskList = {}
    self.walkState = self.walkType.Idle
    --0:不显示，1：下一层，2：重置
    self.floorState = self.floorStateEnum.None
end

function MonopolyModel:InitInfos(data)
    self:ResetData()
    self:UpdateFloorAndStep(data.millionaireInfo.floor,data.millionaireInfo.step)
    
    for i,v in ipairs(data.taskList) do
        self:UpdateTaskData(v)
    end

    self.openStatus = data.openStatus
end

function MonopolyModel:UpdateActivityConfig()
  self.activityConfig = ActivityConfig.GetConfig(self.tagId)

  if self.activityConfig == nil then
    print_error("ActivityConfig = nil,tagid = ",self.tagId)
    return
  end

  --购买商店
  local commodityData            = string.split(self.activityConfig.parameter_1,';')
  self.specifyStepCostShopId     = tonumber(commodityData[1])
  self.doubleDiceCostShopId      = tonumber(commodityData[2])
  self.diceCostShopId            = tonumber(commodityData[3])
  self.shopId                    = tonumber(self.activityConfig.parameter_3)


  --骰子物品id
  local itemData             = string.split(self.activityConfig.parameter_2,';')
  self.specifyStepItemId     = tonumber(itemData[1])
  self.doubleDiceItemId      = tonumber(itemData[2])
  self.monopolyCurrency      = tonumber(itemData[3])
  self.diceItemId            = tonumber(itemData[4])
end

function MonopolyModel:UpdateFloorAndStep(floor,step)
    self.currFloor = floor
    self.currStep  = step
    local mapConfig = MonopolyMapConfig.GetConfig(self.currFloor)

    if mapConfig then
       self.currMapConfig = mapConfig
    else
      print_error("mapConfig = nil, floor = ",self.currFloor)
      return
    end

    local wh = string.split(mapConfig.wh,',')
    self.mapWidth     = tonumber(wh[1])
    self.mapHeight    = tonumber(wh[2])
    self.currFloorMaxStep = mapConfig.pointcount

    local maxFloor     = #MonopolyMapConfig
    local maxMapConfig = MonopolyMapConfig.GetConfig(maxFloor)
    local maxStep      = maxMapConfig.pointcount

    if self.currFloor == maxFloor and self.currStep == maxStep then
      --重置
      self.floorState = self.floorStateEnum.Reset
    elseif self.currStep == self.currFloorMaxStep then
      --下一关
      self.floorState = self.floorStateEnum.Next
    else
      self.floorState = self.floorStateEnum.None
    end
end

function MonopolyModel:ParseDiceData(data)
  local stepList = {}
  for i,v in ipairs(data.act) do
    local stepData = {}
    stepData.itemList = {}
    stepData.point = v.point
    stepData.endStep = v.step.endStep
    stepData.endStatus = v.step.endStatus
    stepData.rand_id   = v.rand_id
    for _,item in ipairs(v.items) do
      table.insert( stepData.itemList, item)
    end

    table.insert( stepList,stepData)
  end
  
  return stepList
end

function MonopolyModel:UpdateTaskData(data)
  local taskData = self.taskList[data.task_id]

  if taskData == nil then
      taskData = {}
      taskData.task_id = 0
      table.insert(self.taskList,taskData)
  end

  taskData.task_id  = data.task_id
  taskData.type     = data.type
  taskData.progress = data.progress
  --0:未完成，1：可领取，2：已领取
  taskData.status   = data.status
  taskData.start_time   = data.start_time
  taskData.expire_time  = data.expire_time
end

function MonopolyModel:RemoveLastTask(taskId)
  for i = #self.taskList, 1,-1 do
    local task_id = self.taskList[i].task_id

    if task_id == taskId then
      table.remove( self.taskList,i)
    end
  end
end

function MonopolyModel:UpdateTaskState(taskId)
  for i,v in ipairs(self.taskList) do
    if v.task_id ==  taskId then
       v.status = 2
    end
  end
end

function MonopolyModel:GetTaskReward(taskId)
  local items = {}
  local taskConfig = self:GetTaskConfig(taskId)
  if taskConfig == nil then return end
  local taskRewards = string.split(taskConfig.taskreward,";")
  
  for i = 1,#taskRewards do
    if taskRewards[i] ~= nil and taskRewards[i] ~= "" then
      table.insert(items,taskRewards[i])
    else
      print_r("无效的奖励")
    end
  end

  local params = {title = "",confirmText = GetDefaultText("awasrd_tip_confirm"),cancelText = GetDefaultText("equip_choose_cancel"),message = GetDefaultText("freemarch_finish_getreward")}
  LuaBridge.OpenDialog(1,params,items)
end

function MonopolyModel:GetBaseDiceNum()
  local diceItemId = tonumber(GetGlobalText("monopoly_item_dice"))
  local itemName,itemNum = self:GetItemInfo(diceItemId)
  itemNum = itemNum or 0 
  return itemNum
end

function MonopolyModel:GetItemInfo(itemId)
	local itemName = ""
	local itemNum  = 0
	local config   = ItemConfig.GetConfig(itemId)

	if config == nil then
		-- print_error("config = nil, itemId = ",itemId)
		return itemName,itemNum
	end

	itemName = config.name

	if itemId == 1 then
		--钻石
		itemNum = GameEntry.PlayerData.Diamond.Value
		return itemName,itemNum
	end

	local itemModel = GameEntry.PlayerData.Items:GetItemById(itemId)

	if itemModel == nil then
		--print_error("未找到Item",itemId)
		return itemName,itemNum
	end
	
	itemNum = itemModel.num
	return itemName,itemNum
end

function MonopolyModel:GetTaskConfig(task_id)
  return TaskConfig.GetConfig(tonumber(task_id))
end

function MonopolyModel:GetCommodityConfig(id)
  return CommodityConfig.GetConfig(tonumber(id))
end

function MonopolyModel:GetMonopolyPointConfig(id)
  return MonopolyPointConfig.GetConfig(id)
end

function MonopolyModel:GetItemConfig(id)
  return ItemConfig.GetConfig(id)
end

function MonopolyModel:GetRandDesc(id)
  local config = MonorewardConfig.GetConfig(id)
  if config == nil then
    return ""
  else
    return config.plotdesc
  end
end

function MonopolyModel:GetMonopolyMapConfig(id)
  return MonopolyMapConfig.GetConfig(id)
end

function MonopolyModel:GetDicePointPath(point)
  return string.format( "Assets/GameMain/UI/UISprites/Dice/activity_1_tycoon_dice_0%s.png",point)
end

function MonopolyModel:GetDicePointPath_Two(point)
  return string.format("Assets/GameMain/UI/UISprites/Dice/activity_1_tycoon_icon_dice%s.png",point)
end

function MonopolyModel:GetMapResPath(floor)
  return string.format("Assets/GameMain/UI/UIItems/Activity/Monopoly_Map_%s.prefab",floor)
end

function MonopolyModel:GetSpineAssetPath()
  local config = self:GetMonopolyMapConfig(self.currFloor)

  if config == nil or config.spineasset == "" then
      print_error("GetMonopolyMapConfig is nil;CurrFloor = ",self.currFloor)
      return ""
  end

  return string.format("Assets/GameMain/Spine/CharacterSmall/%s/skeleton_SkeletonData.asset",config.spineasset)
end

function MonopolyModel:GetTimeImgPath()
  return "Assets/GameMain/UI/UISprites/Monopoly/activity_1_tycoon_time.png"
end

function MonopolyModel:PlayStory(storyKey,playEndCallBack)
  local value = GameEntry.Setting:GetInt(storyKey,0)

  local function playEnd()
    GameEntry.Setting:SetInt(storyKey,1)
    if playEndCallBack then playEndCallBack() end
  end

  if value == 0 then
    local storyConfig = GetGlobalText(storyKey)
    if storyConfig == nil then return end

    local storyConfigIds = string.split(storyConfig,",")
    local storyIds = {}

    for i = 1,#storyConfigIds do
        table.insert(storyIds,tonumber(storyConfigIds[i]))
    end
    
    LuaBridge.PlayStory(storyIds,playEnd)
  else
    if playEndCallBack then playEndCallBack() end
  end
end

function MonopolyModel:PlayStoryByMapPoint(currFloor,currStep,playEndCallBack)
  local storyKey = string.format("MONOPOLY_POINT_%s_%s",currFloor,currStep)

  local function callBack()
    if playEndCallBack then 
       playEndCallBack() 
    end
  end

  local function playEnd()
    GameEntry.Setting:SetInt(storyKey,1)
    callBack()
  end
  
  local value    = GameEntry.Setting:GetInt(storyKey,0)
  local configId = MakeJointKey(currFloor,currStep)
  local config   = MonopolyPointConfig.GetConfig(configId)
  
  if value > 0 or not config or config.story == "" then
     callBack() 
     return
  end

  local storyIds = {}
  local storyConfigIds = string.split(config.story,",")

  for i = 1,#storyConfigIds do
      table.insert(storyIds,tonumber(storyConfigIds[i]))
  end
  
  if #storyIds > 0 then
    LuaBridge.PlayStory(storyIds,playEnd)
  else
    callBack()
  end
end

function MonopolyModel:GetItemMessage(currFloor,currStep,itemList,randId)
  local message = ""
  local eventType = 0
  local configId = MakeJointKey(currFloor,currStep)
  local config   = MonopolyPointConfig.GetConfig(configId)

  if config ~= nil then
    message = config.desc
    eventType = tonumber(config.eventtype)
  end
  
  local itemDesc = ""
  for i,v in ipairs(itemList) do
    if v.id ~= nil and v.id ~= "" then
      local itemName = ""
      local itemConfig = self:GetItemConfig(tonumber(v.id))
  
      if itemConfig ~= nil then 
        itemName = itemConfig.name
      end
      
      itemDesc = string.format("%s<color=#00FFFF>[%sX%s]</color>",itemDesc,itemName,v.num)
    end
  end

  if eventType == self.EventType.Rand then
    message = string.format(self:GetRandDesc(randId),itemDesc)
  else
    message = string.format(message,itemDesc)
  end

  return message
end

return MonopolyModel