
local function is(color)

	if type(color) == "table" then
		local red = color[1]
		if type(red) == "number" and #color == 4 then return true end
	end

	return false

end

local function random()

	local s = ""
	for i=1,3 do
		local n = math.random(0, 255) / 255
		n = tostring(n)		s = s .. n .. ", "
	end
	
	return color(s)

end

tapLua:store { Color = { is = is, random = random } }