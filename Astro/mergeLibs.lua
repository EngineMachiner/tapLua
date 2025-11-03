
--[[

    Returns a table that contains some lib functions ( like the Lua table and string tables ) 
    from index number key values and adds any other functions that have a string key.

]]


local astro = Astro.Type        local isString = astro.isString         local isNumber = astro.isNumber

local isFunction = astro.isFunction

return function( input, lib )

    local t = {}

    local function add( k, v )

        local isValid1 = isNumber(k) and isString(v)
        local isValid2 = isString(k) and isFunction(v)

        local isValid = isValid1 or isValid2                if not isValid then return end
        
        if isValid1 then k = v      v = lib[v] end          t[k] = v

    end

    for k,v in pairs(input) do add( k, v ) end              return t

end