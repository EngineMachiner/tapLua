
-- This is hacky but ¯\_(ツ)_/¯         -- A RageTexture is userdata.

-- Only classes from the "Def" table have the "Class" key.

-- TODO: Use __concat function to check if an object is an def actor table?

local astro = Astro.Type

local isUserData = astro.isUserData         local isTable = astro.isTable

local function isObject(a)
    
    local name = tostring(a)        local isObject = isTable(a) and not name:match("table")

    return isObject or isUserData(a)

end

local function isTexture(a) return isObject(a) and a.GetTextureHeight end

local function isSprite(a) return isObject(a) and a.customtexturerect end

local function isActorFrame(a) return isObject(a) and a.AddChildFromPath end

tapLua.Type = { 
    
    isObject = isObject,                    isSprite = isSprite,
    isActorFrame = isActorFrame,            isTexture = isTexture

}