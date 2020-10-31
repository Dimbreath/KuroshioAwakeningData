local uimgr = {}
uimgr.enable_log = nil
function uimgr.patch_ugui_form(ugui_form, ui_path, func_name, ...)
	if uimgr.enable_log then
		local func_param = {...}
		local func_param_str = "["
		for i, v in pairs(func_param) do
			func_param_str = func_param_str..v..","
		end
		func_param_str = func_param_str.."]"
		print(string.format("uimgr.patch_ugui_form, ugui_form=%s, ui_path=%s, func_name=%s, func_param=%s", ugui_form, ui_path, func_name, func_param_str ))
	end
	
	local call_succ = false
	if ui_path == "Assets/GameMain/UI/UIForms/MailForm.prefab.del" and func_name == "PlayOpenAni" then	
		local scale = ugui_form.transform.localScale 		
		scale.x = 1.2		
		ugui_form.transform.localScale  = scale		
		ugui_form:PlayOpenAniComplete()		
		call_succ = true		
	elseif ui_path == "xxxxxxxx" and func_name == "yyyyyyyy" then
		call_succ = true
	else
		call_succ = false
	end
	return call_succ

end

function uimgr.collectgarbage()
	collectgarbage()
end
return uimgr

