
local function cropHorizontally( self, float ) self:cropleft(float):cropright(float) end
local function cropVertically( self, float ) self:croptop(float):cropbottom(float) end

local function fadeHorizontally( self, float ) self:fadeleft(float):faderight(float) end
local function fadeVertically( self, float ) self:fadetop(float):fadebottom(float) end

local function invertedMaskDest(self) self:MaskDest():ztestmode("ZTestMode_WriteOnFail") end

local t = {

    cropHorizontally = cropHorizontally,        cropVertically = cropVertically,
    fadeHorizontally = fadeHorizontally,        fadeVertically = fadeVertically,

    invertedMaskDest = invertedMaskDest

}

local actor = tapLua.Actor          Astro.Table.merge( actor, t )