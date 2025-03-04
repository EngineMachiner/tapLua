
local astro = Astro.Type

local isNil = astro.isNil
local isString = astro.isString

local endsWith = Astro.String.endsWith

astro = Astro.Table


local function paths( directory )

    if not endsWith( directory, '/' ) then directory = directory .. '/' end

    return FILEMAN:GetDirListing( directory, false, true )

end

local function isDirectory(path)

    local type = ActorUtil.GetFileType(path)        return type:match('Directory')

end

local function matches( tbl, val )

    local isValid = function(k) 
        
        local v = tbl[k]        return val:match(v) 
    
    end

    return astro.find( tbl, isValid )

end


local function LoadDirectory( directory, blacklist, recursive )

    if isString(directory) then directory = paths( directory ) end

    if isString(blacklist) then blacklist = { blacklist } end


    local function isBlacklisted(path)

        return blacklist and matches( blacklist, path )
    
    end
    
    local function load(path)

        if isBlacklisted(path) then return end


        local endsWith = endsWith( path, "%.lua" )

        if endsWith then dofile(path) return end
        

        local isValid = not recursive or not isDirectory(path)

        if isValid then return end

        LoadDirectory( path, blacklist, recursive )

    end


    for k,v in pairs(directory) do load(v) end

end

local function getFiles( directory, patterns, recursive )

    if isString(patterns) then patterns = { patterns } end

    if isString(directory) then directory = paths( directory ) end


    local t = {}

    local function isValid(path)

        return not patterns or matches( patterns, path )

    end
    
    local function add(path)

        if not isValid(path) then return end

        table.insert( t, path )

    end

    local function onDirectory(directory)

        if not recursive then return end

        local sub = getFiles( directory, patterns, recursive )

        for k,v in ipairs(sub) do table.insert( t, v ) end

    end

    for i,v in ipairs( directory ) do

        if isDirectory(v) then onDirectory(v) else add(v) end

    end


    return t

end

tapLua.FILEMAN = {

    LoadDirectory = LoadDirectory,      getFiles = getFiles

}