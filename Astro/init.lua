
local concat

local function info()

    local path = Astro.Path             local info = require( path .. "info" )
    
    local out = "Astro - Version Date: " .. info.VersionDate .. " - " .. info.ID

    print( out .. '\n\n' .. concat )

end


-- This is the main module loader.

local paths = { Vector = true }

local function name(key) return paths[key] and key or key:lower() end

local modules = { "Config", "Type", "String", "Table", "Vector", "Layout" }

local function subRequire()

    local path = Astro.Path         require( path .. "legacy" )

    for i,v in ipairs(modules) do
    
        local path = path .. name(v)          Astro[v] = require(path)

    end

    Astro.info = info

end


return function(path)

    Astro = {}          Astro.Path = path or './'           subRequire()
    
    local table = Astro.Table           concat = table.concat(Astro)

end