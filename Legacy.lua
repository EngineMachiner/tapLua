
local isLegacy = tapLua.isLegacy()

if not isLegacy then return end


-- Load scripts in legacy.

local function loadModule(path) return loadfile( "Modules/" .. path )() end

LoadModule = LoadModule or loadModule