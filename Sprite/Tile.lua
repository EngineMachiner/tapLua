
local Vector = Astro.Vector             local offsets = Astro.Layout.centerOffsets


local input = ...          local zoom = input.Zoom          local Sprite = input.Sprite

local Texture = input.Texture                   local onPreload = input.onPreload


local Renderer = tapLua.Sprite.Renderer         Renderer:LoadBy(Texture):zoom(zoom)

if onPreload then onPreload() end               zoom = Renderer:GetZoom()


local matrix = Renderer:screenMatrix()          local offset = input.MatrixOffset or Vector()

if offset then matrix = matrix + offset end


local columns, rows = matrix:unpack()           offsets = offsets(matrix)


local t = tapLua.ActorFrame {
    
    InitCommand=function(self)

        self.Matrix = matrix            local size = Renderer:GetZoomedSize()
        
        self:setsize( size.x * columns, size.y * rows )         self:zoom(zoom):playcommand("PostInit")
    
    end

}

local function add( i, j )

    local k = #t + 1

    t[k] = tapLua.Sprite {

        Texture = Texture,

        InitCommand=function(self) self.Index = k end,

        PostInitCommand=function(self)

            local tilePos = Vector( i, j )                  self.TilePos = tilePos

            local w, h = self:GetSize(true)                 local half, even = offsets.half, offsets.even
            
            local offset = tilePos - half - even            local x, y = offset:unpack()
            
            local pos = Vector( w * x, h * y )              self:setPos(pos)
            
        end

    } .. Sprite

end

for j = 1, rows do for i = 1, columns do add( i, j ) end end

return t