
-- Considering if should use it to invert the parameters as an alternative for contains() compare function.
-- local function invertParameters( f ) return function(a, b) return f(b, a) end end

-- Just for the contains function.
local function equal( value1, value2 ) return value1 == value2 end

-- Returns key if found.
local function contains( tbl, value, compare )

	if not compare then compare = equal end

	if type(value) == "table" then

		for k,v in pairs(tbl) do for a,b in pairs(value) do
			if compare( v, b ) then return k end
		end end

		return false

	end

	for k,v in pairs(tbl) do if compare( v, value ) then return k end end

	return false

end

-- Remove duplicated values in a indexed table.
local function cleanDuplicates(tbl)

	local output = {}		DeepCopy( tbl, output )
	
	for k,v in ipairs(tbl) do
		local index = contains( output, v )
		if not index then output[#output+1] = v end
		tbl[k] = nil
	end

	for k,v in ipairs(output) do tbl[k] = v end

end

local function store( to, from )

	for k,v in pairs( from ) do

		local stored = to[k]
		if not stored then to[k] = v else store( stored, from[k] ) end

	end

end

tapLua.store = store

tapLua:store {

	Table = {
		equal = equal,		contains = contains, 		
		cleanDuplicates = cleanDuplicates,		store = store
	}

}