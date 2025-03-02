
local concat

local function info()

    local path = Astro.Path             local info = require( path .. "info" )
    
    local out = "Astro - Version Date: " .. info.VersionDate .. " - " .. info.ID

    print( out .. '\n\n' .. concat )

end

local modules = { "Config", "Type", "String", "Table" }

local function subRequire()

    local path = Astro.Path

    for i,v in ipairs(modules) do
    
        local path = path .. v:lower()          Astro[v] = require(path)

    end

    Astro.info = info

end

return function(path)

    Astro = {}          Astro.Path = path or './'           subRequire()
    
    local table = Astro.Table           concat = table.concat(Astro)

end