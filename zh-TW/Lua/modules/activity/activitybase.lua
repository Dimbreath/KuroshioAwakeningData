-- ------------示例--------------------------
-- local ActivityBase = class("ActivityBase")
-- function ActivityBase:OnInit(gameObject,mask)
--     self.injections = ParseInjections(gameObject)
--     self.mask = mask
--     self.gameObject = gameObject
-- end

-- function ActivityBase:OnOpen(tagId)
--     self.tagId = tagId
-- end

-- function ActivityBase:SetActive(show)
--     self.gameObject:SetActive(show);
-- end

-- function ActivityBase:OnRelease()
--     -- print("OnRelease")
--     -- if not self.injections then return end

--     -- for k,v in pairs(self.injections) do
--     --     print(k,v.name)
--     -- end
-- end
    
-- return ActivityBase