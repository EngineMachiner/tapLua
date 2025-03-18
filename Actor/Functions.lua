
local function cropHorizontally( self, float ) self:cropleft(float):cropright(float) return self end
local function cropVertically( self, float ) self:croptop(float):cropbottom(float) return self end

local function fadeHorizontally( self, float ) self:fadeleft(float):faderight(float) return self end
local function fadeVertically( self, float ) self:fadetop(float):fadebottom(float) return self end

local function invertedMaskDest(self) self:MaskDest():ztestmode("ZTestMode_WriteOnFail") return self end

local t = {

    cropHorizontally = cropHorizontally,        cropVertically = cropVertically,
    fadeHorizontally = fadeHorizontally,        fadeVertically = fadeVertically,

    invertedMaskDest = invertedMaskDest

}

local actor = tapLua.Actor          Astro.Table.merge( actor, t )