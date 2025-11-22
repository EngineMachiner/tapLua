
-- Gets the smallest power of two number (2^x) that is greater than or equal to the input number 'n'.

local function nextPowerOfTwo(n) -- For Lua 5.1.

    n = math.floor(n) -- Make sure it's an integer.

    if n <= 1 then return 1 end -- Edge cases: 0 and 1

    local p = 1             while p < n do p = p * 2 end            return p

end

local function safeDivision( a, b ) return b ~= 0 and a / b or 0 end
local function safeModulo( a, b ) return b ~= 0 and a % b or 0 end

return { nextPowerOfTwo = nextPowerOfTwo,           safeDivision = safeDivision,    safeModulo = safeModulo }