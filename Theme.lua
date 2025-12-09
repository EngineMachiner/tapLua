
local t = Def.ActorFrame { tapLua.Load("Sprite/Renderer") }

t.add = function(actor) table.insert( t, actor ) end

tapLua.PersistentActors = t