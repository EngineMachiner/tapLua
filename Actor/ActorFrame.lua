
local function setupDepth( self, fov )
    
    self:Center():SetDrawByZPosition(true):fov(fov)             return self

end

tapLua.ActorFrame.setupDepth = setupDepth