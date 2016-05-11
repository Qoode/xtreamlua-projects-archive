menuData = {background = Image.load("Data/Picture/Background/bg7.png"),fontColor = Color.new(255,255,255),bgColor = Color.new(250,189,5,180),box = {scrollX = 140,scrollY = 80}, count = 0,phase = 1,selector = 1,menuAct = 1,content = {}}
menuData.boxPicV = Image.createEmpty(140,272)
menuData.boxPicH = Image.createEmpty(480,80)
menuData.boxPicV:clear(menuData.bgColor)
menuData.boxPicH:clear(menuData.bgColor)

--/ Contenu du menu Main
menuData.content[1] = {}
menuData.content[1].n = 5
menuData.content[1].name = "mainBox"

--/ Contenu du menu Versus 
menuData.content[2] = {}
menuData.content[2].n = 3
menuData.content[2].name = "versusBox"


Font.init()
Font.load("Data/Common/menu.ttf",20,20)


Mp3me.load("Data/Music/menu.mp3")
Mp3me.play()

math.randomseed(os.time())
function reloadScreen()
 screen:clear()
 screen:blit(0,0,menuData.background)
 screen:blit(0,272 - menuData.box.scrollY,menuData.boxPicH)
 screen:blit(0 - menuData.box.scrollX,0,menuData.boxPicV)
 screen:drawLine(menuData.box.scrollX,0,menuData.box.scrollX,272,Color.new(255,255,255))
 if menuData.phase == 0 then
  screen:blit(0,0,Image.load("Data/Picture/Interface/menu/"..menuData.content[menuData.menuAct].name..".png"))
  screen:drawLine(5,(menuData.selector*40)-10,135,(menuData.selector*40)-10,Color.new(255,255,255))
 end 
 screen.flip()
 screen.waitVblankStart()
end


reloadScreen()

Mp3me.load("Data/Music/menu.mp3")
Mp3me.play()
while true do 

 pad = Controls.read()

 --#// Phase d'animation du menu 
 if menuData.phase == 1 then
  if not(menuData.box.scrollX == 0) and menuData.box.scrollY == 0 and menuData.count == 5 then
   menuData.box.scrollX =  menuData.box.scrollX  - 20
   reloadScreen()
  elseif menuData.box.scrollX == 0 and menuData.box.scrollY == 0 then
   menuData.phase = 0
   menuData.count = 0
   reloadScreen()
  end
 
  if not(menuData.box.scrollY == 0) then
   menuData.box.scrollY =  menuData.box.scrollY - 20
   reloadScreen()
  else 
   if not(menuData.count == 5) then
    menuData.count = menuData.count + 1
   end
  end
 elseif menuData.phase == 2 then
  if not(menuData.box.scrollX == 140) and menuData.box.scrollY == 80 and menuData.count == 5 then
   menuData.box.scrollX =  menuData.box.scrollX + 20
   reloadScreen()
  elseif menuData.box.scrollX == 140 and menuData.box.scrollY == 80 then
   menuData.phase = 1
   System.sleep(500)
   menuData.count = 0
   reloadScreen()
  end
 
  if not(menuData.box.scrollY == 80) then
   menuData.box.scrollY =  menuData.box.scrollY + 20
   reloadScreen()
  else 
   if not(menuData.count == 5) then
    menuData.count = menuData.count + 1
   end
  end  
 end

 if menuData.phase == 0 then
  if pad:cross() then
   System.sleep(150)
   menuData.phase = 2
   if menuData.menuAct == 1 then 
    if menuData.selector == 1 then
     menuData.menuAct = 2
    end
   elseif menuData.menuAct == 2 then
     if menuData.selector == 1 then
    elseif menuData.selector == 2 then
    elseif menuData.selector == 3 then
     Mp3me.stop()
     dofile("System/game.lua")
    end
   end
  end
  if pad:circle() then
   System.sleep(150)
   menuData.phase = 2
   if menuData.menuAct == 1 then
   elseif menuData.menuAct == 2 then
    menuData.menuAct = 1  
   end
  end 
 
  if pad:up() and not(menuData.selector == 1) then
   System.sleep(150)
   menuData.selector = menuData.selector - 1
   reloadScreen()
  end 
  if pad:down() and not(menuData.selector == menuData.content[menuData.menuAct].n) then
   System.sleep(150)
   menuData.selector = menuData.selector + 1
   reloadScreen()
  end 
 end
end