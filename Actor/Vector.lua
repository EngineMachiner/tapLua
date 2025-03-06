
-- Return variable arguments for these.

-- getrotation() exists haha.

local function GetDest(self)

    return self:GetDestX(), self:GetDestY(), self:GetDestZ()

end

local function GetSize(self)

    return self:GetWidth(), self:GetHeight()

end

local function GetZoomedSize(self)

    return self:GetZoomedWidth(), self:GetZoomedHeight()

end

local function GetPos(self)

    return self:GetX(), self:GetY(), self:GetZ()

end

local function GetZoomCoords(self)

    return self:GetZoomX(), self:GetZoomY(), self:GetZoomZ()

end

local t = {
    
    GetDest = GetDest,
    
    GetSize = GetSize,      GetZoomedSize = GetZoomedSize,

    GetPos = GetPos,        GetZoomCoords = GetZoomCoords

}

local actor = tapLua.Actor          Astro.Table.merge( actor, t )