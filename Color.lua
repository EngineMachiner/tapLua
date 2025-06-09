
local astro = Astro.Type        local isNumber = astro.isNumber         local isTable = astro.isTable

astro = Astro.Table

local function isColor(a)

    if not isTable(a) or #a ~= 4 then return false end

    -- It's a color if it doesn't find any non numbers.

    local function isValid( k, v ) return not isNumber(v) end

    return not astro.contains( a, isValid )

end

local function random(s, v)

    local h = math.random(0, 360)       s = s or 1          v = v or 1

    return HSV( h, s, v )

end

tapLua.Color = { isColor = isColor, random = random }