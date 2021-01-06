local BellDeerManager = class("BellDeerManager", BaseManager)
local BellDeerModel = require("Modules/Activity/BellDeer/BellDeerModel")

--获取翻牌数据
local GET_ACTIVITY_INFO = "/christmasActivity/ChristmasActivityInfo"
--翻牌
local CLICK_CARD = "/christmasActivity/playChristmasActivity"
--领取阶段任务奖励
local GET_REWARD = "/christmasActivity/ChristmasActivityReward"
--领取终极奖励
local GET_FINAL_REWARD = "/christmasActivity/ChristmasActivityFinal"

function BellDeerManager:Logout()
    self.model = nil
    self.event = nil
end

function BellDeerManager:GetModel()
    return self.model
end

function BellDeerManager:GetEvent()
    return self.event
end

function BellDeerManager:Login()
    print("BellDeerManager:Login")
    self.model = BellDeerModel.new()

    self.event = {
        BellDeerInfoEvent = Event.new(),
        BellDeerUpdateGridEvent = Event.new(),
        BellDeerGetRewardEvent = Event.new(),
        BellDeerGetFinalRewardEvent = Event.new(),
        BellDeerUpdateRewardEvent = Event.new()
    }
end

function BellDeerManager:GetBellDeerActivityInfo()
    WebRequest.SendRequest(
        GET_ACTIVITY_INFO,
        nil,
        function(serverdata)
            local data = JsonDecode(serverdata.rawData)
            self.model:InitInfo(data)
            self.event.BellDeerInfoEvent:Invoke()
        end
    )
end

--翻牌
function BellDeerManager:FlipCard(cardId)
    local form = CS.UnityEngine.WWWForm()
    form:AddField("grid", cardId)

    WebRequest.SendRequest(
        CLICK_CARD,
        form,
        function(serverdata)
            local data = JsonDecode(serverdata.rawData)
            if (data.err_code == nil) then
                --print_log("成功翻开")
                --self.model:UpdateData(data)
                self.event.BellDeerUpdateGridEvent:Invoke(data, serverdata.user)
            end
        end
    )
end

function BellDeerManager:GetReward(plotId, id)
    local form = CS.UnityEngine.WWWForm()
    form:AddField("id", id)
    form:AddField("plotId", plotId)

    WebRequest.SendRequest(
        GET_REWARD,
        form,
        function(serverdata)
            local data = JsonDecode(serverdata.rawData)
            if (data.err_code == nil) then
                --print_log("成功领取")
                self.model:UpdateStepRewardData(data)
                self.event.BellDeerGetRewardEvent:Invoke(plotId, id)
                DarkBoomUtility.ShowRewardUIForm(serverdata.user)
            end
        end
    )
end

function BellDeerManager:GetFinalReward()
    local form = CS.UnityEngine.WWWForm()

    WebRequest.SendRequest(
        GET_FINAL_REWARD,
        form,
        function(serverdata)
            local data = JsonDecode(serverdata.rawData)
            if (data.err_code == nil and data.status == 1) then
                --print_log("成功领取")
                --self.model:UpdateStepRewardData(data)
                self.model:UpdateFinalRewardStatus()
                self.event.BellDeerGetFinalRewardEvent:Invoke(serverdata.user)
            end
        end
    )
end

function BellDeerManager:HaveRedPoint()
    if self.model == nil then
        return false
    end
    return self.model:HasAction()
end

return BellDeerManager
