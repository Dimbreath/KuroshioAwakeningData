local AcNewYearEvent   = class("AcNewYearEvent")

local Event = Event

function AcNewYearEvent:ctor()
    self.RefreshNewYearInfo = Event.new()
    self.OpenLevelForm = Event.new()
    self.SetFormation = Event.new()
    self.StartBattle = Event.new()
    self.EndBattle = Event.new()
    self.MoralePayBtnSateRefresh = Event.new()
    self.TurnInResourceFinish = Event.new()
    self.RefreshRankList = Event.new()
    self.RefreshAwardCd = Event.new()
    self.UpdateBossInfo = Event.new()
    self.GetFinalReward = Event.new()
    self.RefreshBuff = Event.new()
end

return AcNewYearEvent