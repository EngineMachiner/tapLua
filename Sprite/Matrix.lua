
--[[

    Return an ActorFrame containing sprites that split a sprite template into 9 parts.

    This is how a sprite / frame would be represented by the next sprites in that order:

    |1||2||3|
    |4||5||6|
    |7||8||9|

    Parameters: {
    
        sprite - The tapLua Sprite template to use.
        cornerCrop - Vector, how much should be cropped from the corners.
        centerCrop - Vector, how much should be cropped from the centers.
        zoom - The zoom to be done to all the elements.
        size - The size from the matrix.

    }

    Example: You can use this to create an adaptable window or a user interface dialogue box.

]]

local Vector = Astro.Vector           local astro = Astro.Table

local input = ...


-- Gotta do set defaults with some metamethods first...

local defaults = {

    cornerCrop = Vector { x = 0, y = 0 },          centerCrop = Vector { x = 0, y = 0 },
    
    size = Vector { x = 0, y = 0 },         zoom = 1

}

astro.Meta.setIndex( input, defaults )


local size = input.size             local zoom = size.Zoom

local cornerCrop = input.cornerCrop         local centerCrop = input.centerCrop

local function onChildren(self)

    local p = self:GetParent()          local size = self:GetCroppedZoomedSize()

    p.Size = p.Size + size

end

-- Get the size offsets.

local function getOffset(self)
   
    local cropX = centerCrop.x          local cropY = centerCrop.y

    self:cropHorizontally( cropX ):cropVertically( cropY )

    local offset = self:GetCroppedZoomedSize() - size

    self:cropHorizontally(0):cropVertically(0) -- Set back to 0.

    return offset * 0.5

end

local function sprite()

    return input.sprite() .. {

        InitCommand=function(self)
        
            self:zoom(zoom)         local scale = 4 / zoom

            -- Only for the center parts.

            self.setWidth = function() self:SetWidth( size.x * scale ) return self end
            self.setHeight = function() self:SetHeight( size.y * scale ) return self end

        end

    }

end

local offset

return Def.ActorFrame {

    InitCommand=function(self) self.Size = Vector() end,

    OnCommand=function(self) self:RunCommandsOnChildren(onChildren) end,

    sprite() .. {

        InitCommand=function(self)

            offset = getOffset(self)        self:SetSize(offset)

            self:cropright( cornerCrop.x ):cropbottom( cornerCrop.y )

        end

    },

    sprite() .. {

        InitCommand=function(self) 
            
            self:y( offset.y )         self:setWidth()

            self:cropHorizontally( centerCrop.x ):cropbottom( cornerCrop.y )

        end

    },

    sprite() .. {

        InitCommand=function(self) 

            self:xy( - offset.x, offset.y )
            
            self:cropleft( cornerCrop.x ):cropbottom( cornerCrop.y )

        end

    },

    sprite() .. {

        InitCommand=function(self)

            self:x( offset.x )          self:setHeight()

            self:cropright( cornerCrop.x ):cropVertically( centerCrop.y )

        end

    },

    sprite() .. {

        InitCommand=function(self)

            self:setWidth():setHeight()

            self:cropHorizontally( centerCrop.x ):cropVertically( centerCrop.y )

        end

    },
    
    sprite() .. {

        InitCommand=function(self) 
            
            self:x( - offset.x )        self:setHeight()

            self:cropleft( cornerCrop.x ):cropVertically( centerCrop.y )

        end

    },

    sprite() .. {

        InitCommand=function(self)

            self:xy( offset.x, - offset.y )
            
            self:cropright( cornerCrop.x ):croptop( cornerCrop.y )

        end

    },

    sprite() .. {

        InitCommand=function(self)

            self:y( - offset.y )        self:setWidth()

            self:cropHorizontally( centerCrop.x ):croptop( cornerCrop.y )

        end

    },
    
    sprite() .. {

        InitCommand=function(self)
            
            self:SetSize( - offset )

            self:cropleft( cornerCrop.x ):croptop( cornerCrop.y )
        
        end

    }

}
