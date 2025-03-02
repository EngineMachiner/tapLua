
local function isLegacy()

    local version = VersionDate()           version = tonumber(version)

    return version < 20191216

end

local function Load( path, ... )

    path = "tapLua/" .. path .. ".lua"          return LoadModule( path, ... )

end

tapLua = { isLegacy = isLegacy,     Load = Load }


local path = "Appearance/Themes/_fallback/Modules/tapLua/"

path = isLegacy() and "Scripts/tapLua/" or path

tapLua.Path = path


local astroPath = path .. "Astro/"            require(astroPath)(astroPath)

dofile( path .. "Legacy.lua" )


local subPath = "tapLua/"

-- Modules that need to be loaded ahead go here...

LoadModule( subPath .. "FileManager.lua" )


local FILEMAN = tapLua.FILEMAN

-- Exclude tapLua.lua because it would loop forever.
-- Exclude scripts already loaded.

local blacklist = { 
    
    path .. "FileManager.lua",              path .. "Legacy.lua",
    path .. "Sprite",

    "/Astro", "/tapLua.lua"

}

FILEMAN.LoadDirectory( path, blacklist )