
local function shouldSkip( toSkip, path )

    if not toSkip then return false end

    for _, skip in ipairs(toSkip) do if path:match(skip) then return true end end

    return false

end

local function LoadModules( directory, toSkip, isDeep )

    local former = directory
    if type(directory) == "string" then
        directory = FILEMAN:GetDirListing( directory, false, true )
    end

    if type(toSkip) == "string" then toSkip = { toSkip } end

    for k,v in pairs(directory) do      
        
        local shouldSkip = shouldSkip( toSkip, v )
        local allow = k ~= #directory and not isDeep
        allow = allow or isDeep

        if allow and not shouldSkip then

            if v:match(".lua") then loadfile(v)() else 
                LoadModules( FILEMAN:GetDirListing( v .. '/', false, true ), toSkip, true ) 
            end

        end
        
    end

end

tapLua.OutFox.FILEMAN = {

    getFiles = function( path )

        local output = {}
        local onlyDirs = FILEMAN:GetDirListing( path, true, true )
        local toFilter = FILEMAN:GetDirListing( path, false, true )
        
        for _,v1 in pairs( toFilter ) do

            local skip = false		
            
            for _, v2 in pairs( onlyDirs ) do if v1 == v2 then skip = true break end end

            if not skip then output[#output+1] = v1 end

        end
    
        return output
    
    end,
    
    getFilesBy = function( directories, pattern, lookDeep )

        if type(pattern) == "string" then pattern = { pattern } end

        local output = {}
        for k, v in pairs( directories ) do

            local list = { v }
            if ActorUtil.GetFileType(v) == 'FileType_Directory' then
                list = FILEMAN:GetDirListing( v .. "/", false, true )
            end

            for _, ext in ipairs(pattern) do
                for k2, v2 in pairs(list) do if v2:match( ext .. "$" ) then output[#output+1] = v2 end end
            end

        end
    
        return output
    
    end,

    LoadModules = LoadModules

}