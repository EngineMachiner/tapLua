
local function isBoolean(a) return type(a) == "boolean" end
local function isNumber(a) return type(a) == "number" end
local function isString(a) return type(a) == "string" end
local function isFunction(a) return type(a) == "function" end
local function isTable(a) return type(a) == "table" end
local function isNil(a) return a == nil end

return {

    isBoolean = isBoolean,          isNumber = isNumber,
    isString = isString,            isFunction = isFunction,
    isTable = isTable,              isNil = isNil

}
