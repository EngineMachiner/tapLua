
local isString = Astro.Type.isString            local isTexture = tapLua.Type.isTexture

local functions = {

    [isString] = function( self, ... )
        
        local Load = self.LoadThreaded or self.Load         Load( self, ... )
    
    end,

    [isTexture] = function( self, texture ) self:SetTexture(texture) end

}

local function LoadBy( self, x )

    for k,v in pairs(functions) do if k(x) then v( self, x ) break end end

    return self

end

tapLua.Sprite.LoadBy = LoadBy