
local function draworder( self, x ) self.drawOrder = x      return Actor.draworder( self, x ) end

local function cropHorizontally( self, float ) return self:cropleft(float):cropright(float) end
local function cropVertically( self, float ) return self:croptop(float):cropbottom(float) end

local function fadeHorizontally( self, float ) return self:fadeleft(float):faderight(float) end
local function fadeVertically( self, float ) return self:fadetop(float):fadebottom(float) end

local function invertedMaskDest(self) return self:MaskDest():ztestmode("ZTestMode_WriteOnFail") end

local function aspectRatio(self) return self:GetZoomedWidth() / self:GetZoomedHeight() end

local function queueCommands( self, commands )
    
    for k,v in pairs(commands) do self:queuecommand(v) end          return self

end

local t = {

    draworder = draworder,
    cropHorizontally = cropHorizontally,        cropVertically = cropVertically,
    fadeHorizontally = fadeHorizontally,        fadeVertically = fadeVertically,
    invertedMaskDest = invertedMaskDest,        aspectRatio = aspectRatio,
    queueCommands = queueCommands

}

local actor = tapLua.Actor          Astro.Table.merge( actor, t )