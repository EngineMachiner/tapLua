
local function toUnit(tbl)

	local norm = 0
	for k,v in pairs(tbl) do norm = norm + ( v ) ^ 2 end		norm = math.sqrt(norm)

	for k,v in pairs(tbl) do if v ~= 0 then tbl[k] = v / norm end end

	return tbl

end

local function isZero(t)
	return ( t.x or 0 ) == 0 and ( t.y or 0 ) == 0 and ( t.z or 0 ) == 0
end

local function hasCoords(t) return not ( t[1] and t[2] and true ) end

-- Convert index tables to coordinates.
local toCoordsPairs = { x = 1, y = 2, z = 3 }
local function toCoords(t)

	if not t or ( t and hasCoords(t) ) then return t end

	local new = {}
	
	for k,v in pairs(toCoordsPairs) do new[k] = t[v] end

	return new

end

-- Consider this as it was made for OutFox coords system.
local names = { 
	Left = { x = - 1, y = 0 },			Right = { x = 1, y = 0 },
	Up = { x = 0, y = - 1 },			Down = { x = 0, y = 1 },
	UpLeft = { x = - 1, y = - 1 },		UpRight = { x = 1, y = - 1 },
	DownLeft = { x = - 1, y = 1 },		DownRight = { x = 1, y = 1 },
}

local function getByName(name)
	for k,v in pairs(names) do if name == k then return v end end
	return name
end

-- Get polar angle of a vector in degrees.
local function getAngle( vector, axis1, axis2 )

	local unit = {}					DeepCopy(vector, unit)
	toUnit(unit)

	axis1 = axis1 or 'x'			axis2 = axis2 or 'y'

	local angle = math.atan( unit[axis2] / unit[axis1] )		angle = math.deg(angle)

	if unit[axis1] < 0 then angle = angle + 180 end

	angle = angle % 360

	return angle

end

tapLua:store {

	Vector = {
		toUnit = toUnit, 			isZero = isZero,
		hasCoords = hasCoords, 		toCoords = toCoords,
		getByName = getByName,		getAngle = getAngle
	}

}
