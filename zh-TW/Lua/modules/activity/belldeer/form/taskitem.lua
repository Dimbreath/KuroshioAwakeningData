local TaskItem = class("TaskItem")

function TaskItem:ctor(gameObject, id, name, reward)
    if IsGameObjectNull(gameObject) then
        print_error("gameObject == nil")
        return
    end
    self.id = id
    self.name = name
    self.num = 0
    self.reward = reward
    self.injections = ParseInjections(gameObject)
    self.gameObject = gameObject
    self:InjectComponent()
    self:Init()
end

function TaskItem:InjectComponent()
    self.NameTxt = self.injections.NameTxt
    self.NumTxt = self.injections.NumTxt
    self.PanelTextAnim = self.injections.PanelTextAnim
end

function TaskItem:Init()
    self.manager = Game:GetManager("BellDeerManager")
    self.model = self.manager:GetModel()
    self.event = self.manager:GetEvent()
    self.NameTxt.text = self.name .. "+" .. self.reward
    local taskList = self.model:GetTaskList()
    if taskList ~= nil then
        for i, v in pairs(taskList) do
            if v.id == self.id then
                self.num = v.got
            end
        end
    end
    self.NumTxt.text = tostring(self.num)
end

function TaskItem:RefreshUI(data)
    self.status = data.status
    if self.status == self.cardStatus.Opened then
        self.BgImg.gameObject:SetActive(true)
        self.CoverImg.gameObject:SetActive(false)
        self.BgBlurImg.gameObject:SetActive(false)
    elseif data.status == self.cardStatus.Covered then
        self.BgImg.gameObject:SetActive(false)
        self.CoverImg.gameObject:SetActive(true)
        self.BgBlurImg.gameObject:SetActive(true)
    else
    end
end

function TaskItem:PlayAnim(reversed)
    if reversed then
        for key, value in pairs(self.PanelTextAnim) do
            value.time = self.PanelTextAnim.clip.length
            value.speed = -1
        end
    else
        for key, value in pairs(self.PanelTextAnim) do
            value.time = 0
            value.speed = 1
        end
    end
    self.PanelTextAnim:Play("Activity_christmas_panelText_01")
end

function TaskItem:OnRelease()
end

return TaskItem
