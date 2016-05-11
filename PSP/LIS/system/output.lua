__output__ = {{start=1,last=0,content = {}},file = ""}
__output__[1].root = new(String,"["..__system__.user.."@"..__system__.domain.."] ")

__output__[1].mainfeed = pge.font.load("verdana.ttf", 10, PGE_VRAM)

function printOnScreen(s,out)
	out = out or 1
	if type(s) ~= "table" then s = new(String,tostring(s))  end
	local step = 0
	-- // Table type check : if it's a String class table
	for i,v in pairs(s) do
		if i == "value" then
			local line = s:split("\r\n")
			for k,v in pairs(line) do
				__output__[out].last = __output__[out].last + 1
				if __output__[out].last > 26 then __output__[out].start = __output__[out].start+ 1 end
				__output__[out].content[__output__[out].last] = {new(String,v,s:getColor())}
				step = 1
			end
		end
		if step == 1 then break end
	end
	--// If not a string table class 
	if step == 0 then
		__output__[out].last = __output__[out].last + 1
		if __output__[out].last > 26 then __output__[out].start = __output__[out].start+ 1 end
		__output__[out].content[__output__[out].last] = s
	end
end

function printOnFile(s,out)
	out = __output__.file
	local tmp = io.open(out,"a")
	if type(s) ~= "table" then s = new(String,tostring(s))  end
	local step = 0
	-- // Table type check : if it's a String class table
	for i,v in pairs(s) do
		if i == "value" then
			local line = s:split("\r\n")
			for k,v in pairs(line) do
				tmp:write(v.."\r\n")
				step = 1
			end
		end
		if step == 1 then break end
	end
	--// If not a string table class 
	if step == 0 then
		tmp:write(s().."\r\n")
	end
	tmp:close()
end

print = printOnScreen
print(new(String,"LIS - Lua Interactive Shell\r\nBy Shaolan\r\n",pge.gfx.createcolor(255,255,0)),1)

function cout(out) __output__[out].display() end

__output__[1].display = function ()
	pge.gfx.startdrawing()
	pge.gfx.clearscreen()
	__output__[1].mainfeed:activate()
	local y,x = 0,0
	for i=__output__[1].start,__output__[1].start + 25 do
		for j=1,table.getn(__output__[1].content[i]) do
			__output__[1].mainfeed:print(x,y,__output__[1].content[i][j]:getColor(),__output__[1].content[i][j]())
			x = x + __output__[1].content[i][j]:len()*10
		end
			if i+1 > __output__[1].last then break end
			y,x = y + 10,0
	end
	local lastOutput  = __output__[1].root +__input__.content
	for i,v in pairs(lastOutput:split("\r\n")) do
		y = y + 10
		__output__[1].mainfeed:print(0,y,pge.gfx.createcolor(255, 255, 255),v)
	end
	if __input__.status == 1 then __input__.play() end
	pge.gfx.enddrawing()
	if __wlan__.connecting then 
		local state = pge.utils.netupdate()
		if state ~= PGE_UTILS_DIALOG_RUNNING then __wlan__.connecting = false end
	end
	pge.gfx.swapbuffers()
end

