
local function subChar( s, i ) return s:sub( i, i ) end

local function first(s) return subChar(s, 1) end

local function last(s) return subChar(s, #s) end

local function isEmpty(s) return #s == 0 end

local function isBlank(s)
    
    local clean = s:gsub(" ", "")        return isEmpty(clean)

end

local function startsWith( s1, s2 ) return s1:match( '^' .. s2 ) end

local function endsWith( s1, s2 ) return s1:match( s2 .. '$' ) end

local t = {

    subChar = subChar,      first = first,      last = last,        isEmpty = isEmpty,
    
    isBlank = isBlank,      startsWith = startsWith,        endsWith = endsWith

}

string.Astro = function(s)

    local __index = function( table, key )
        
        local f = t[key]        if not f then return end

        return function( table, ... ) return f( s, ... ) end
    
    end

    local setIndex = Astro.Table.Meta.setIndex          return setIndex( {}, __index )

end

return t