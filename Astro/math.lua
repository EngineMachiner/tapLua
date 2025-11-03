
local function safeDivision( a, b ) return b ~= 0 and a / b or 0 end
local function safeModulo( a, b ) return b ~= 0 and a % b or 0 end

return { safeDivision = safeDivision,    safeModulo = safeModulo }