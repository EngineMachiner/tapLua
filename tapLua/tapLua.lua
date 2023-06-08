
tapLua = { Path = "Appearance/Themes/_fallback/Modules/tapLua/" }

tapLua.OutFox = {}

local loadedFirst = {
    "OutFox/FileManager.lua",       "Data Structures/Table.lua"
}

for _, path in ipairs(loadedFirst) do LoadModule( "tapLua/" .. path ) end

tapLua.OutFox.FILEMAN.LoadModules( tapLua.Path, loadedFirst )