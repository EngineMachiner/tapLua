
local Vector = Astro.Vector             local isVector = Vector.isVector

local spaceAxes = Vector.spaceAxes          local isNumber = Astro.Type.isNumber

local componentDivision = Vector.componentDivision

local function ceil(x)

    for i,v in ipairs(spaceAxes) do x[v] = math.ceil( x[v] ) end             return x

end


-- I'm not liking this vector value conversion when it's a number. :(

local function value(x) return isNumber(x) and Vector(x) or x end

-- Returns the vector of elements that fits within a length depending on the size.

local function quantityIn( x, size )

    local isNumber = isNumber(x) and isNumber(size)         x = value(x)        size = value(size)

    x = componentDivision( x, size )            return isNumber and ceil(x).x or ceil(x)

end


-- Returns the sum of the offsets needed to center elements based on the vector quantityIn.

local function centerOffset( quantityIn )

    local n = quantityIn            local isNumber = isNumber(n)        n = value(n)

    
    local half = n * 0.5        half = ceil(half)

    local even = n + Vector( 1, 1 )     even = even % 2     even = even * 0.5


    if isNumber then half = half.x      even = even.x end          return half + even

end


return { quantityIn = quantityIn,       centerOffset = centerOffset }