
local Vector = Astro.Vector             local centerOffset = Astro.Layout.centerOffset

local isFunction = Astro.Type.isFunction


local input = ...          local zoom = input.Zoom          local Sprite = input.Sprite

local Texture = input.Texture                   local onPreload = input.onPreload

local Spiral = input.Spiral


local Renderer = tapLua.Sprite.Renderer         Renderer:LoadBy(Texture):zoom(zoom)

if onPreload then onPreload() end               zoom = Renderer:GetZoom()


local matrix = input.Matrix or Renderer:screenMatrix()

local columns, rows = matrix:unpack()           centerOffset = centerOffset(matrix)


local function spiralIndex(self)

    local matrix = self.TileParent.Spiral       local i = self.Index        return matrix[i]

end


local size = Renderer:GetZoomedSize()

local t = tapLua.ActorFrame {
    
    InitCommand=function(self)

        self.Matrix = matrix            self.Spiral = Spiral and tapLua.Load( "Sprite/Spiral", matrix )
        
        self:setsize( size.x * columns, size.y * rows )         self:zoom(zoom):playcommand("PostInit")

    end

}

local function add( i, j )

    local k = #t + 1

    local tbl = {

        Texture = Texture,

        InitCommand=function(self)
            
            self.spiralIndex = spiralIndex

            self.Index = k           self.TileParent = self:GetParent():GetParent()
        
        end,

        PostInitCommand=function(self)

            local tilePos = Vector( i, j )                  self.TilePos = tilePos

            local w, h = self:GetSize(true)                 local offset = tilePos - centerOffset
            
            local x, y = offset:unpack()                    local pos = Vector( w * x, h * y )
            
            self:setPos(pos)
            
        end

    }

    t[k] = tapLua.ActorFrame { tapLua.Sprite(tbl) .. Sprite }

end

for j = 1, rows do for i = 1, columns do add( i, j ) end end

return t