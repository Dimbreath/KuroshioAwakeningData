function class(classname, super)
	local superType = type(super)
	local cls
	if superType ~= 'function' and superType ~= 'table' then
		superType = nil
		super = nil
	end
	
	if superType == 'function' or (super and super.__ctype == 1) then
		-- inherited from native C++ Object
		cls = {}
		if superType == 'table' then
			-- copy fields from super
			for k,v in pairs(super) do cls[k] = v end
			cls.__create = super.__create
			cls.super = super
		else
			cls.__create = super
			cls.ctor = function() end
		end
		cls.__cname = classname
		cls.__ctype = 1
		cls.__instanceId = 0
		function cls.new(...)
			local instance = cls.__create(...)
			-- copy fields from class to  native object
			for k, v in pairs(cls) do instance[k] = v end
			instance.class = cls
			instance:ctor(...)
			cls.__instanceId = cls.__instanceId +1
			instance.__instanceId = cls.__instanceId 
			return instance
		end
	else
		-- inherited from Lua Object
		if super then
			cls = {}
			setmetatable(cls, {__index = super})
			cls.super = super
		else
			cls = {ctor = function() end}
		end

		cls.__cname = classname
		cls.__ctype = 2 --lua
		cls.__index = cls
		cls.__instanceId = 0
		
		function cls.new(...)
			local instance = setmetatable({}, cls)
			instance.class = cls
			instance:ctor(...)
			cls.__instanceId = cls.__instanceId +1
			instance.__instanceId = cls.__instanceId
			return instance
		end
	end
	return cls
end

function import(moduleName, currentModuleName)
    local currentModuleNameParts
    local moduleFullName = moduleName
    local offset = 1

    while true do
        if string.byte(moduleName, offset) ~= 46 then -- .
            moduleFullName = string.sub(moduleName, offset)
            if currentModuleNameParts and #currentModuleNameParts > 0 then
                moduleFullName = table.concat(currentModuleNameParts, ".") .. "." .. moduleFullName
            end
            break
        end
        offset = offset + 1

        if not currentModuleNameParts then
            if not currentModuleName then
                local n,v = debug.getlocal(3, 1)
                currentModuleName = v
            end

            currentModuleNameParts = string.split(currentModuleName, ".")
        end
        table.remove(currentModuleNameParts, #currentModuleNameParts)
    end

    return require(moduleFullName)
end