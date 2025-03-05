
local function runTimer( self, data )

    local function isValid() return data.Time < data.Limit end

    if not isValid() then return end


    data.Time = data.Time + self:GetEffectDelta()

    if not isValid() then data.callback() end

end

-- This function has to be called in ActorFrame:SetUpdateFunction()

local function runTimers(self)

    local data = self.tapLua
    
    if not data or not data.Timers then return end


    data = data.Timers

    for k,v in pairs(data) do runTimer( self, v ) end

end


local function data() return { Timers = {} } end

-- Create the data to run a function later.

local function time( self, time, callback )

    self.tapLua = self.tapLua or data()


    local data = self.tapLua.Timers

    local timer = { Time = 0, Limit = time, callback = callback }

    table.insert( data, timer )

end

return { time = time, runTimers = runTimers }
