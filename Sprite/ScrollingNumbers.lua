
--[[

    Return an ActorFrame containing sprites that scroll between zero to nine in a 1x9 sprite sheet.

    Example: The number animation from the DDR 4th MIX score bar.

    Parameters: {
    
        value - The function that returns the input numbers.
        Number - The number of scrolling numbers.

        background - The function that returns an ActorFrame that should 
        be behind a single sprite number.

        mask - The quad or mask actor.
        sprite - The sprite sheet with the (stretch) property.

    }

    Those 10s constants are in the code because there's 0-9 frames in the sprite sheet.

]]

local input = ...       local n = input.Number          local background = input.background

local mask = input.mask         local sprite = input.sprite


local function value( formatted )

    local value = input.value()             if not formatted then return tostring(value) end

    local format = '%0' .. n .. 'i'         return format:format(value)

end

-- Handles scrolling length comparing the last and new value.

local function length( new, last )

    local length = new - last          local isHigher = new > last
    
    return isHigher and length + 10 or length
    
end


local t = Def.ActorFrame {
    
    mask() .. { InitCommand=function(self) self:MaskSource(true) end }

}

local function update( self, i )

    local v = value(true)       local raw = value()


    if self.value == v or raw == '0' then return end

    self.value = v


    if #raw < 10 - i then return end

    self:playcommand("Finish"):queuecommand("Scroll")


    if self.started then return end         self.started = true
    
    self:playcommand("Start")

end

local zoomY = 3

for i = 1, n do
    
    local Sprite = sprite() .. {

        InitCommand=function(self) self:customtexturerect( 0, 0, 1, zoomY ) end,

        OnCommand=function(self)
        
            local h1 = self:GetZoomedHeight() -- Texture height.
            
            local h2 = h1 / 10 -- Number height.
            

            local y = h1 * zoomY - h2           y = y * 0.5

            self:y(y):zoomy(zoomY)              tapLua.Actor.invertedMaskDest(self)

            
            self.Height = h2            self.Limit = y - h1

        end,

        FinishCommand=function(self) self:finishtweening() end,

        ScrollCommand=function(self)

            local last = self.last or '0'
            
            local new = self:GetParent():value()        new = new:Astro():subChar(i)

            if new == last then return end


            local n = length( new, last )               self.last = new


            local y1 = self:GetY() - self.Height * n

            self:linear( n * 0.125 ):y(y1)
            

            --[[
            
                It's an endless illusion. :D

                Set the position back to keep scrolling next time.

            ]] 

            local y2 = y1 + self:GetZoomedHeight()

            if y1 <= self.Limit then self:sleep(0):y(y2) end

        end

    }

    t[#t+1] = Def.ActorFrame {

        UpdateCommand=function(self) update( self, i ) end,
        
        background(i),      Sprite

    }

end

return Def.ActorFrame{ t }