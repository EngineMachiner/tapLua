
local Load = Sprite.Load
local LoadThreaded = Sprite.LoadThreaded
local SetStateProperties = Sprite.SetStateProperties

local Sprite = tapLua.Sprite

local isString = Astro.Type.isString             local isTexture = tapLua.Type.isTexture

local functions = {

    [isString] = function( self, ... )
        
        local Load = LoadThreaded or Load         Load( self, ... )
    
    end,

    [isTexture] = function( self, texture ) self:SetTexture(texture) end

}

Sprite.Load = function( self, x )

    for k,v in pairs(functions) do if k(x) then v( self, x ) break end end          return self

end

Sprite.SetStateProperties = function( self, stateProperties )

    self.stateProperties = stateProperties            return SetStateProperties( self, stateProperties )

end