
local astro = Astro.Table


local coords = { 'x', 'y', 'z' }

local function normSqr(a)

    local b = 0         for k,v in pairs(coords) do b = b + a[v] ^ 2 end

    return b

end

local function norm(a)
    
    local normSqr = normSqr(a)          return math.sqrt(normSqr) 

end

local function copy(a)

    local meta = getmetatable(a)        local b = setmetatable( {}, meta )

    for k,v in pairs(coords) do b[v] = a[v] end         return b

end

local function unit(a)
    
    local norm = norm(a)

	for i,v in ipairs(coords) do
        
        local k = v         v = a[v]
        
        if v and v ~= 0 then a[k] = v / norm end 
    
    end

	return a

end

local function isZero(a)

    for i,v in ipairs(coords) do 
        
        if a[v] ~= 0 then return false end 
    
    end

    return true

end

local function unpack(a) return a.x, a.y, a.z end

-- Get angle from a vector in degrees.

local function angle(a)

	local vector = copy(a)      vector = unit(vector)
    
    local x, y = unpack(vector)         local angle = math.atan( y / x )
    
    angle = math.deg(angle)         return angle % 360

end


return {

    normSqr = normSqr,              norm = norm,
    unit = unit,                    isZero = isZero,
    angle = angle,                  unpack = unpack,
    copy = copy

}