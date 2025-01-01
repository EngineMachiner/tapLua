
local path = "Appearance/Themes/_fallback/Modules/tapLua/"

if tonumber( VersionDate() ) < 20191216 then

    LoadModule = function(s) loadfile( "Scripts/" .. s )() end

    path = "/Scripts/tapLua/"
    
end

tapLua = { 
    
    Path = path,

    Load = function( path, ... )

        return LoadModule( "tapLua/" .. path .. ".lua", ... )

    end

}            
    
tapLua.OutFox = {}

-- These will be skipped on the LoadModules function.

local loadedFirst = {
    "OutFox/FileManager.lua",       "Data Structures/Table.lua"
}

for _, path in ipairs(loadedFirst) do LoadModule( "tapLua/" .. path ) end

loadedFirst[#loadedFirst+1] = "tapLua/Sprite"

tapLua.OutFox.FILEMAN.LoadModules( tapLua.Path, loadedFirst )