
local function setupDepth(self, FOV) self:Center():SetFOV(FOV):SetDrawByZPosition(true)         return self end

tapLua.ActorFrame.setupDepth = setupDepth