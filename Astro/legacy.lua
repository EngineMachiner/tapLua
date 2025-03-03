
table.pack = table.pack or function(...)

    local n = select( "#", ... )        return { n = n, ... }

end

table.unpack = table.unpack or function( t, i, j )

    i = i or 1          j = j or #t         return unpack(t, i, j)

end