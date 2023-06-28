
local path = "Appearance/Themes/_fallback/Modules/tapLua/"

if tonumber( VersionDate() ) < 20191216 then

    LoadModule = function(s) loadfile( "Scripts/" .. s )() end
    path = "/Scripts/tapLua/"
    
end

tapLua = { Path = path }            tapLua.OutFox = {}

local loadedFirst = {
    "OutFox/FileManager.lua",       "Data Structures/Table.lua"
}

for _, path in ipairs(loadedFirst) do LoadModule( "tapLua/" .. path ) end

tapLua.OutFox.FILEMAN.LoadModules( tapLua.Path, loadedFirst )