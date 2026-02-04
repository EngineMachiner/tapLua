
local function isLegacy()

    if not VersionDate then return true end -- Etterna.

    local version = VersionDate()           version = tonumber(version)

    return version < 20191216

end

local function Load( path, ... )

    path = "tapLua/" .. path .. ".lua"          return LoadModule( path, ... )

end

local function startsWith(s) return s:Astro():startsWith("[\\/]") end

local FAILED_TO_RESOLVE_MESSAGE = "Failed to resolve path. Try not returning a tail call."

local function resolvePath( path, stackLevel )

    stackLevel = stackLevel or 1            if not path then return end

    if startsWith(path) then return path end


    local path = ResolveRelativePath( path, stackLevel + 1 )

    if not path then error( FAILED_TO_RESOLVE_MESSAGE ) end
    

    if not startsWith(path) then path = "/" .. path end

    return path

end

tapLua = { isLegacy = isLegacy,     Load = Load,    resolvePath = resolvePath }


local path = "Appearance/Themes/_fallback/Modules/tapLua/"

path = isLegacy() and "Modules/tapLua/" or path             tapLua.Path = path


local subPath = "tapLua/"

local p = path .. "Astro/"      require(p)(p)       dofile( path .. "Legacy.lua" )


-- Modules that need to be loaded ahead go here...

LoadModule( subPath .. "FileManager.lua" )          local FILEMAN = tapLua.FILEMAN


local blacklist = { "FileManager.lua", "Legacy.lua", "Theme.lua" } -- Excluded.

FILEMAN.LoadDirectory( path, blacklist )            FILEMAN.LoadModule( subPath .. "Actor/Actor.lua" )

FILEMAN.LoadModule( subPath .. "Theme.lua" )


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

local function shadersEnabled()
    
    local p = "CustomShadersDisabled" -- Shaders are supported in newer OutFox builds only.

    return PREFSMAN:PreferenceExists(p) and not PREFSMAN:GetPreference(p)

end

local t = { 
    
    screenSize = screenSize,    center = center,    spriteMatrix = spriteMatrix,

    scaleFOV = scaleFOV,            verticalFOV = verticalFOV,          depthOffset = depthOffset,

    currentBPM = currentBPM,        shadersEnabled = shadersEnabled

}

Astro.Table.merge( tapLua, t )