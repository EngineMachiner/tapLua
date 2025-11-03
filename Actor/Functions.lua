
local function cropHorizontally( self, float ) self:cropleft(float):cropright(float) return self end
local function cropVertically( self, float ) self:croptop(float):cropbottom(float) return self end

local function fadeHorizontally( self, float ) self:fadeleft(float):faderight(float) return self end
local function fadeVertically( self, float ) self:fadetop(float):fadebottom(float) return self end

local function invertedMaskDest(self) self:MaskDest():ztestmode("ZTestMode_WriteOnFail") return self end

local function aspectRatio(self) return self:GetZoomedWidth() / self:GetZoomedHeight() end

local function queueCommands( self, commands ) for k,v in pairs(commands) do self:queuecommand(v) end end

local t = {

    cropHorizontally = cropHorizontally,        cropVertically = cropVertically,
    fadeHorizontally = fadeHorizontally,        fadeVertically = fadeVertically,
    invertedMaskDest = invertedMaskDest,        aspectRatio = aspectRatio,
    queueCommands = queueCommands

}

local actor = tapLua.Actor          Astro.Table.merge( actor, t )