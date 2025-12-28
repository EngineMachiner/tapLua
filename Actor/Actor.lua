
-- https://en.wikipedia.org/wiki/Prototype-based_programming

local astro = Astro.Type                        local isFunction = astro.isFunction

local isTexture = tapLua.Type.isTexture         local isString = astro.isString


astro = Astro.Table                     local filter = astro.filter

local copy = astro.Copy.deep


local Actor = {}                        tapLua.Actor = Actor
local Sprite = {}                       tapLua.Sprite = Sprite
local ActorFrame = {}                   tapLua.ActorFrame = ActorFrame

tapLua.FILEMAN.LoadDirectory( tapLua.Path .. "Actor/" )


local Meta = Actor.Meta                 local resolvePath = Meta.resolvePath

local setMeta = Meta.setMeta            local InitCommand = Meta.InitCommand

local texture = Meta.texture


local Vector = Actor.Vector             local metaActor = copy(Actor)

metaActor.Vector, metaActor.Meta = nil


local function lib(keys)

    if not keys then return Vector end -- Extend vector library by default.

    local function isValid( k, v ) return astro.contains( keys, k ) end

    return filter( Vector, isValid )

end

Actor.extend = function( actor, keys )

    local lib = lib(keys)       astro.merge( actor, lib )       return actor

end


-- Get and filter all the commands of an actor table.

local function commands( key, value ) return isString(key) and key:Astro():endsWith("Command") end

Actor.commands = function(tbl) return filter( tbl, commands ) end


-- Merge tables before Actor creation.

local function value( current, value )

    if not current or not isFunction(value) then return value end

    return function(...) current(...) value(...) end

end

local function merge( to, from )

    if not from then return to end

    for k,v in pairs(from) do to[k] = value( to[k], v ) end         return to

end

Actor.merge = merge


local function actor( tapLua, input )

    local base = { InitCommand=function(self) InitCommand(metaActor)(self)      self.tapLua = { Timers = {} } end }

    input = merge( base, input ) -- Merging is inverted to merge from last to first. This base is the first table.


    local class = input.Class           input.Class = nil

    local actor = Def[class]            return actor(input)

end

setMeta( actor, Actor )


local function sprite( tapLua, input )

    local texture = texture( input.Texture )

    local base = {

        Class = "Sprite",           Texture = texture,

        InitCommand=function(self)
            
            InitCommand(tapLua)(self)           if isTexture(texture) then self:SetTexture(texture) end
        
        end

    }

    input = merge( base, input )            return Actor(input)

end

setMeta( sprite, Sprite )


local function actorFrame( tapLua, input )
    
    local base = { Class = "ActorFrame",        InitCommand = InitCommand(tapLua) }

    input = merge( base, input )            return Actor(input)

end

setMeta( actorFrame, ActorFrame )


local function ActorFrameTexture( input )
    
    input.Class = "ActorFrameTexture"           return Actor(input)

end


local function Quad( input ) input.Class = "Quad"       return Actor(input) end

local function Text( input )
    
    input.Class = "BitmapText"      input.Font = resolvePath( input.Font )      return Actor(input) 

end


local modelKeys = { "Meshes", "Materials", "Bones" }

local function setupFile( tbl, path )

    for i,v in ipairs( modelKeys ) do tbl[v] = resolvePath(path) end        return tbl

end

local function Model( input )

    for i,v in ipairs( modelKeys ) do input[v] = resolvePath( input[v] ) end

    input.Class = "Model"           input.setupFile = setupFile
    
    local File = input.File         if File then input:setupFile(File) end

    return Actor(input)

end

-- Additional actors.

local function ScreenQuad(color)

	color = color or Color.White            local screenSize = tapLua.screenSize()
	
	return Quad { InitCommand=function(self) self:diffuse(color):setSizeVector(screenSize) end }
	
end


local t = {
    
    Quad = Quad,        ScreenQuad = ScreenQuad,        ActorFrame = ActorFrame,
    
    ActorFrameTexture = ActorFrameTexture,          Text = Text,        Model = Model

}

astro.merge( tapLua, t )