
local isTable = Astro.Type.isTable

-- This is hacky but ¯\_(ツ)_/¯

-- Only classes from the "Def" table have the "Class" variable.

local function isObject(a) 
    
    return isTable(a) and a.AddWrapperState

end

local function isSprite(a)

    return isObject(a) and a.customtexturerect

end

local function isActorFrame(a)
    
    return isObject(a) and a.AddChildFromPath

end

tapLua.Type = { 
    
    isObject = isObject,                    isSprite = isSprite,
    isActorFrame = isActorFrame,

}