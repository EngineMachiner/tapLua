
local function isLegacy()

    local version = VersionDate()           version = tonumber(version)

    return version < 20191216

end

local function Load( path, ... )

    path = "tapLua/" .. path .. ".lua"          return LoadModule( path, ... )

end

tapLua = { isLegacy = isLegacy,     Load = Load }


local path = "Appearance/Themes/_fallback/Modules/tapLua/"

path = isLegacy() and "Modules/tapLua/" or path

tapLua.Path = path


local astroPath = path .. "Astro/"            require(astroPath)(astroPath)

dofile( path .. "Legacy.lua" )


local subPath = "tapLua/"

-- Modules that need to be loaded ahead go here...

LoadModule( subPath .. "FileManager.lua" )


-- Exclude tapLua.lua because it would loop forever.
-- Exclude scripts already loaded.

local blacklist = { "FileManager.lua", "Legacy.lua", "tapLua.lua" }

tapLua.FILEMAN.LoadDirectory( path, blacklist )


LoadModule( subPath .. "Actor/Actor.lua" )


local Vector = Astro.Vector

local function screenSize()
    
    return Vector( SCREEN_WIDTH, SCREEN_HEIGHT ) 

end

local function center()
    
    return Vector( SCREEN_CENTER_X, SCREEN_CENTER_Y )

end

local function resolvePath( path, stackLevel )

    stackLevel = stackLevel or 2            if not path then return end

    if path:Astro():startsWith("[\\/]") then return path end

    return "/" .. ResolveRelativePath( path, stackLevel )

end

local t = { screenSize = screenSize,    center = center,    resolvePath = resolvePath }

Astro.Table.merge( tapLua, t )