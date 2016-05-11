-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- %_% -( it's just an awesome Music Player ! Such an amazing code !)
--
-- ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

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

--
function GetID3Tag(path)
	local handle = io.open(path,"r")
	if not(handle) or not(handle:read(3) == "ID3") then return {} end
	local header , frame = {} , {}
	-- Etape 1 : traitement du header
	for i = 1,7 do insert(header,handle:read(1):byte()) end
	remove(header,1) -- Major version
	remove(header,1) -- Revision
	local flag = toByteArray(remove(header,1))
	local totalSize = GetSize(unpack(header))
	print("Total size :",totalSize)
	-- Etape 2 : traitement des frames
	local readSize = 0
	while readSize < totalSize do
		-- Lecture du frame header
		local key = handle:read(4)
		local frameSize = 0
		for i = 1,4 do frameSize = frameSize + handle:read(1):byte() end
		local flags = { handle:read(1) , handle:read(1) }
		-- Lecture de la frame
		local byteBuffer = {}
		for i = 1,frameSize do
			local byte = handle:read(1)
			if not(byte) then
				handle:close()
				return frame
			end
			insert(byteBuffer,byte)
			if byteBuffer[i]:byte() == 0 then byteBuffer[i] = "" end
		end
		-- Display data
		frame[key] = join(byteBuffer,"")
		if (frameSize > 0) then
			print("-----------------")
			print("Tag ID :",key)
			print("Frame size :",frameSize)
			print("Content :",frame[key])
		end
		readSize = readSize + 10 + frameSize
	end
	return frame
end

