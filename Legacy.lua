
local isLegacy = tapLua.isLegacy()          if not isLegacy then return end


-- Load scripts in legacy. If this causes conflicts let me know.

local function loadModule( path, ... )

    local f = loadfile( "Modules/" .. path )            return ... and f(...) or f()

end

LoadModule = LoadModule or loadModule