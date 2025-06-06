
local astro = Astro.Type            local isString = astro.isString

local isFunction = astro.isFunction             astro = Astro.Table

local isTexture = tapLua.Type.isTexture


local Actor = {}                tapLua.Actor = Actor
local Sprite = {}               tapLua.Sprite = Sprite
local ActorFrame = {}           tapLua.ActorFrame = ActorFrame


local function resolvePath(path) return tapLua.resolvePath( path, 3 ) end


local path = tapLua.Path .. "Actor/"

tapLua.FILEMAN.LoadDirectory( path, "Actor.lua" )


local Vector = Actor.Vector        Actor.Vector = nil


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

            for k,v in pairs( tapLua ) do self[k] = v end             self.tapLua = { Timers = {} }
            
            self.extend, self.merge, self.commands = nil -- It's not logical.

        end

    }

    input = merge( base, input )            local Actor = Def[class]            return Actor(input)

end

setMeta( actor, Actor )


local function texture(texture) return isString(texture) and resolvePath(texture) or texture end

local function sprite( tapLua, input )

    input.Class = "Sprite"
    
    local Texture = input.Texture           input.Texture = texture(Texture)

    local base = {
        
        InitCommand=function(self)
            
            for k,v in pairs( tapLua ) do self[k] = v end
            
            if isTexture(Texture) then self:SetTexture(Texture) end
        
        end
    
    }

    input = merge( base, input )        return Actor(input)

end

setMeta( sprite, Sprite )


local function actorFrame( tapLua, input )
    
    input.Class = "ActorFrame"
    
    local base = { InitCommand=function(self) for k,v in pairs( tapLua ) do self[k] = v end end }
    
    input = merge( base, input )        return Actor(input)

end

setMeta( actorFrame, ActorFrame )


local function Quad( input ) input.Class = "Quad"       return Actor(input) end

local function ActorFrameTexture( input ) input.Class = "ActorFrameTexture"       return Actor(input) end

local function Text( input )
    
    input.Class = "BitmapText"          input.Font = resolvePath( input.Font )          return Actor(input) 

end


local Model = {}        tapLua.Model = Model

local modelKeys = { "Meshes", "Materials", "Bones" }

local function setupFile( tbl, path )

    for i,v in ipairs( modelKeys ) do tbl[v] = resolvePath(path) end
    
    return tbl

end

local function model( input )

    for i,v in ipairs( modelKeys ) do input[v] = resolvePath( input[v] ) end

    input.Class = "Model"        input.setupFile = setupFile
    
    return Actor(input)

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