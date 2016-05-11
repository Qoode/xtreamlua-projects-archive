__input__ = {status = 0,type = 1,type2=1,content = new(String),contentLine=0}


clavier = pge.texture.load("Data/picture/clavier.png") 
clavier1 = pge.texture.load("Data/picture/clavier1.png")
clavier2 = pge.texture.load("Data/picture/clavier2.png")

 __input__.oldpad = {}
 __input__.oldpad.triangle = false
 __input__.oldpad.square = false 
 __input__.oldpad.circle = false
 __input__.oldpad.cross = false


function __input__.add(s)
	__input__.content = __input__.content + s 
	if (((__input__.content:len()-__input__.contentLine) + __output__[1].root:len())%59) == 0 then 
		__input__.content = __input__.content + "\r\n" 
		__input__.contentLine = __input__.contentLine+2
	end
end

function __input__.sub() __input__.content = new(String,__input__.content:sub(0,-2)) end	

function __input__.play()
	if pge.controls.pressed(PGE_CTRL_LTRIGGER) then
		pge.delay(1000)
		if __input__.type == 2 then __input__.type = __input__.type2
		else __input__.type2,__input__.type = __input__.type2,2  end
	end
	if pge.controls.pressed(PGE_CTRL_RTRIGGER) then
		pge.delay(1000)
		if __input__.type == 1 then __input__.type = 3
		else __input__.type = 1	end
	end
	
   if __input__.type == 1 then
	clavier:activate()
	clavier:draw(323,100,151,151,0,0,151,151)
      --milieu        
      if pge.controls.analogx() > -50 and pge.controls.analogx() < 50 and pge.controls.analogy() > -50 and pge.controls.analogy() < 50 then
         clavier:draw(374,151,49,49,202,51,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.sub() end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("m") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add(" ") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("n") end
      end
      --haut gauche
      if pge.controls.analogx() < -50 and pge.controls.analogy() < -50 then
         clavier:draw(324,101,49,49,152,1,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add(",") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square)  then __input__.add("a") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross)  then __input__.add("b") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle)  then __input__.add("c") end
      end
      --haut milieu
      if pge.controls.analogx() > -50 and pge.controls.analogx() < 50 and pge.controls.analogy() < -50 then
         clavier:draw(374,101,49,49,202,1,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add(".") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("d") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("e") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("f") end
      end
      --haut droite
      if pge.controls.analogx() > 50 and pge.controls.analogy() < -50 then
         clavier:draw(424,101,49,49,252,1,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add("!") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("g") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("h") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("i") end
      end
      --gauche
      if pge.controls.analogx() < -50 and pge.controls.analogy() > -50 and pge.controls.analogy() < 50 then
         clavier:draw(324,151,49,49,152,51,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add("-") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("j") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("k") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("l") end
      end
      --droite
      if pge.controls.analogx() > 50 and pge.controls.analogy() > -50 and pge.controls.analogy() < 50 then
         clavier:draw(424,151,49,49,252,51,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add("?") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("o") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("p") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("q") end
      end
      --bas gauche
      if pge.controls.analogx() < -50 and pge.controls.analogy() > 50 then
         clavier:draw(324,201,49,49,152,101,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add("(") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("r") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("s") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("t") end
      end
      --bas milieu
      if pge.controls.analogx() > -50 and pge.controls.analogx() < 50 and pge.controls.analogy() > 50 then
         clavier:draw(374,201,49,49,202,101,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add(":") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("u") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("v") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("w") end
      end
      --bas droite
      if pge.controls.analogx() > 50 and pge.controls.analogy() > 50 then
         clavier:draw(424,201,49,49,252,101,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add(")") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("x") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("y") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("z") end
      end
   end
   if __input__.type == 2 then
	clavier1:activate()
	clavier1:draw(323,100,151,151,0,0,151,151)
      --milieu
      if pge.controls.analogx() > -50 and pge.controls.analogx() < 50 and pge.controls.analogy() > -50 and pge.controls.analogy() < 50 then
         clavier1:draw(374,151,49,49,202,51,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.sub() end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add(" ") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("5") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("\r\n") end
      end
      --haut gauche
      if pge.controls.analogx() < -50 and pge.controls.analogy() < -50 then
         clavier1:draw(324,101,49,49,152,1,49,49)
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("1") end
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add("<") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add(">") end
      end
      --haut milieu
      if pge.controls.analogx() > -50 and pge.controls.analogx() < 50 and pge.controls.analogy() < -50 then
         clavier1:draw(374,101,49,49,202,1,49,49)
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("2") end
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add("[") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("]") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("~") end
      end
      --haut droite
      if pge.controls.analogx() > 50 and pge.controls.analogy() < -50 then
         clavier1:draw(424,101,49,49,252,1,49,49)
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("3") end
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add("{") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("}") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("#") end
      end
      --gauche
      if pge.controls.analogx() < -50 and pge.controls.analogy() > -50 and pge.controls.analogy() < 50 then
         clavier1:draw(324,151,49,49,152,51,49,49)
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("4") end
      end
      --droite
      if pge.controls.analogx() > 50 and pge.controls.analogy() > -50 and pge.controls.analogy() < 50 then
         clavier1:draw(424,151,49,49,252,51,49,49)
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("6") end
      end
      --bas gauche
      if pge.controls.analogx() < -50 and pge.controls.analogy() > 50 then
         clavier1:draw(324,201,49,49,152,101,49,49)
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("7") end
      end
      --bas milieu
      if pge.controls.analogx() > -50 and pge.controls.analogx() < 50 and pge.controls.analogy() > 50 then
         clavier1:draw(374,201,49,49,202,101,49,49)
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("8") end
      end
      --bas droite
      if pge.controls.analogx() > 50 and pge.controls.analogy() > 50 then
         clavier1:draw(424,201,49,49,252,101,49,49)
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("0") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("9") end
      end
   end
	
	if __input__.type == 3 then
	clavier2:activate()
	clavier2:draw(323,100,151,151,0,0,151,151)
      --milieu
      if pge.controls.analogx() > -50 and pge.controls.analogx() < 50 and pge.controls.analogy() > -50 and pge.controls.analogy() < 50 then
         clavier2:draw(374,151,49,49,202,51,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle)then __input__.sub() end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square)then __input__.add("M") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add(" ") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("N") end
      end
      --haut gauche
      if pge.controls.analogx() < -50 and pge.controls.analogy() < -50 then
         clavier2:draw(324,101,49,49,152,1,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add("^") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("A") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("B") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("C") end
      end
      --haut milieu
      if pge.controls.analogx() > -50 and pge.controls.analogx() < 50 and pge.controls.analogy() < -50 then
         clavier2:draw(374,101,49,49,202,1,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add("@") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("D") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("E") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("F") end
      end
      --haut droite
      if pge.controls.analogx() > 50 and pge.controls.analogy() < -50 then
         clavier2:draw(424,101,49,49,252,1,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add("*") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("G") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("H") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("I") end
      end
      --gauche
      if pge.controls.analogx() < -50 and pge.controls.analogy() > -50 and pge.controls.analogy() < 50 then
         clavier2:draw(324,151,49,49,152,51,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add("_") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("J") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("K") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("L") end
      end
      --droite
      if pge.controls.analogx() > 50 and pge.controls.analogy() > -50 and pge.controls.analogy() < 50 then
         clavier2:draw(424,151,49,49,252,51,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add("\"") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("O") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("P") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("Q") end
      end
      --bas gauche
      if pge.controls.analogx() < -50 and pge.controls.analogy() > 50 then
         clavier2:draw(324,201,49,49,152,101,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add("=") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("R") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("S") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("T") end
      end
      --bas milieu
      if pge.controls.analogx() > -50 and pge.controls.analogx() < 50 and pge.controls.analogy() > 50 then
         clavier2:draw(374,201,49,49,202,101,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add(";") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("U") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("V") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("W") end
      end
      --bas droite
      if pge.controls.analogx() > 50 and pge.controls.analogy() > 50 then
         clavier2:draw(424,201,49,49,252,101,49,49)
         if pge.controls.pressed(PGE_CTRL_TRIANGLE) and not(__input__.oldpad.triangle) then __input__.add("/") end
         if pge.controls.pressed(PGE_CTRL_SQUARE) and not(__input__.oldpad.square) then __input__.add("X") end
         if pge.controls.pressed(PGE_CTRL_CROSS) and not(__input__.oldpad.cross) then __input__.add("Y") end
         if pge.controls.pressed(PGE_CTRL_CIRCLE) and not(__input__.oldpad.circle) then __input__.add("Z") end
      end
   end
   if pge.controls.pressed(PGE_CTRL_SELECT) then  __input__.status = 0 pge.delay(1000) end
   
   if pge.controls.pressed(PGE_CTRL_TRIANGLE) then __input__.oldpad.triangle = true
   else __input__.oldpad.triangle = false end
   if pge.controls.pressed(PGE_CTRL_SQUARE) then __input__.oldpad.square = true 
   else __input__.oldpad.square = false end 
   if pge.controls.pressed(PGE_CTRL_CIRCLE) then __input__.oldpad.circle = true 
   else __input__.oldpad.circle = false end 
   if pge.controls.pressed(PGE_CTRL_CROSS) then __input__.oldpad.cross = true  
   else __input__.oldpad.cross = false end 
   if pge.controls.pressed(PGE_CTRL_LTRIGGER) then __input__.oldpad.l = true 
   else __input__.oldpad.l = false end 
   if pge.controls.pressed(PGE_CTRL_RTRIGGER) then __input__.oldpad.r = true 
   else __input__.oldpad.r = false end 
end   