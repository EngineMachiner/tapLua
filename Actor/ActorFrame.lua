
local function setupDepth(self, fov)
    
    local scale = SCREEN_HEIGHT / 720           fov = tapLua.scaleFOV( fov, scale )

    self:Center():SetFOV(fov):SetDrawByZPosition(true)         return self

end

tapLua.ActorFrame.setupDepth = setupDepth