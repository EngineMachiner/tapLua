
-- Returns the first table containing the values that are also in the second one.

local astro = Astro.Table

return function( a, b, distinct )

    local t = {}

    local function isValid( k, v )

        local isDistinct = distinct and astro.contains( t, v )

        if t[k] or isDistinct then return end
        

        local key, val = k, v

        for k,v in pairs(b) do if val == v then return true end end
    
    end

    for k,v in pairs(a) do if isValid( k, v ) then t[k] = v end end           return meta( t, a )

end