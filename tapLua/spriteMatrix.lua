
--[[

    This is how a sprite / frame would be represented by the next sprites in that order:

    |1||2||3|
    |4||5||6|
    |7||8||9|

--]]

local frame, offset

local function flip(crop) return 1 - crop end

return function( path, cropX, cropY, size )

    size = size or {}         size.X = size.X or 0          size.Y = size.Y or 0

    local zoom = size.Zoom

    local function sprite()

        return Def.Sprite{
    
            InitCommand=function(self)
            
                self:Load(path):zoom(zoom)

                self.cornerWidth = function() return self:GetZoomedWidth() * flip( cropX[1] ) end
                self.centerWidth = function() return self:GetZoomedWidth() * flip( cropX[2] * 2 ) end

                self.cornerHeight = function() return self:GetZoomedHeight() * flip( cropY[1] ) end
                self.centerHeight = function() return self:GetZoomedHeight() * flip( cropY[2] * 2 ) end
    
                -- Cropped sizes for the centered parts.
                self.setWidth = function() self:SetWidth( size.X * 4 / zoom )     return self end

                self.setHeight = function() self:SetHeight( size.Y * 4 / zoom )    return self end

            end
    
        }
    
    end

    return Def.ActorFrame{

        sprite() .. {

            InitCommand=function(self)

                self.offset = { X = self:centerWidth() - size.X,     Y = self:centerHeight() - size.Y }

                offset = self.offset          for k,v in pairs(offset) do offset[k] = v * 0.5 end
                

                self:xy( offset.X, offset.Y )         self:cropright( cropX[1] ):cropbottom( cropY[1] )

                frame = self:GetParent()

                frame:SetWidth( frame:GetWidth() + self:cornerWidth() )
                frame:SetHeight( frame:GetHeight() + self:cornerHeight() )

            end

        },

        sprite() .. {

            InitCommand=function(self) 
                
                self:y( offset.Y )         self:setWidth()

                self:cropleft( cropX[2] ):cropright( cropX[2] ):cropbottom( cropY[1] )

                frame:SetWidth( frame:GetWidth() + self:centerWidth() )
                frame:SetHeight( frame:GetHeight() + self:centerHeight() )

            end

        },

        sprite() .. {

            InitCommand=function(self) 

                self:xy( - offset.X, offset.Y )         self:cropleft( cropX[1] ):cropbottom( cropY[1] )

                frame:SetWidth( frame:GetWidth() + self:cornerWidth() )
                frame:SetHeight( frame:GetHeight() + self:cornerHeight() )
            

            end

        },

        sprite() .. {

            InitCommand=function(self)

                self:x( offset.X )          self:setHeight()

                self:cropright( cropX[1] ):croptop( cropY[2] ):cropbottom( cropY[2] )

                frame:SetWidth( frame:GetWidth() + self:cornerWidth() )
                frame:SetHeight( frame:GetHeight() + self:cornerHeight() )

            end

        },

        sprite() .. {

            InitCommand=function(self)

                self:setWidth():setHeight()

                self:cropright( cropX[2] ):cropleft( cropX[2] )
                self:croptop( cropY[2] ):cropbottom( cropY[2] )

                frame:SetWidth( frame:GetWidth() + self:centerWidth() )
                frame:SetHeight( frame:GetHeight() + self:centerHeight() )

            end

        },
        
        sprite() .. {

            InitCommand=function(self) 
                
                self:x( - offset.X )        self:setHeight()

                self:cropleft( cropX[1] ):croptop( cropY[2] ):cropbottom( cropY[2] )

                frame:SetWidth( frame:GetWidth() + self:cornerWidth() )
                frame:SetHeight( frame:GetHeight() + self:cornerHeight() )
            
            end

        },

        sprite() .. {

            InitCommand=function(self)

                self:xy( offset.X, - offset.Y )       self:cropright( cropX[1] ):croptop( cropY[1] )

                frame:SetWidth( frame:GetWidth() + self:cornerWidth() )
                frame:SetHeight( frame:GetHeight() + self:cornerHeight() )

            end

        },

        sprite() .. {

            InitCommand=function(self)

                self:y( - offset.Y )        self:setWidth()

                self:cropright( cropX[2] ):cropleft( cropX[2] ):croptop( cropY[1] )

                frame:SetWidth( frame:GetWidth() + self:centerWidth() )
                frame:SetHeight( frame:GetHeight() + self:centerHeight() )

            end

        },
        
        sprite() .. {

            InitCommand=function(self)
                
                self:xy( - offset.X, - offset.Y )

                self:cropleft( cropX[1] ):croptop( cropY[1] )

                frame:SetWidth( frame:GetWidth() + self:cornerWidth() )
                frame:SetHeight( frame:GetHeight() + self:cornerHeight() )
            
            end

        }

    }

end