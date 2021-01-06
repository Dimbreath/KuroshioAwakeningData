require "Core/FunctionHelper"
require "Core/oop"
require "Core/Event"
require "Core/try_catch_finally"
require "Core/TableHelper"
require "Core/StringHelper"
require "Common/GameGlobal"
require "Common/BaseForm"
require "Common/BaseManager"
require "Lua4CSharp"
JSON        = require("Core/dkjson")
print       = print_log
Game        = require "Game"
inspect     = require("Core/inspect")



local function main()
    lang_id = 0
    print("luascript model : lua entry init!!!")
    Game:Init()
end

main()



