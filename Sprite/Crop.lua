
local Vector = Astro.Vector         local planeAxes = Vector.planeAxes

local function matrixCrops( pos, size, offset )

    pos = pos - 1           local left = pos * size         
    
    pos = pos + 1           local right = 1 - pos * size
    
    return { left - offset,     right - offset }

end

local crops = {

    -- The returned value can be set for both horizontally or vertically and it's cropped centered based on the layer.

    Centered = function( i, layers )
    
        -- Multiplied by 2 because it's the cropping on both sides.
    
        local n = layers + 1        n = n * 2       return i / n
    
    end,

    Matrix = function( matrix, pos, offset )
        
        local size = 1 / matrix         local crops = {}          offset = offset or 0

        for i,v in ipairs(planeAxes) do crops[v] = matrixCrops( pos[v], size[v], offset ) end

        return crops

    end

}

return crops[...]