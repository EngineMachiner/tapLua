
local input = ...         local path = input.Path          local zoom = input.Zoom

local Sprite = input.Sprite


local Vector = Astro.Vector

local renderer = tapLua.Sprite.Renderer

renderer:Load(path):zoom(zoom)

local rows, columns = renderer:screenMatrix()


local t = tapLua.ActorFrame {
    
    InitCommand=function(self) self:zoom(zoom):queuecommand("PostInit") end 

}

local function ceil(a) return math.ceil( a * 0.5 ) end

local function add( i, j )

    t[#t+1] = tapLua.Sprite {

        Texture = path,

        PostInitCommand=function(self)

            self.Row, self.Column = i, j
            

            local w, h = self:GetSize(true)

            local offset = Vector( rows + 1, columns + 1 ) % 2
            
            offset = offset * 0.5

            local i = i - ceil(rows) - offset.x
            local j = j - ceil(columns) - offset.y

            local pos = Vector( w * j, h * i )

            self:setPos(pos)


            local p = self:GetParent()
            
            local size = p:GetSize() + self:GetSize()

            p:setSizeVector(size)
            
        end

    } .. Sprite

end

for i = 1, rows do for j = 1, columns do add( i, j ) end end

return t