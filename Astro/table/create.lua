--[[

    This is basically a table factory.

    Returns a function to create a table that could 
    have the table functions by default.

    Be aware that it overrides the __index metamethod.

]]

local astro = Astro.Table.Meta

return function(input)

    return function(t)
        
        t = t or {}         local table = astro.table(input)        return meta.setIndex( t, table )
    
    end
    
end
