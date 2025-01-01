

-- Those 10s constants are around because there's 0-9 frames.

local input = ...           local sheetY = 3            local n = input.Num

local function value(noFormat)

    local value = input.value()             if noFormat then return tostring(value) end

    return ( '%0' .. n .. 'i' ):format(value)

end

local function length( new, last )

    local sub = new - last

    if last >= new then return 10 + sub end             return sub
    
end

local function updateValue( self, i )

    local v = value()               local raw = value(true)
    

    if self.value == v or raw == '0' then return end
    
    self.value = v            


    if #raw < 10 - i then return end

    self:playcommand("Finish"):queuecommand("Scroll")


    if self.started then return end
    
    self:playcommand("Start")           self.started = true

end

local t = Def.ActorFrame{ input.Mask() }

for i = 1, n do

    local s = input.background(i) .. {

        InitCommand=function(self) self.updateValue = updateValue end

    }          
    
    t[#t+1] = s

    -- Scrolling numbers.

    s[#s+1] = input.sprite() ..{

        InitCommand=function(self) 
            
            self.last = '0'

            self:customtexturerect( 0, 0, 1, sheetY )

            self.value = function() return self:GetParent().value end
        
        end,

        OnCommand=function(self) 
        
            local h = self:GetZoomedHeight()        self.Height = h / 10
            
            local offset = h * sheetY - self.Height          offset = offset * 0.5

            self:zoomy( self:GetZoomY() * sheetY ):y(offset)

            -- ztestmode -> Inverted mask.
            self:MaskDest():ztestmode("ZTestMode_WriteOnFail")

            self.Limit = offset - self.Height * 10

        end,

        FinishCommand=function(self) self:finishtweening() end,

        ScrollCommand=function(self)

            local new = self:value():sub(i, i)          local last = self.last

            if new == last then return end


            local n = length( new, last )               self.last = new


            local y = self:GetY() - self.Height * n

            self:linear( n * 0.125 ):y(y)

            -- It's an illusion. :D
            if y <= self.Limit then self:sleep(0):y( y + self.Height * 10 ) end

        end

    }

end

return Def.ActorFrame{ t }