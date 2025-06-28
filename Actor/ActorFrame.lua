
local merge = Astro.Table.merge

local function setScaledFOV( self, fov )

    local scale = SCREEN_HEIGHT / 720           fov = tapLua.scaleFOV( fov, scale )
    
    return self:fov(fov)

end

local function setupDepth( self, fov )
    
    self:Center():SetDrawByZPosition(true):setScaledFOV(fov)             return self

end

local t = { setScaledFOV = setScaledFOV,        setupDepth = setupDepth }

merge( tapLua.ActorFrame, t )