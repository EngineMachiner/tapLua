
local astro = Astro.Type            local isString = astro.isString

astro = Astro.Table


local function paths( directory )

    local endsWith = directory:Astro():endsWith('/')

    if not endsWith then directory = directory .. '/' end

    return FILEMAN:GetDirListing( directory, false, true )

end

local function isDirectory(path)

    local type = ActorUtil.GetFileType(path)        return type:match('Directory')

end

local function matches( tbl, val )

    local isValid = function( k, v ) return val:match(v) end

    return astro.contains( tbl, isValid )

end

local function currentPath()

    local path = debug.getinfo( 3, "S" )       path = path.source

    if path:sub( 1, 1 ) == "@" then path = path:sub(2) end

    return path

end


local function LoadDirectory( directory, blacklist, recursive )

    blacklist = blacklist or {}         table.insert( blacklist, currentPath() )

    if isString(directory) then directory = paths( directory ) end

    if isString(blacklist) then blacklist = { blacklist } end


    local function isBlacklisted(path)

        return blacklist and matches( blacklist, path )
    
    end
    
    local function load(path)

        if isBlacklisted(path) then return end


        local endsWith = path:Astro():endsWith("%.lua")

        if endsWith then print(path) dofile(path) return end
        

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

    for i,v in ipairs(directory) do

        if isDirectory(v) then onDirectory(v) else add(v) end

    end


    return t

end

tapLua.FILEMAN = { LoadDirectory = LoadDirectory,      getFiles = getFiles }