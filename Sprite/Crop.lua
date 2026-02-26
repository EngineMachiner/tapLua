
local Vector = Astro.Vector         local planeAxes = Vector.planeAxes

local function axisCrops( pos, size, offset )

    local right = 1 - pos * size        pos = pos - 1       local left = pos * size
    
    return { left - offset,     right - offset }

end

local function statesCrops( pos, size )

    local right = pos * size        pos = pos - 1       local left = pos * size
    
    return { left, right }

end

local crops = {

    -- The returned value can be set for both horizontally or vertically and it's cropped centered based on the layer.

    Centered = function( i, layers )
    
        -- Multiplied by 2 because it's the cropping on both sides.
    
        local n = layers + 1        n = n * 2       return i / n
    
    end,

    Matrix = function( matrix, pos, offset )
        
        local size = 1 / matrix         local crops = {}          offset = offset or 0

        for i,v in ipairs(planeAxes) do crops[v] = axisCrops( pos[v], size[v], offset ) end

        return crops

    end,

    States = function(matrix)

        local i, j = matrix:unpack()        local size = 1 / matrix         local t = {}

        for j = 1, j do for i = 1, i do
        
            local x = statesCrops( i, size.x )        local y = statesCrops( j, size.y )

            t[#t+1] = { Frame = 0, { x[1], y[1] }, { x[2], y[2] } }
        
        end end

        return t        

    end

}

return crops[...]