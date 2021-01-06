local AcSupplicateMgr   = class("AcSupplicateMgr",BaseManager)
local AcSupplicateModel = require("Modules/Activity/Supplicate/AcSupplicateModel")

--获取Infos
local GETACTIVITYINFO = "/TurnTableActivity/getActivityInfo"
--祈愿
local DEEPOCEANLOTTERY = "/TurnTableActivity/deepOceanLottery"

function AcSupplicateMgr:Logout()
    self.model = nil
    self.event = nil
end

function AcSupplicateMgr:GetModel()
    return self.model
end

function AcSupplicateMgr:GetEvent()
    return self.event
end

function AcSupplicateMgr:Login()
    print("AcSupplicateMgr:Login")
    self.model = AcSupplicateModel.new()
    self.event = 
    {
        SupplicateInfoEvent  = Event.new(),
        UpdateTaskInfoEvent = Event.new(),
        GetRandRewardEvent = Event.new(),
    }
end

function AcSupplicateMgr:ReqSupplicateInfo(act_id)
    local form = CS.UnityEngine.WWWForm()
    form:AddField("act_id", act_id)
    WebRequest.SendRequest(GETACTIVITYINFO,form,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        print_r(data)
        self.model:InitInfos(data)
        self.event.SupplicateInfoEvent:Invoke()
    end)
end

function AcSupplicateMgr:ReqSupplicate(act_id)
    local form = CS.UnityEngine.WWWForm()
    form:AddField("act_id", act_id)
    WebRequest.SendRequest(DEEPOCEANLOTTERY,form,function(serverdata)
        local data = JsonDecode(serverdata.rawData)
        print_r(data)
        self.model:UpdateRewardList(data.info)
        self.event.GetRandRewardEvent:Invoke()
        DarkBoomUtility.ShowRewardUIForm(serverdata.user)
    end)
end

function AcSupplicateMgr:HaveRedPoint()
    return self.model:HaveRedPoint()
end

return AcSupplicateMgr

