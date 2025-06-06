
local function runTimer( self, timer )

    local function isValid() return timer.Time < timer.Limit end

    if not isValid() then return end


    timer.Time = timer.Time + self:GetEffectDelta()

    if not isValid() then timer:callback(self) end

end

-- This function has to be called in ActorFrame:SetUpdateFunction()

local function runTimers(self)

    local timers = self.tapLua.Timers            for k,v in pairs(timers) do runTimer( self, v ) end

end


-- Create the timer to run a function later.

local function timer( self, time, callback )

    local timers = self.tapLua.Timers

    local timer = { Time = 0, Limit = time, callback = callback }

    table.insert( timers, timer )             return timer

end

local t = { timer = timer, runTimers = runTimers }

local actor = tapLua.Actor          Astro.Table.merge( actor, t )