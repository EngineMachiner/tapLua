
local astro = Astro.Table

local function resolvePath(path) return tapLua.resolvePath( path, 3 ) end


local Actor = {}        tapLua.Actor = Actor


local path = tapLua.Path .. "Actor/"

tapLua.FILEMAN.LoadDirectory( path, "Actor.lua" )

local Vector = Actor.Vector        Actor.Vector = nil


local function setMeta( f, tbl )

    local meta = { __call = f }         setmetatable( tbl, meta )

end


local function lib(keys)

    if not keys then return Vector end


    local function isValid( k, v ) return astro.contains( lib, k ) end

    return astro.filter( Actor, isValid )

end

-- Extend vector library by default.

Actor.extend = function( actor, keys )

    local lib = lib(keys)       astro.merge( actor, lib )       return actor

end

local function Actor( tapLua, input )

    local class = input.Class       input.Class = nil

    return Def[class] {

        InitCommand=function(self)

            for k,v in pairs(tapLua) do self[k] = v end

            self.extend = nil -- It's not logical.

        end

    } .. input

end

setMeta( Actor, tapLua.Actor )


local function build( class, input )

    input.Class = class      return tapLua.Actor(input)

end


local Sprite = {}        tapLua.Sprite = Sprite

local function Sprite( tapLua, input )

    input.Texture = resolvePath( input.Texture )

    return build( "Sprite", input ) 

end

setMeta( Sprite, tapLua.Sprite )


local function Quad( input ) return build( "Quad", input ) end

local function ActorFrame( input ) return build( "ActorFrame", input ) end

local function Text( input ) 
    
    input.Font = resolvePath( input.Font )           return build( "BitmapText", input ) 

end

local t = {
    
    Quad = Quad,        ActorFrame = ActorFrame,
    
    Text = Text,        extend = extend

}

astro.merge( tapLua, t )