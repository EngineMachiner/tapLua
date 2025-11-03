
local isLegacy = tapLua.isLegacy()          if not isLegacy then return end


-- Load scripts in legacy. If this causes conflicts let me know.

local function loadModule( path, ... )

    path = "Modules/" .. path           local f = loadfile(path)
    
    if not f then error( "Failed to load file: " .. path ) end          return ... and f(...) or f()

end

LoadModule = LoadModule or loadModule