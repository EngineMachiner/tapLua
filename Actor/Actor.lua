
local astro = Astro.Table


local Actor = {}        tapLua.Actor = Actor


local path = tapLua.Path .. "Actor/"

tapLua.FILEMAN.LoadDirectory( path, "Actor.lua" )

local Vector = Actor.Vector        Actor.Vector = nil


local function lib(keys)

    if not keys then return Vector end


    local function isValid( k, v ) return astro.find( lib, k ) end

    return astro.filter( Actor, isValid )

end

-- Extend vector library by default.

Actor.extend = function( actor, keys )

    local lib = lib(keys)       astro.merge( actor, lib )       return actor

end

local function Actor( tapLua, input )

    local class = input.Class

    return Def[class] {

        InitCommand=function(self)

            for k,v in pairs(tapLua) do self[k] = v end

            self.extend = nil -- It's not logical.

        end

    } .. input

end

local meta = { __call = Actor }         setmetatable( tapLua.Actor, meta )


local function build( class, input )

    input.Class = class      return tapLua.Actor(input)

end

local function Sprite( input ) return build( "Sprite", input ) end

local function Quad( input ) return build( "Quad", input ) end

local function ActorFrame( input ) return build( "ActorFrame", input ) end

local function Text( input ) return build( "BitmapText", input ) end

local t = {
    
    Sprite = Sprite,        Quad = Quad,        ActorFrame = ActorFrame,
    
    Text = Text,        extend = extend

}

astro.merge( tapLua, t )