
--[[

    Return a table of sprites that split the sprite into 9 parts.

    This is how a sprite / frame would be represented by the next sprites in that order:

    |1||2||3|
    |4||5||6|
    |7||8||9|

--]]

-- Gotta do set defaults with some metamethods first...

local input = ...


local function setMeta( tbl, meta )

    tbl = tbl or {}

    local meta = { __index = meta }         return setmetatable( tbl, meta )

end

tbl.setMeta = setMeta


local defaults = {

    cornerCrop = { X = 0, Y = 0 },          centerCrop = { X = 0, Y = 0 },
    
    size = { X = 0, Y = 0, Zoom = 1 }

}

for k,v in pairs(defaults) do input[k] = setMeta( input[k], v ) end


local cornerCrop, centerCrop = input.cornerCrop, input.centerCrop

local size = input.size

local zoom = size.Zoom

local function onChildren(self) 

    local p = self:GetParent()

    local w, h = self:GetCroppedZoomedWidth(), self:GetCroppedZoomedHeight()

    p.width = p.width + w             p.height = p.height + h

end

local offset

-- Get the sized offsets.

local function getOffset(self)
   
    local offset = {}

    self:cropleft( centerCrop.X ):cropright( centerCrop.X )

    local w = self:GetCroppedZoomedWidth()

    offset.X = w - size.X

    
    self:croptop( centerCrop.Y ):cropbottom( centerCrop.Y )

    local h = self:GetCroppedZoomedHeight()

    offset.Y = h - size.Y


    self:cropleft(0):cropright(0):croptop(0):cropbottom(0)

    for k,v in pairs(offset) do offset[k] = v * 0.5 end

    return offset

end

local function sprite()

    return input.sprite() .. {

        InitCommand=function(self)
        
            self:zoom(zoom)

            -- Only for the center parts.

            self.setWidth = function() self:SetWidth( size.X * 4 / zoom ) return self end
            self.setHeight = function() self:SetHeight( size.Y * 4 / zoom ) return self end

        end

    }

end

return Def.ActorFrame{

    InitCommand=function(self) self.width = 0       self.height = 0 end,

    OnCommand=function(self) self:RunCommandsOnChildren(onChildren) end,

    sprite() .. {

        InitCommand=function(self)

            offset = offset or getOffset(self)        self:xy( offset.X, offset.Y )

            self:cropright( cornerCrop.X ):cropbottom( cornerCrop.Y )

        end

    },

    sprite() .. {

        InitCommand=function(self) 
            
            self:y( offset.Y )         self:setWidth()

            self:cropleft( centerCrop.X ):cropright( centerCrop.X ):cropbottom( cornerCrop.Y )

        end

    },

    sprite() .. {

        InitCommand=function(self) 

            self:xy( - offset.X, offset.Y )
            
            self:cropleft( cornerCrop.X ):cropbottom( cornerCrop.Y )

        end

    },

    sprite() .. {

        InitCommand=function(self)

            self:x( offset.X )          self:setHeight()

            self:cropright( cornerCrop.X ):croptop( centerCrop.Y ):cropbottom( centerCrop.Y )

        end

    },

    sprite() .. {

        InitCommand=function(self)

            self:setWidth():setHeight()

            self:cropleft( centerCrop.X ):cropright( centerCrop.X )
            self:croptop( centerCrop.Y ):cropbottom( centerCrop.Y )

        end

    },
    
    sprite() .. {

        InitCommand=function(self) 
            
            self:x( - offset.X )        self:setHeight()

            self:cropleft( cornerCrop.X ):croptop( centerCrop.Y ):cropbottom( centerCrop.Y )

        end

    },

    sprite() .. {

        InitCommand=function(self)

            self:xy( offset.X, - offset.Y )
            
            self:cropright( cornerCrop.X ):croptop( cornerCrop.Y )

        end

    },

    sprite() .. {

        InitCommand=function(self)

            self:y( - offset.Y )        self:setWidth()

            self:cropleft( centerCrop.X ):cropright( centerCrop.X ):croptop( cornerCrop.Y )

        end

    },
    
    sprite() .. {

        InitCommand=function(self)
            
            self:xy( - offset.X, - offset.Y )

            self:cropleft( cornerCrop.X ):croptop( cornerCrop.Y )
        
        end

    }

}
