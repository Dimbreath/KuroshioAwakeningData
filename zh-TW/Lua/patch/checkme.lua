--require 'patch/loginform_patch'
--require 'patch/logindatamgr_patch'
--require 'patch/mailform_patch'
--require 'patch/meshrawimage_patch'
--require 'patch/overviewform_patch'
--require 'patch/spritefeatureline_patch'
--require 'patch/monetaryform_patch'
--require 'patch/aimanager_patch'
--require 'patch/battlecharhead_patch'
--require 'patch/dockcardtemplate_patch'
--require 'patch/activitiesmgr_patch'
--require 'patch/lobbyform_patch'
--require 'patch/stagemsg_patch'
--require 'patch/darkboomutility_patch'
--require 'patch/procedureslg_patch'
--require 'patch/slgform_patch'
--require 'patch/playerdatacomponent_patch'
--require 'patch/fleetdatamgr'
--require 'patch/battlemanager_patch'
-- require 'patch/lobbyform_patch'
-- require 'patch/battlemodule_patch'
printlog('checkme init')
--require 'patch/activityuppoolinfo_patch'
--require 'patch/storyComponent_patch'
--require 'patch/gachadatamgr_patch'
--require 'patch/formationsingleitem_patch'


local function logout()
    printlog('checkme logout')
    --dialogform_patch.logout()
end

return 
{
    logout = logout,
}
