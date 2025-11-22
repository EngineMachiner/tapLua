
local function isLegacy()

    local version = VersionDate()           version = tonumber(version)

    return version < 20191216

end

local function Load( path, ... )

    path = "tapLua/" .. path .. ".lua"          return LoadModule( path, ... )

end

local function resolvePath( path, stackLevel )

    stackLevel = stackLevel or 1            if not path then return end

    if path:Astro():startsWith("[\\/]") then return path end

    return ResolveRelativePath( path, stackLevel + 1 )

end

tapLua = { isLegacy = isLegacy,     Load = Load,    resolvePath = resolvePath }


local path = "Appearance/Themes/_fallback/Modules/tapLua/"

path = isLegacy() and "Modules/tapLua/" or path             tapLua.Path = path


local subPath = "tapLua/"

local p = path .. "Astro/"      require(p)(p)       dofile( path .. "Legacy.lua" )


-- Modules that need to be loaded ahead go here...

LoadModule( subPath .. "FileManager.lua" )          local FILEMAN = tapLua.FILEMAN


local blacklist = { "FileManager.lua", "Legacy.lua" } -- Excluded.

FILEMAN.LoadDirectory( path, blacklist )            FILEMAN.LoadModule( subPath .. "Actor/Actor.lua" )


local Vector = Astro.Vector

local function screenSize() return Vector( SCREEN_WIDTH, SCREEN_HEIGHT ) end

local function center() return Vector( SCREEN_CENTER_X, SCREEN_CENTER_Y ) end


local function spriteMatrix(path)

    local x, y = path:match("(%d+)x(%d+)")      local isValid = x and y

    if not isValid then return end          x = tonumber(x)         y = tonumber(y)

    return Vector( x, y )

end


local function scaleFOV( fov, scale )

    scale = scale or SCREEN_HEIGHT / 720            fov = math.rad(fov) / 2             fov = math.tan(fov) * scale

    fov = 2 * math.atan(fov)            return math.deg(fov)

end

local function verticalFOV(fov)
    
    local aspectRatio = GetScreenAspectRatio()          return scaleFOV( fov, 1 / aspectRatio )

end

local function depthOffset( x, z, fov )

    local direction = x == 0 and 0 or x / math.abs(x)
    
    local rad = math.rad( fov / 2 )             return x - z * direction * math.tan(rad)

end


local function currentBPM() return GAMESTATE:GetSongBPS() * 60 end

local t = { 
    
    screenSize = screenSize,    center = center,    spriteMatrix = spriteMatrix,

    scaleFOV = scaleFOV,            verticalFOV = verticalFOV,          depthOffset = depthOffset,

    currentBPM = currentBPM

}

Astro.Table.merge( tapLua, t )