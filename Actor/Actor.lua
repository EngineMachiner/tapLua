
local Actor = {}        tapLua.Actor = Actor


local path = "tapLua/Actor/"

LoadModule( path .. "Timer.lua" )           LoadModule( path .. "Vector.lua" )


local function actor( class )

    return Def[class] {

        InitCommand=function(self)

            for k,v in pairs(Actor) do self[k] = v end

        end

    }

end