function __bin__.lua(file)
	if file == nil then
		local outputRootBackup = __output__[1].root()
		__output__[1].root("> ")
		__input__.content("")
		while true do
			pge.controls.update()
			cout(1)
			if pge.controls.pressed(PGE_CTRL_SELECT) then
				if __input__.status == 0 then __input__.status = 1 
				elseif __input__.status == 1 then __input__.status = 0 end	
				pge.delay(1000)
			elseif pge.controls.pressed(PGE_CTRL_CROSS) and __input__.status == 0 then
				pge.delay(1000)
				print(__output__[1].root()..__input__.content(),1)
				-- execution
				local exe = __input__.content:execute()
				if exe ~= true then print(new(String,exe,pge.gfx.createcolor(255,0,0))) end
				-- fin
				__input__.content("")
				__input__.contentLine = 0
			elseif pge.controls.pressed(PGE_CTRL_START) then 
				print(new(String,"Bye !",pge.gfx.createcolor(255,255,0)),1)
				break 
			end
		end
		__output__[1].root(outputRootBackup)
		__input__.content("")
		__input__.contentLine = 0
		cout(1)
	else
	end
end