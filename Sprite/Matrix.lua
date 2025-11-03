
--[[

    Return an ActorFrame containing sprites that split a sprite template into 9 parts.

    This is how a sprite / frame would be represented by the next sprites in that order:

    |1||2||3|
    |4||5||6|
    |7||8||9|

    Parameters: {
    
        sprite - The tapLua Sprite template to use.
        CornerCrop - Vector, how much should be cropped from the corners.
        CenterCrop - Vector, how much should be cropped from the centers.
        Zoom - The zoom to be done to all the elements.
        Size - The size from the matrix.

    }

    Example: You can use this to create an adaptable window or a user interface dialogue box.

]]

local Vector = Astro.Vector           local astro = Astro.Table             local input = ...


-- Gotta do set defaults with some metamethods first...

local defaults = {

    CornerCrop = Vector(),          CenterCrop = Vector(),
    
    Size = Vector(),                Zoom = 1

}

astro.Meta.setIndex( input, defaults )


local Size = input.Size                     local Zoom = input.Zoom

local CornerCrop = input.CornerCrop         local CenterCrop = input.CenterCrop

local function onChildren(self)

    local p = self:GetParent()              local size = self:GetCroppedZoomedSize()

    p.Size = p.Size + size

end

-- Get the size offsets.

local function getOffset(self)
   
    local cropX = CenterCrop.x              local cropY = CenterCrop.y

    self:cropHorizontally( cropX ):cropVertically( cropY )

    local offset = self:GetCroppedZoomedSize() - Size

    self:cropHorizontally(0):cropVertically(0) -- Set back to 0.

    return offset * 0.5

end

local function sprite()

    return input.sprite() .. {

        InitCommand=function(self)
        
            self:zoom(Zoom)         local scale = 4 / Zoom

            -- Only for the center parts.

            self.setWidth = function() self:SetWidth( Size.x * scale ) return self end
            self.setHeight = function() self:SetHeight( Size.y * scale ) return self end

        end

    }

end

local offset

return Def.ActorFrame {

    InitCommand=function(self) self.Size = Vector()     self:playcommand("PostInit") end,

    OnCommand=function(self) self:RunCommandsOnChildren(onChildren) end,

    sprite() .. {

        PostInitCommand=function(self)

            offset = getOffset(self)        self:setPos(offset)

            self:cropright( CornerCrop.x ):cropbottom( CornerCrop.y )

        end

    },

    sprite() .. {

        PostInitCommand=function(self) 
            
            self:y( offset.y )         self:setWidth()

            self:cropHorizontally( CenterCrop.x ):cropbottom( CornerCrop.y )

        end

    },

    sprite() .. {

        PostInitCommand=function(self) 

            self:xy( - offset.x, offset.y )
            
            self:cropleft( CornerCrop.x ):cropbottom( CornerCrop.y )

        end

    },

    sprite() .. {

        PostInitCommand=function(self)

            self:x( offset.x )          self:setHeight()

            self:cropright( CornerCrop.x ):cropVertically( CenterCrop.y )

        end

    },

    sprite() .. {

        PostInitCommand=function(self)

            self:setWidth():setHeight()

            self:cropHorizontally( CenterCrop.x ):cropVertically( CenterCrop.y )

        end

    },
    
    sprite() .. {

        PostInitCommand=function(self) 
            
            self:x( - offset.x )        self:setHeight()

            self:cropleft( CornerCrop.x ):cropVertically( CenterCrop.y )

        end

    },

    sprite() .. {

        PostInitCommand=function(self)

            self:xy( offset.x, - offset.y )
            
            self:cropright( CornerCrop.x ):croptop( CornerCrop.y )

        end

    },

    sprite() .. {

        PostInitCommand=function(self)

            self:y( - offset.y )        self:setWidth()

            self:cropHorizontally( CenterCrop.x ):croptop( CornerCrop.y )

        end

    },
    
    sprite() .. {

        PostInitCommand=function(self)
            
            self:setPos( - offset ):cropleft( CornerCrop.x ):croptop( CornerCrop.y )
        
        end

    }

}
