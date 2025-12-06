
local isString = Astro.Type.isString            local merge = Astro.Table.merge

local function resolvePath(path) return tapLua.resolvePath( path, 3 ) end

local function setMeta( f, tbl ) local meta = { __call = f }         setmetatable( tbl, meta ) end

local function InitCommand( lib ) return function(self) merge( self, lib ) end end

local function texture(texture) return isString(texture) and resolvePath(texture) or texture end

tapLua.Actor.Meta = {
    
    resolvePath = resolvePath,          setMeta = setMeta,        InitCommand = InitCommand,      texture = texture

}