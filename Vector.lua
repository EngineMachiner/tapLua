
local Vector = Astro.Vector

local directions = {

	Left = Vector( -1, 0 ),			Right = Vector( 1, 0 ),
	Up = Vector( 0, -1 ),			Down = Vector( 0, 1 ),

	UpLeft = Vector( -1, -1 ),		UpRight = Vector( 1, -1 ),
	DownLeft = Vector( -1, 1 ),		DownRight = Vector( 1, 1 )

}

for k,v in pairs(directions) do directions[k] = Vector.unit(v) end


-- Wrap the Vector constructor.

local meta = getmetatable(Vector)        local __call = meta.__call

meta.__call = function( Vector, ... )
    
    local name = ...        local direction = directions[name]

    return direction and direction:copy() or __call( Vector, ... )

end
