
xlua.hotfix(CS.DarkBoom.SpriteFeatureLine, 'Init', function(self)
    printlog("Fix!---")
    self.arrow = self.m_Tra.gameObject:GetComponent(typeof(Image))
    if (self.m_SpriteFeatureBaseList.FeatureType == 10) then
        self.arrow.color = Color(1,1,1,0)
    else
        self.arrow.color = Color(1,1,1,0.5)
    end
end)
