dofile("data/config")
require("system/core")

while true do 
	pge.controls.update()
	cout(__system__.out)
	if pge.controls.pressed(PGE_CTRL_SELECT) then
		if __input__.status == 0 then __input__.status = 1 
		elseif __input__.status == 1 then __input__.status = 0 end
		pge.delay(1000)
	elseif pge.controls.pressed(PGE_CTRL_CROSS) and __input__.status == 0 and not(__wlan__.connecting) then
		pge.delay(1000)
		print(__output__[1].root()..__input__.content(),1)
		if string.find(__input__.content(),"^\./[0-9A-Za-z._-]+") then -- Command script execution
			dofile(string.sub(__input__.content(),2))
		else
			local bin = __input__.content:split()[1]
			if string.find(__input__.content(),">") then
				local t = __input__.content:split(">")
				__output__.file = string.gsub(t[2]," ","")
				print = printOnFile
			end	
			if __bin__.exist(bin) then 
				if string.find(__input__.content(),">") then
					execute(new(String,string.sub(__input__.content(),0,string.find(__input__.content(),">")-1))) -- Commande execution
				else
					execute(__input__.content)
				end
			else
				e = new(String,bin.." : command not found",pge.gfx.createcolor(255,255,0));
				print(e)
			end
		end	
		print = printOnScreen
		__output__.file = ""
		__input__.content("")
		__input__.contentLine = 0
	elseif pge.controls.pressed(PGE_CTRL_UP) and __output__[1].start ~= 0 then
		pge.delay(1000)
		__output__[1].start = __output__[1].start - 1
	elseif pge.controls.pressed(PGE_CTRL_DOWN) and __output__[1].start+26 ~= __output__[1].last+1 then
		pge.delay(1000)
		__output__[1].start = __output__[1].start + 1	
	elseif pge.controls.pressed(PGE_CTRL_START) then
		local len,n,result = string.len(__input__.content()),0,{}
		for i,v in pairs(__bin__) do
			if string.sub(i,0,len) == __input__.content() then 
				table.insert(result,i) 
				n = n+1
			end
		end
		for i,v in pairs(__system__.filelist) do
			if string.sub(v.name,0,len) == __input__.content() then 
				table.insert(result,v.name) 
				n = n+1
			end
		end
		if n == 1 then
			__input__.content(result[1])
		elseif n ~= 0 then
			print(__output__[1].root()..__input__.content(),1)
			for i,v in ipairs(result) do print(new(String,v,pge.gfx.createcolor(255,255,0))) end
		end
	end
end
