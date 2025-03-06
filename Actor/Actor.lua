
local astro = Astro.Table


local Actor = {}        tapLua.Actor = Actor


local path = "tapLua/Actor/"

LoadModule( path .. "Timer.lua" )           LoadModule( path .. "Vector.lua" )


local function actor( input )

    local class = input.Class

    return Def[class] {

        InitCommand=function(self)

            for k,v in pairs(Actor) do self[k] = v end

        end

    } .. input

end

local function build( class, input )

    input.Class = class      return actor(input)

end

local function sprite( input ) return build( "Sprite", input ) end

local function quad( input ) return build( "Quad", input ) end

local function actorFrame( input ) return build( "ActorFrame", input ) end

local function text( input ) return build( "BitmapText", input ) end


local t = {
    
    actor = actor,      sprite = sprite,        quad = quad,

    actorFrame = actorFrame,        text = text

}

astro.merge( tapLua, t )