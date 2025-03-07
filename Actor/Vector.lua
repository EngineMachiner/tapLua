
-- Actor functions to return variable arguments or vector objects.

local astro = Astro.Type

local isFunction = astro.isFunction


-- Default builder => Simple operations.

local Vector = tapLua.Vector.builder()

local function builder( input )

    if not input then return end


    local isDefault = not isFunction(input)

    if isDefault then return Vector end

    
    return input

end

-- Generic getter...

local function get( input, ... )

    local Vector = builder(input)       local a, b, c = ...

    return Vector and Vector( a, b, c ) or a, b, c

end

-- getrotation() exists haha.

local function GetRotationVector( self, input )

    return get( input, self:getrotation() )

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

end

local function setSizeVector( self, vector ) self:setsize(  vector:unpack()  ) end

local function setZoomVector( self, vector ) 
    
    local x, y, z = vector:unpack()         self:zoomto( x, y ):zoomz(z)

end

local function setPos( self, vector )
    
    local x, y, z = vector:unpack()         self:xy( x, y ):z(z)

end


local t = {
    
    GetRotationVector = GetRotationVector,

    GetSize = GetSize,      GetZoomedSize = GetZoomedSize,
    
    GetCroppedZoomedSize = GetCroppedZoomedSize,
    
    GetZoomCoords = GetZoomCoords,
    
    GetPos = GetPos,      GetDest = GetDest,


    setRotation = setRotation,          setSizeVector = setSizeVector,

    setZoomVector = setZoomVector,          setPos = setPos

}

local actor = tapLua.Actor          Astro.Table.merge( actor, t )