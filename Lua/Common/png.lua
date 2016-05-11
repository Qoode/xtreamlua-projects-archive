

--[[
local min , pow = math.min , math.pow
local insert = table.insert


-- Cast the given integer to a byte array
function toByteArray(n)
	local p,q,r,i,b = n , 0 , 0 , 0 , {}
	for i=0,7 do b[i] = 0 end
	while (p ~= 0) do
		b[i] = p % 2
		i , p = i+1 , math.floor(p/2)
	end
	return b
end

-- Cast the given byte array to a integer
function toInteger(b) local r = 0; for i = 0,#b do r=r+pow(2,#b-i) end; return r; end

-- Bit Or (assume that A and B get the same size)
function bor(a,b) local n = {}; for i = 0, #a do n[i] = (((a[i] == 1 or b[i] == 1) and 1) or 0) end; return r; end

-- Left shift
function leftShift(a,n) return a * pow(2,n); end

-- Parse a 4 bytes integer
function GetInteger(f) return toInteger(
	bor(toByteArray(f[1]),
		bor(toByteArray(leftShift(f[2],8)),
			bor(toByteArray(leftShift(f[3],16)),
				toByteArray(leftShift(f[4],24)))))); end
]]--


local pow = math.pow
local insert = table.insert
local remove = table.remove
local join = table.concat

-- Transforme un entier en un tableau de bit
local function toByteArray(n)
	local p,q,r,i,b = n , 0 , 0 , 0 , {}
	for i=0,7 do b[i] = 0 end
	while (p ~= 0) do
		b[i] = p % 2
		i , p = i+1 , math.floor(p/2)
	end
	return b
end


-- Decalage de bit a gauche
local function L(a,b) return a * pow(2,b) end

-- OU bit à bit
local function bor(a,b)
	local A , B , N = toByteArray(a) , toByteArray(b) , {}
	for i = 0, math.max(#A,#B) do
		if i > #A then N[i] = B[i]
		elseif i > #B then N[i] = A[i]
		elseif A[i] == 1 or B[i] == 1 then N[i] = 1
		else N[i] = 0
	end end
	local r = 0
	for i = 0,#N do r = r + pow(2,#N-i) end
	return r
end

local function GetSize(a,b,c,d) return bor(bor(bor(L(a,21),L(b,14)),L(c,7)),d) end

-- Read the given number of byte from the given stream and put it into an array
function readByteArray(f,n) local b = {}; for _ = 1,n do insert(b,tostring(f:read(1)):byte()) end; return b; end

-- Read the PNG width and height
function readPngSize(path)
	local f = io.open(path,"rb");
	-- Assume that the file is a correct PNG file and ignore PNG signature check
	f:read(16);
	return GetSize(unpack(readByteArray(f,4))) , GetSize(unpack(readByteArray(f,4)));
end
