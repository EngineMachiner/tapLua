
local astro = Astro.Type

local isString = astro.isString             local isFunction = astro.isFunction

local isTexture = tapLua.Type.isTexture             astro = Astro.Table


local Actor = {}                tapLua.Actor = Actor
local Sprite = {}               tapLua.Sprite = Sprite
local ActorFrame = {}           tapLua.ActorFrame = ActorFrame

local function resolvePath(path) return tapLua.resolvePath( path, 3 ) end

tapLua.FILEMAN.LoadDirectory( tapLua.Path .. "Actor/" )


local Vector = Actor.Vector        Actor.Vector = nil

local metaActor = astro.Copy.deep(Actor)


local function setMeta( f, tbl )

    local meta = { __call = f }         setmetatable( tbl, meta )

end


local function lib(keys)

    if not keys then return Vector end

    local function isValid( k, v ) return astro.contains( keys, k ) end

    return astro.filter( Actor, isValid )

end

-- Extend vector library by default.

Actor.extend = function( actor, keys )

    local lib = lib(keys)       merge( actor, lib )       return actor

end


-- Get and filter all the commands of an actor table.

local function commands( key, value ) return key:Astro():endsWith("Command") end

Actor.commands = function(tbl) return astro.filter( tbl, commands ) end


-- Merge tables before Actor creation.

local function value( key, value, current )

    if not current or not isFunction(value) then return value end

    return function(...) current(...) value(...) end

end

local function merge( to, from )

    if not from then return to end

    for k,v in pairs(from) do to[k] = value( k, v, to[k] ) end

    return to

end

Actor.merge = merge


local function actor( tapLua, input )

    local class = input.Class           input.Class = nil

    local base = {

        InitCommand=function(self)

            for k,v in pairs( metaActor ) do self[k] = v end             self.tapLua = { Timers = {} }

        end

    }

    input = merge( base, input )            local Actor = Def[class]            return Actor(input)

end

setMeta( actor, Actor )


local function texture(texture) return isString(texture) and resolvePath(texture) or texture end

local function sprite( tapLua, input )

    local Texture = input.Texture           input.Texture = texture(Texture)

    local base = {
        
        InitCommand=function(self)
            
            for k,v in pairs( tapLua ) do self[k] = v end
            
            if isTexture(Texture) then self:SetTexture(Texture) end
        
        end
    
    }

    input.Class = "Sprite"      input = merge( base, input )        return Actor(input)

end

setMeta( sprite, Sprite )


local function actorFrame( tapLua, input )
    
    local base = { InitCommand=function(self) for k,v in pairs( tapLua ) do self[k] = v end end }
    
    input.Class = "ActorFrame"      input = merge( base, input )        return Actor(input)

end

setMeta( actorFrame, ActorFrame )


local function Quad( input ) input.Class = "Quad"       return Actor(input) end

local function ActorFrameTexture( input ) input.Class = "ActorFrameTexture"       return Actor(input) end

local function Text( input )
    
    input.Class = "BitmapText"      input.Font = resolvePath( input.Font )      return Actor(input) 

end


local Model = {}        tapLua.Model = Model

local modelKeys = { "Meshes", "Materials", "Bones" }

local function setupFile( tbl, path )

    for i,v in ipairs( modelKeys ) do tbl[v] = resolvePath(path) end
    
    return tbl

end

local function model( input )

    for i,v in ipairs( modelKeys ) do input[v] = resolvePath( input[v] ) end

    input.Class = "Model"        input.setupFile = setupFile        return Actor(input)

end

setMeta( model, Model )


-- Additional actors.

local function ScreenQuad(color)

	color = color or Color.White            local screenSize = tapLua.screenSize()
	
	return Quad { InitCommand=function(self) self:diffuse(color):setSizeVector(screenSize) end }
	
end


local t = {
    
    Quad = Quad,        ScreenQuad = ScreenQuad,
    
    ActorFrame = ActorFrame,        ActorFrameTexture = ActorFrameTexture,
    
    Text = Text,        Model = Model,                  extend = extend

}

merge( tapLua, t )