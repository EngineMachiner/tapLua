
local function subChar( s, i ) return s:sub( i, i ) end

local function first(s) return subChar(s, 1) end

local function last(s) return subChar(s, #s) end

local function isEmpty(s) return #s == 0 end

local function isBlank(s)
    
    local clean = s:gsub(" ", "")        return isEmpty(clean)

end

local function startsWith( s1, s2 ) return s1:match( '^' .. s2 ) end

local function endsWith( s1, s2 ) return s1:match( s2 .. '$' ) end

local mergeLibs = require( Astro.Path .. "mergeLibs" )

return {

    subChar = subChar,      first = first,      last = last,

    isEmpty = isEmpty,          isBlank = isBlank,

    startsWith = startsWith,            endsWith = endsWith,

    string = function(input) return mergeLibs( input, string ) end

}