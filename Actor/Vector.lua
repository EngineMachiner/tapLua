
-- Actor functions to return variable arguments or vector objects.

local astro = Astro.Type

local isFunction = astro.isFunction

astro = Astro.Table


local Vector = Astro.Vector -- Default builder => Simple operations.

local function builder( input )

    if not input then return Vector end

    if isFunction(input) then return input end

end

-- Generic getter...

local function get( input, ... )

    local Vector = builder(input)       local a, b, c = ...

    if not Vector then return a, b, c end

    return Vector( a, b, c )

end

-- getrotation() exists haha.

local function GetRotationVector( self, input )

    return get( true, self:getrotation() )

end

local function GetSize( self, input )

    return get( input, self:GetWidth(), self:GetHeight() )

end

local function GetZoomedSize( self, input )

    return get( input, self:GetZoomedWidth(), self:GetZoomedHeight() )

end


local function GetCroppedZoomedSize( self, input )

    return get( input, self:GetCroppedZoomedWidth(), self:GetCroppedZoomedHeight() )

end

local GetCroppedZoomedSize = not tapLua.isLegacy() and GetCroppedZoomedSize


local function GetZoomCoords( self, input )

    return get( input, self:GetZoomX(), self:GetZoomY(), self:GetZoomZ() )

end

local function GetPos( self, input )

    return get( input, self:GetX(), self:GetY(), self:GetZ() )

end

local function GetDest( self, input )

    return get( input, self:GetDestX(), self:GetDestY(), self:GetDestZ() )

end


local function setRotation( self, vector )
    
    local x, y, z = vector:unpack()         self:rotationx(x):rotationy(y):rotationz(z)

    return self

end

local function setSizeVector( self, vector ) 
    
    self:setsize( vector:unpack() )         return self

end

local function setZoomVector( self, vector ) 
    
    local x, y, z = vector:unpack()         self:zoomto( x, y ):zoomz(z)

    return self

end

local function setPos( self, vector )
    
    self:xyz( vector:unpack() )             return self

end

local function setEffectMagnitude( self, vector ) return self:effectmagnitude( vector:unpack() ) end

local t = {
    
    GetRotationVector = GetRotationVector,

    GetSize = GetSize,      GetZoomedSize = GetZoomedSize,
    
    GetCroppedZoomedSize = GetCroppedZoomedSize,
    
    GetZoomCoords = GetZoomCoords,
    
    GetPos = GetPos,      GetDest = GetDest,


    setRotation = setRotation,          setSizeVector = setSizeVector,

    setZoomVector = setZoomVector,          setPos = setPos,        setEffectMagnitude = setEffectMagnitude

}

tapLua.Actor.Vector = t -- Will be removed in Actor.lua

astro.merge( tapLua.Actor, t )


-- Sprite

local function scrollTexture( self, vector )

    vector = - vector           self:texcoordvelocity( vector:unpack() )
    
    return self

end

local function moveTextureBy( self, vector )

    self:addimagecoords( vector:unpack() )          return self

end

local t = { scrollTexture = scrollTexture,      moveTextureBy = moveTextureBy }

astro.merge( tapLua.Sprite, t )
