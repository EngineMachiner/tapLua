
--[[

    Returns the tile array like a spiral inwards based on the input matrix size.
    self is the ActorFrame parent used in Tile.lua.

]]

local matrix = ...

local t = {}          local columns = matrix.x


local i, v = 0, 0 -- Index and value counters.

local function add(new) i = new         v = v + 1         t[i] = v end


local pos = Astro.Vector( 1, 1 )          local lim = matrix:copy()

local function onRange(k) return pos[k] <= lim[k] end


local function traverse()

    -- Traverse left to right.

    for x = pos.x, lim.x do add( i + 1 ) end        pos.y = pos.y + 1

    if not onRange('x') then return end


    -- Traverse top to bottom.

    for y = pos.y, lim.y do add( i + columns ) end        lim.x = lim.x - 1

    if not onRange('y') then return end


    -- Traverse right to left.

    for x = lim.x, pos.x, -1 do add( i - 1 ) end        lim.y = lim.y - 1


    -- Traverse bottom to top.

    for y = lim.y, pos.y, -1 do add( i - columns ) end        pos.x = pos.x + 1

end

while onRange('x') and onRange('y') do traverse() end


return t