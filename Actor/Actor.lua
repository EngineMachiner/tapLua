
local astro = Astro.Table


local Actor = {}        tapLua.Actor = Actor


local path = "tapLua/Actor/"

LoadModule( path .. "Timer.lua" )           LoadModule( path .. "Vector.lua" )


local function Actor( self, input )

    local class = input.Class

    return Def[class] {

        InitCommand=function(self)

            for k,v in pairs(Actor) do self[k] = v end

        end

    } .. input

end

local meta = { __call = Actor }         setmetatable( tapLua.Actor, meta )


local function build( class, input )

    input.Class = class      return Actor(input)

end

local function Sprite( input ) return build( "Sprite", input ) end

local function Quad( input ) return build( "Quad", input ) end

local function ActorFrame( input ) return build( "ActorFrame", input ) end

local function Text( input ) return build( "BitmapText", input ) end


local t = {
    
    Sprite = Sprite,        Quad = Quad,

    ActorFrame = ActorFrame,        Text = Text

}

astro.merge( tapLua, t )