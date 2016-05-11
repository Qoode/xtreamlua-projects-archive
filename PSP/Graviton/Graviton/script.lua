dofile("System/menu.lua")
dofile("System/map.lua")

Mp3me.load("Data/Music/bgm1.mp3")
Mp3me.play()

hao = Image.load("Data/Picture/Art/face/hao.png")
tempHao = Image.createEmpty(hao:width(),hao:height())
for i=0,hao:width()-1 do
 for j=0,hao:height()-1 do
  tempHao:pixel((hao:width()-1)-i,j,hao:pixel(i,j))
 end
end
hao = tempHao
tempHao = nil
collectgarbage()

lucy = Image.load("Data/Picture/Art/face/lucy.png")
--# Phase de determination des affinités joueur / ennemi  
affinity = {}
math.randomseed(os.time())
affinity.Pprimary = math.random(1,4) 
while true do
 affinity.Psecondary = math.random(1,4)
 if not(affinity.Psecondary == affinity.Pprimary) then
  break
 end
end 
while true do
 affinity.Eprimary = math.random(1,4)
 if not(affinity.Eprimary == affinity.Pprimary) and not(affinity.Eprimary == affinity.Psecondary) then
  break
 end
end 
for i=1,4 do
 if not(affinity.Eprimary == i) and not(affinity.Pprimary == i) and not(affinity.Psecondary == i) then
  affinity.Esecondary = i
  break
 end
end

grille = Map.new("bg1",2)

scrCount = 1


function reloadScreen()
 screen:clear()
 grille.play()
 screen:blit(0,0,lucy)
 screen:blit(480-hao:width(),0,hao)
 screen.flip()
 screen.waitVblankStart()
end

while true do
 pad = Controls.read()
 if not(animPlayed) then
  if grille.getSide() == "horizontal" then
   if pad:right() and grille.getLine() ~= 7 then
    System.sleep(150)
    grille.setLine(grille.getLine() + 1)
    grille.reload()
   end
   if pad:left() and grille.getLine() ~= 0  then
    System.sleep(150)
    grille.setLine(grille.getLine() - 1)
    grille.reload() 
   end
   if pad:up() then
    System.sleep(150)
    grille.move("left")
    animPlayed = true
   end
   if pad:down() then
    System.sleep(150)
    grille.move("right")
    animPlayed = true
   end
  elseif grille.getSide() == "vertical" then
    if pad:down() and grille.getLine() ~= 7 then
    System.sleep(150)
    grille.setLine(grille.getLine() + 1)
    grille.reload()
   end
   if pad:up() and grille.getLine() ~= 0  then
    System.sleep(150)
    grille.setLine(grille.getLine() - 1)
    grille.reload() 
   end
   if pad:left() then
    System.sleep(150)
    grille.move("left")
    animPlayed = true
   end
   if pad:right() then
    System.sleep(150)
    grille.move("right")
    animPlayed = true
   end
  end
  if pad:cross() then
   System.sleep(150)
   if grille.getSide() == "horizontal" then 
    grille.setSide("vertical")
   elseif grille.getSide() == "vertical" then
    grille.setSide("horizontal")   
   end
   grille.reload()
  end
  if pad:r() then
   System.sleep(150)
   grille.tempE(1)
   grille.reload()
  end 
  if pad:l() then
   System.sleep(150)
   grille.tempE(0)
   grille.reload()
  end 
 end
 
 if pad:triangle() then
  screen:save("scr"..scrCount..".png")
  scrCount = scrCount + 1
 end
 
 reloadScreen()
end

