
-- Returns the rows and columns of sprites to cover the screen.

local Vector = Astro.Vector                 local planeAxes = Vector.planeAxes

local quantityIn = Astro.Layout.quantityIn

local function screenMatrix(self)

    local scale = SCREEN_HEIGHT / 720               local size = self:GetZoomedSize() * scale

    local screenSize = tapLua.screenSize()          return quantityIn( screenSize, size )

end

return tapLua.Sprite {
    
    InitCommand=function(self)
    
        tapLua.Sprite.Renderer = self           self.screenMatrix = screenMatrix
    
        self:diffusealpha(0)

    end
    
}