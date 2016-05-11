nano = {tmp = {},y = 0}


function nano.save()
end

function __bin__.nano(f)
	nano.tmp , nano.y = {} , 1
	local run = 1
	if f then
		local tmp = io.open(f,"r")
		local copy = io.open("temp","w")
		nano.len = 0
		for i in tmp:lines(tmp) do
			table.insert(nano.tmp,i)
			copy:write(i)
			nano.len = nano.len + 1
		end
	end	
	while run do
		cout("nano")
		if pge.controls.pressed(PGE_CTRL_SELECT) then
			if __input__.status == 0 then __input__.status = 1 
			elseif __input__.status == 1 then __input__.status = 0 end
			pge.delay(1000)
		end
		if pge.controls.pressed(PGE_CTRL_START) then break end
	end
end

__output__.nano = {}

function __output__.nano.display()
	pge.gfx.startdrawing()
	pge.gfx.clearscreen()
	pge.gfx.drawrect(0,0,480,10,pge.gfx.createcolor(100,255,0))
	pge.gfx.drawrect(0,262,480,10,pge.gfx.createcolor(100,255,0))
	__output__[1].mainfeed:activate()
	local j = nano.y
	for i=10,250,10 do
			if j == nano.len then break end
			__output__[1].mainfeed:print(0,i,pge.gfx.createcolor(100,255,0),nano.tmp[j])
			j = j + 1
	end
	if __input__.status == 1 then __input__.play() end
	pge.gfx.enddrawing()
	pge.gfx.swapbuffers()
end
