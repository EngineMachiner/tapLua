
-- Actor functions to return variable arguments or vector objects.

local astro = Astro.Type            local isFunction = astro.isFunction

astro = Astro.Table


local Vector = Astro.Vector -- Default builder => Simple operations.

local function builder( input )

    if not input then return Vector end         if isFunction(input) then return input end

end

-- Generic getter...

local function get( input, ... )

    local Vector = builder(input)                   local a, b, c = ...

    if not Vector then return a, b, c end           return Vector( a, b, c )

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


local function GetZoomVector( self, input )

    return get( input, self:GetZoomX(), self:GetZoomY(), self:GetZoomZ() )

end

local function GetPos( self, input )

    return get( input, self:GetX(), self:GetY(), self:GetZ() )

end

local function GetDest( self, input )

    return get( input, self:GetDestX(), self:GetDestY(), self:GetDestZ() )

end


local function setRotation( self, vector )
    
    local x, y, z = vector:unpack()         return self:rotationx(x):rotationy(y):rotationz(z)

end

local function setSizeVector( self, vector ) return self:setsize( vector:unpack() ) end

local function setZoomVector( self, vector ) 
    
    local x, y, z = vector:unpack()         return self:zoomx(x):zoomy(y):zoomz(z)

end

local function addPos( self, vector )

    local x, y, z = vector:unpack()         return self:addx(x):addy(y):addz(z)

end

local function setPos( self, vector )
    
    local x, y, z = vector:unpack()         return self:x(x):y(y):z(z)

end

local function setEffectMagnitude( self, vector ) return self:effectmagnitude( vector:unpack() ) end

local function swapSize(self) return self:setsize( self:GetHeight(), self:GetWidth() ) end

local t = {
    
    GetRotationVector = GetRotationVector,      GetSize = GetSize,      GetZoomedSize = GetZoomedSize,
    
    GetCroppedZoomedSize = GetCroppedZoomedSize,        GetZoomVector = GetZoomVector,
    
    GetPos = GetPos,      GetDest = GetDest,


    setRotation = setRotation,          setSizeVector = setSizeVector,

    setZoomVector = setZoomVector,          setPos = setPos,        addPos = addPos,
    
    setEffectMagnitude = setEffectMagnitude,


    swapSize = swapSize

}

if tapLua.isLegacy() then t.xyz = function( self, x,y,z ) self:xy(x,y):z(z) end end

tapLua.Actor.Vector = t         astro.merge( tapLua.Actor, t )


-- Sprite functions.

local function scrollTexture( self, vector )

    vector = - vector       return self:texcoordvelocity( vector:unpack() )

end

local function moveTextureBy( self, vector ) return self:addimagecoords( vector:unpack() ) end

local t = { scrollTexture = scrollTexture,      moveTextureBy = moveTextureBy }

astro.merge( tapLua.Sprite, t )


local function imageSize( texture, input )

    return get( input, texture:GetImageWidth(), texture:GetImageHeight() )

end

local function sourceSize( texture, input )

    return get( input, texture:GetImageWidth(), texture:GetImageHeight() )

end

local function size( texture, input )
    
    return get( input, texture:GetTextureWidth(), texture:GetTextureHeight() )

end

tapLua.Texture = { imageSize = imageSize,      sourceSize = sourceSize,        size = size }