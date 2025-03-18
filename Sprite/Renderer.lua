
-- Returns the rows and columns of sprites to cover the screen.

local function screenMatrix(self)

    local scale = SCREEN_HEIGHT / 720           local size = self:GetZoomedSize() * scale

    local rows = SCREEN_HEIGHT / size.y         local columns = SCREEN_WIDTH / size.x

    rows = math.ceil(rows)          columns = math.ceil(columns)

    return rows, columns

end

return tapLua.Sprite {
    
    InitCommand=function(self)
    
        tapLua.Sprite.Renderer = self           self.screenMatrix = screenMatrix
    
        self:diffusealpha(0)

    end
    
}