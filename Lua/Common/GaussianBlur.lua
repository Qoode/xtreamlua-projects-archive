--::::::::::::::::::::::::::::::::

--::::::::::::::::::::::::::::::::

-- Retourne un kernel de gauss
function getGaussianKernel(radius,sigma)
	local kernel = {}
	local width = 2*radius+1
	local height = width
	local GKF , e = 0 , 0
	--
	for i = 0-radius,radius do
		for j = 0-radius,radius do
			e = math.exp( (-1*((i*i)+(j*j))) / (2*sigma*sigma))
			GKF = GKF + e
			kernel[i+radius][j+radius] = e
		end
	end
	-- 
	for i = 0-radius,radius do
		for j = 0-radius,radius do
			kernel[i+radius][j+radius] = kernel[i+radius][j+radius] / GKF 	
		end
	end
	return kernel
end

-- Retourne le voisinage d'un pixel 
function GetV(p,x,y,r)
	local V = {}
	for i = 0 - r , r do
		for j = 0 - r, y  do
			if (i >= 0 and j >=0 and i < p:width() and j < p:height()) V[i][j] = p:pixel(x+i,y+j)
	end end
	return V
end

-- Determine le facteur de normalisation
local function GetNormalizeFactor(k)
	local p,n = 0 , 0
	for i,line in pairs(k) do
		for j, value in pairs(line) do
			if (value < 0) n = n + value
			else p = p + value
		end
	end
	p , n = math.abs(p),math.abs(n)
	return (((p > n) and p) or n)
end

-- Retourne une image flouter
function gaussianBlur(picture,radius,sigma)
	local kernel = getGaussianKernel(radius,sigma)
	local factor = GetNormalizeFactor(kernel)
	local w,h = picture:width(),picture:height()
	local target = Image.createEmpty(w,h)
	for x = 0 , w-1 do
		for y = 0 , h-1 do
			-- On recupere le voisinage du pixel
			local V = GetV(picture,x,y,radius)
			-- On lui applique le noyau de gauss
			for i,v in pairs(V) do
				for j,k in pairs(v) do
					if k then
						local c = k:colors()
						for key,value in pairs(c) do c[key] = math.floor(math.abs(value * kernel[i][j])/factor)) end
						target:pixel(x,y,Color.new(c.r,c.g,c.b))		
					end 
				end 
			end
		end
	end
	return target
end

local i = Image.load("pic.png")
local o = gaussianBlur(i,3,5)

while true do
	screen:clear()
	screen:blit(0,0,o)
	screen.flip()
	screen.waitVblankStart()
end