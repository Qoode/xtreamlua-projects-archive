--//==========================================
--// Sequences d'intro \ chargement des libs
--//==========================================

compteur = 1
--// Chargement des ressources graphiques
background = Image.load("system/data/bg.png")
fader = Image.load("system/data/bg.png")
white = Color.new(255,255,255)

--// Fondu
alphaValue = 255 
faderColor = Color.new(0,0,0,alphaValue) 
fader:clear(faderColor) 
 while true do 
  screen:clear()
  screen:blit(0,0,background)
  screen:blit(0,0,fader)
  if alphaValue > 0 then
   alphaValue = alphaValue - 5
  else
   break
  end
  faderColor = Color.new(0,0,0,alphaValue)
  fader:clear(faderColor)
  screen.flip()
  screen.waitVblankStart()
 end

fader = nil
faderColor = nil
alphaValue = nil
 
--// Chargement des libraries
dofile("system/script/dataload.lua")
pic = nil

--// Initialisation de la souris
cursor = Mouse.new()
firstVerticeSelected = false

--#==================================================
--//fonction de rafraichissement de l'ecran
--#==================================================
function playI()
 screen:clear() -- Efface l'ecran
 screen:blit(0,0,background) -- Impression du fond
 screen:blit(99,20,cadre) -- Impression du cadre de visualisation
 screen:blit(9,10,palette) -- Impression de la pallette

 -- Affichage de l'image (si y y en a une)
 if documentOpen then 
  picP = document.img()
  if picP:width() > 360 and picP:height() > 240  then
   screen:blit(100,21,picP,document.scrollX(),document.scrollY(),360,240)
  elseif picP:width() > 360 and picP:height() < 241  then
   screen:blit(100,21,picP,document.scrollX(),document.scrollY(),360,picP:height())
  elseif picP:width() < 361 and picP:height() > 240  then
   screen:blit(100,21,picP,document.scrollX(),document.scrollY(),picP:width(),240)
  else
   screen:blit(100,21,picP)
  end
  
  if onPicture() and brushActive then
   cursor.picE(brushPic,true)
  elseif brushActive and not(onPicture()) then
   cursor.picE("02")
  end
  
  if selectionZoom and not(selectionActive) then
   screen:print(10,130,'Start :',Color.new(0,0,0))
   screen:print(10,145,'Desactiver',Color.new(0,0,0))
   screen:print(10,155,'zoom locale',Color.new(0,0,0))
  end

  if copyPhase and not(selectionZoom) then
   screen:print(10,130,'Carre :',Color.new(0,0,0))
   screen:print(10,145,'Coller',Color.new(0,0,0))
   screen:print(10,155,'selection',Color.new(0,0,0))
  end
  
  if selectionActive and not(selectionZoom) then
   screen:print(10,130,'L + Carre :',Color.new(0,0,0))
   screen:print(10,145,'Supprimer ',Color.new(0,0,0))
   screen:print(10,155,'selection',Color.new(0,0,0))
  end
  
  if brushActive and not(selectionZoom) then
   screen:print(10,130,'Carre :',Color.new(0,0,0))
   screen:print(10,145,'Desactiver ',Color.new(0,0,0))
   screen:print(10,155,'Brush',Color.new(0,0,0))
  end
end
 
 

  
 -- Affichage des boites a outils
 if box.active == "file" then
  screen:blit(180,220,box.file)
  if oldFileOver ~= "none" and fileOver ~= false then
   screen:print(185,225,fileOver,Color.new(0,0,0))
  end
 elseif box.active == "tool" then
  screen:blit(90,220,box.tool)
  if oldToolsOver ~= "none" and toolsOver ~= false then
   screen:print(105,225,toolsOver,Color.new(0,0,0))
  end
 end
 --// Si on est sur l'image on affiche les coordonnees
 if onPicture() then
  screen:print(10,200,'x = '..((cursor.x()-100)+document.scrollX()),Color.new(0,0,0))
  screen:print(10,210,'y = '..((cursor.y()-21)+document.scrollY()),Color.new(0,0,0))
 end
 screen:fillRect(99,3,380,15,Color.new(0,0,0,110))
 screen:fillRect(100,4,378,13,Color.new(255,255,255,110))
 -- Affichage ou non du titre de l'image 
 if documentSave then
  screen:print(103,8,fileName,Color.new(0,0,0))
 elseif documentOpen then
  screen:print(103,8,"Sans titre",Color.new(0,0,0))
 end

 -- Affichage de la 'ligne'
 if firstVerticeSelected and (cursor.statut() == 'line') and (onPicture()) then
  if document.zoomN() == 0 then
   screen:drawLine(firstVerticeX,firstVerticeY,cursor.x(),cursor.y(),param.primaryCO)
  else
   for i=0,document.zoomN()-1 do
    screen:drawLine(((firstVerticeX)-(math.mod(firstVerticeX,document.zoomN())))+i,((firstVerticeY)-(math.mod(firstVerticeY,document.zoomN())))+i,((cursor.x())-(math.mod(cursor.x(),document.zoomN())))+i,((cursor.y())-(math.mod(cursor.y(),document.zoomN())))+i,param.primaryCO)
    screen:drawLine(((firstVerticeX)-(math.mod(firstVerticeX,document.zoomN())))+i,((firstVerticeY)-(math.mod(firstVerticeY,document.zoomN()))),((cursor.x())-(math.mod(cursor.x(),document.zoomN())))+i,((cursor.y())-(math.mod(cursor.y(),document.zoomN()))),param.primaryCO)
    screen:drawLine(((firstVerticeX)-(math.mod(firstVerticeX,document.zoomN()))),((firstVerticeY)-(math.mod(firstVerticeY,document.zoomN())))+i,((cursor.x())-(math.mod(cursor.x(),document.zoomN()))),((cursor.y())-(math.mod(cursor.y(),document.zoomN())))+i,param.primaryCO)
   end
  end
 end
 -- Fin d'affichage de la ligne
 

 --// Partie d'afichage de la copie sur Ecran 
 if copyPhase then
   screen:blit(copyPhaseX,copyPhaseY,tempCopy)
   screen:blit(copyPhaseX,copyPhaseY,tempSelect)
 end

 --// Partie d'affichage de la "selection"
 if selectionActive and not(copyPhase) then
  screen:blit(selectionFirstX,selectionFirstY,tempSelect)
 end

 if firstVerticeSelected and (cursor.statut() == 'select') and onPicture() and not(copyPhase) then
  --// Gauche -> droite |  haut -> bas
  if (cursor.x() >= firstVerticeX) and (cursor.y() >= firstVerticeY) then
   for i=firstVerticeX,cursor.x(),2 do
    screen:pixel(i,firstVerticeY,Color.new(0,0,0))
    if i > cursor.x() then
     break
    end
    screen:pixel(i+1,firstVerticeY,Color.new(255,255,255))
   end 
   for i=firstVerticeX,cursor.x(),2 do
    screen:pixel(i,cursor.y(),Color.new(0,0,0))
    if i > cursor.x() then
     break
    end
    screen:pixel(i+1,cursor.y(),Color.new(255,255,255))
   end
   for i=firstVerticeY,cursor.y(),2 do
    screen:pixel(firstVerticeX,i,Color.new(0,0,0))
    if i > cursor.y() then
     break
    end
    screen:pixel(firstVerticeX,i+1,Color.new(255,255,255))
   end
   for i=firstVerticeY,cursor.y(),2 do
    screen:pixel(cursor.x(),i,Color.new(0,0,0))
    if i > cursor.y() then
   break
  end
    screen:pixel(cursor.x(),i+1,Color.new(255,255,255))
   end
  end
  --// Gauche -> droite | bas -> haut
  if (cursor.x() >= firstVerticeX) and (cursor.y() <= firstVerticeY) then
   for i=firstVerticeX,cursor.x(),2 do
    screen:pixel(i,firstVerticeY,Color.new(0,0,0))
    if i > cursor.x() then
   break
  end
  screen:pixel(i+1,firstVerticeY,Color.new(255,255,255))
   end
   for i=firstVerticeX,cursor.x(),2 do
  screen:pixel(i,cursor.y(),Color.new(0,0,0))
  if i > cursor.x() then
   break
  end
  screen:pixel(i+1,cursor.y(),Color.new(255,255,255))
   end
   for i=cursor.y(),firstVerticeY,2 do
  screen:pixel(firstVerticeX,i,Color.new(0,0,0))
  if i > firstVerticeY then
   break
  end
  screen:pixel(firstVerticeX,i+1,Color.new(255,255,255))
   end
   for i=cursor.y(),firstVerticeY,2 do
  screen:pixel(cursor.x(),i,Color.new(0,0,0))
  if i > firstVerticeY then
   break
  end
  screen:pixel(cursor.x(),i+1,Color.new(255,255,255))
   end
  end
  --//   droite -> Gauche| bas -> haut
  if (cursor.x() <= firstVerticeX) and (cursor.y() <= firstVerticeY) then
   for i=cursor.x(),firstVerticeX,2 do
  screen:pixel(i,firstVerticeY,Color.new(0,0,0))
  if i > firstVerticeX then
    break
  end
  screen:pixel(i+1,firstVerticeY,Color.new(255,255,255))
   end
   for i=cursor.x(),firstVerticeX,2 do
  screen:pixel(i,cursor.y(),Color.new(0,0,0))
  if i > firstVerticeX then
   break
  end
  screen:pixel(i+1,cursor.y(),Color.new(255,255,255))
   end
   for i=cursor.y(),firstVerticeY,2 do
  screen:pixel(firstVerticeX,i,Color.new(0,0,0))
  if i > firstVerticeY then
   break
  end
  screen:pixel(firstVerticeX,i+1,Color.new(255,255,255))
   end
   for i=cursor.y(),firstVerticeY,2 do
  screen:pixel(cursor.x(),i,Color.new(0,0,0))
  if i > firstVerticeY then
   break
  end
  screen:pixel(cursor.x(),i+1,Color.new(255,255,255))
   end
  end
  --// droite ->  Gauche  |  haut -> bas
  if (cursor.x() <= firstVerticeX) and (cursor.y() >= firstVerticeY) then
   for i=cursor.x(),firstVerticeX,2 do
  screen:pixel(i,firstVerticeY,Color.new(0,0,0))
  if i > firstVerticeX then
   break
  end
  screen:pixel(i+1,firstVerticeY,Color.new(255,255,255))
   end
   for i=cursor.x(),firstVerticeX,2 do
  screen:pixel(i,cursor.y(),Color.new(0,0,0))
  if i > firstVerticeX then
   break
  end
  screen:pixel(i+1,cursor.y(),Color.new(255,255,255))
   end
   for i=firstVerticeY,cursor.y(),2 do
  screen:pixel(firstVerticeX,i,Color.new(0,0,0))
  if i > cursor.y() then
   break
  end
  screen:pixel(firstVerticeX,i+1,Color.new(255,255,255))
   end
   for i=firstVerticeY,cursor.y(),2 do
  screen:pixel(cursor.x(),i,Color.new(0,0,0))
  if i > cursor.y() then
   break
  end
  screen:pixel(cursor.x(),i+1,Color.new(255,255,255))
   end
  end
  --// Fin d'affichage de la selection
 end
 
  -- // Affichage du menu de filtre /effet
 if filtreActive then
  screen:blit(110,40,filtreBox)
  if filtreSelected == "none" then
   for i =1,5 do  
    if i == tempselect then
     screen:print(120,60+(i*10),filtre[i],Color.new(0,0,180))
    else
     screen:print(120,60+(i*10),filtre[i],Color.new(0,0,0))
    end
   end
  elseif filtreSelected == "Transparence" then 
   for i =1,2 do   
    if i == tempselect then
     screen:print(120,60+(i*10),filtre1[i],Color.new(0,0,180))
    else
     screen:print(120,60+(i*10),filtre1[i],Color.new(0,0,0))
    end
   end
  elseif filtreSelected == "Manipulation" then
   for i =1,3 do 
    if i == tempselect then
     screen:print(120,60+(i*10),filtre2[i],Color.new(0,0,180))
    else
     screen:print(120,60+(i*10),filtre2[i],Color.new(0,0,0))
    end
   end
  elseif filtreSelected == "Brush" then
   for i =1,3 do  
    if i == tempselect then
     screen:print(120,60+(i*10),filtre3[i],Color.new(0,0,180))
    else
     screen:print(120,60+(i*10),filtre3[i],Color.new(0,0,0))
    end
    
   end 
  elseif filtreSelected == "Effet" then
   for i =1,3 do  
    if i == tempselect then
     screen:print(120,60+(i*10),filtre4[i],Color.new(0,0,180))
    else
     screen:print(120,60+(i*10),filtre4[i],Color.new(0,0,0))
    end
   end
  elseif filtreSelected == "Texte" then
   for i =1,2 do  
    if i == tempselect then
     screen:print(120,60+(i*10),filtre5[i],Color.new(0,0,180))
    else
     screen:print(120,60+(i*10),filtre5[i],Color.new(0,0,0))
    end
   end
  end
 end

 cursor.play() -- Impression de la souris
 screen.waitVblankStart()
 screen.flip() -- Rafraichissement de l'ecran
end
--#==================================================
-- Fin de la fonction de rafraichissement de l'ecran
--#==================================================
playI()


--#==================================================
-- Boucle principale 
--#==================================================
pad = Controls.read()
while true do
 pad = Controls.read()

 if pad:r() then
  System.sleep(150)
  if box.active == "tool" then
   box.active = "file"
   playI()
  elseif box.active == "file" then
   box.active = "tool"
   playI()
  end
 end

 if pad:analogX() > 90 then
  if pad:l() then
   if pad:cross() and copyPhase then
    if document.zoomN() == 0 then
     copyPhaseX = copyPhaseX + 5
     cursor.move(1,10)
    else
     copyPhaseX = copyPhaseX + (2*document.zoomN())
     cursor.move(1,(2*document.zoomN()))
    end
    playI()
   else
    cursor.move(1,10)
    playI()
   end
  else
   if pad:cross() and copyPhase then
    if document.zoomN() == 0 then
   copyPhaseX = copyPhaseX + 1
   cursor.move(1,1)
  else
   copyPhaseX = copyPhaseX + document.zoomN()
   cursor.move(1,document.zoomN())
    end
  playI()
   else
    cursor.move(1,1)
    playI()
   end
  end
 end


 if pad:analogY() < 0-90 then
  if pad:l() then
   if pad:cross() and copyPhase then
    if document.zoomN() == 0 then
     copyPhaseY = copyPhaseY - 5
   cursor.move(2,10)
  else
   copyPhaseY = copyPhaseY - (2*document.zoomN())
   cursor.move(2,(2*document.zoomN()))
  end
  playI()
   else
  cursor.move(2,10)
  playI()
   end
  else
   if pad:cross() and copyPhase then
  if document.zoomN() == 0 then
   copyPhaseY = copyPhaseY - 1
   cursor.move(2,1)
  else
    copyPhaseY = copyPhaseY - document.zoomN()
   cursor.move(2,document.zoomN())
  end
  playI()
   else
    cursor.move(2,1)  
  playI()
   end
  end
 end

 if pad:analogX() < 0-90 then
  if pad:l() then
   if pad:cross() and copyPhase then
  if document.zoomN() == 0 then 
   copyPhaseX = copyPhaseX - 5
   cursor.move(3,10)
  else
   copyPhaseX = copyPhaseX - (2*document.zoomN())
   cursor.move(3,(2*document.zoomN()))
  end
  playI()
   else
  cursor.move(3,10)
  playI()
   end
  else
   if pad:cross() and copyPhase then
  if document.zoomN() == 0 then 
   copyPhaseX = copyPhaseX - 1
   cursor.move(3,1)
  else
   copyPhaseX = copyPhaseX - document.zoomN()
   cursor.move(3,1)
  end
  playI()
   else
  cursor.move(3,1)
  playI()
   end
  end
 end

 if pad:analogY() > 90 then
  if pad:l() then
   if pad:cross() and copyPhase then
    if document.zoomN() == 0 then 
   copyPhaseY = copyPhaseY + 5
   cursor.move(4,10)
  else 
   copyPhaseY = copyPhaseY + (2*document.zoomN())
   cursor.move(4,(2*document.zoomN()))
  end
  playI()
   else
  cursor.move(4,10)
  playI()
   end
  else
   if pad:cross() and copyPhase then
  if document.zoomN() == 0 then 
   copyPhaseY = copyPhaseY + 1
   cursor.move(4,1)
  else
   copyPhaseY = copyPhaseY + document.zoomN()
   cursor.move(4,document.zoomN())
  end
  playI()
   else
  cursor.move(4,1)
  playI()
   end
  end
 end


 --//==========================================
 --// Gestion du menu filtre (fleche)


 if pad:up() and filtreActive and tempselect > 1 then
   System.sleep(200)
   tempselect = tempselect - 1
   playI()
 end

 if pad:down() and filtreActive then
 System.sleep(200)
  if filtreSelected == "none" and tempselect < 5 then
   tempselect = tempselect + 1
  elseif filtreSelected == "Transparence" and tempselect == 1 then
   tempselect = tempselect + 1
  elseif filtreSelected == "Manipulation" and tempselect < 3 then
   tempselect = tempselect + 1
  elseif filtreSelected == "Brush" and tempselect < 3 then
   tempselect = tempselect + 1
  elseif filtreSelected == "Effet" and tempselect < 3 then
   tempselect = tempselect + 1
  elseif filtreSelected == "Texte" and tempselect < 2 then
   tempselect = tempselect + 1
  end
  playI()
 end
 --//==========================================
 --// Gestion du scroll (fleche)
 if pad:left() and documentOpen  and (document.scrollX()>0) and not(filtreActive) then
  if pad:l() and (document.scrollX()>5) then
   document.scrollLeft(5)
  else
   document.scrollLeft(1)
  end
  playI()
 end

 if pad:right() and documentOpen  and (document.scrollX() < document.scrollXmax()) then
  if pad:l() and ((document.scrollX()+5)<document.scrollXmax()) then
   document.scrollRight(5)
  else
   document.scrollRight(1)
  end
  playI()
 end
 
 if pad:up() and documentOpen and (document.scrollY()>0) and not(filtreActive) then
  if pad:l() and (document.scrollY()>5) then
   document.scrollUp(5)
  else
   document.scrollUp(1)
  end
  playI()
 end

 if pad:down() and documentOpen and (document.scrollY() < document.scrollYmax()) and not(filtreActive) then
  if pad:l() and ((document.scrollY()+5)<document.scrollYmax()) then
   document.scrollDown(5)
  else
   document.scrollDown(1)
  end
  playI()
 end

 --//==========================================
 --// Gestion du click principal (croix)

 if pad:cross() and not(filtreActive) then
  --// Si on est sur la pallette
  if onPalette() then
   param.primaryCO = palette:pixel(cursor.x()-9,cursor.y()-10)
   if brushActive then
    reloadBrush() 
    playI()
   end
   paletteRefresh()
   playI()
  --// Si on est sur la boite a outils
  elseif onToolsbox() then
   if brushActive then
   brushActive = false
   cursor.picE("02")
   end
   if checkToolsOptionOver() == "Selectionner une zone " then
  cursor.statutE("select")
  firstVerticeSelected = false
  playI()
   elseif checkToolsOptionOver() == "Prelever une couleur" then
  cursor.statutE("fiole")
  playI()
   elseif checkToolsOptionOver() == "Pinceau" then
  cursor.statutE("normal")
  playI()
   elseif checkToolsOptionOver() == "Remplissage" then
  cursor.statutE("pot")
  playI()
   elseif checkToolsOptionOver() == "Supprimer l'image" then
  if documentOpen then
   pic = document.img() 
   pic:clear(param.secondaryCO)
   playI()
  end
   elseif checkToolsOptionOver() == "Inserer du texte" then
  if documentOpen and document.zoomN() == 0 then   
    temp = document.img()
    cursor.statutE("none")
    texte = ''
    Keyboard.init()
    tempCopy = Image.createEmpty(string.len(texte)*8,15)
    tempSelect = Image.createEmpty(string.len(texte)*8,15)
    for i=0,tempSelect:width()-1 do
     if math.mod(i,2) == 0 then
      tempSelect:pixel(i,0,Color.new(0,0,0))
     else
      tempSelect:pixel(i,0,Color.new(255,255,255))
     end
    end
    for i=0,tempSelect:width()-1 do
     if math.mod(i,2) == 0 then
      tempSelect:pixel(i,tempSelect:height()-1,Color.new(0,0,0))
     else
      tempSelect:pixel(i,tempSelect:height()-1,Color.new(255,255,255))
     end
    end
    for i=0,tempSelect:height()-1 do
     if math.mod(i,2) == 0 then
      tempSelect:pixel(0,i,Color.new(0,0,0))
     else
      tempSelect:pixel(0,i,Color.new(255,255,255))
     end
    end
    for i=0,tempSelect:height()-1 do
     if math.mod(i,2) == 0 then
      tempSelect:pixel(tempSelect:width()-1,i,Color.new(0,0,0))
     else
      tempSelect:pixel(tempSelect:width()-1,i,Color.new(255,255,255))
     end
    end
    if fontSelected == "classic" then
    tempCopy:print(0,0,texte,param.primaryCO)
    else
    end
    selectionActive = false
    firstVerticeSelected = false
    endCopy = false
    copyPhase = true
    copyPhaseX = 100
    copyPhaseY = 21
    playI()
   end
   elseif checkToolsOptionOver() ==  "Zoom" then
    if pad:l() and documentOpen then
      document.zoom("out",2)
      playI() 
    else
     if selectionActive and not(selectionZoom) then
      selectionActive = false
      selectionZoom = true
      tempDoc = document
      tempPic = document.img() 
      tempX = (selectionFirstX-100) + document.scrollX()
      tempY = (selectionFirstY-21) + document.scrollY()
      param.width = (selectionSecondX + document.scrollX())-(selectionFirstX + document.scrollX())
      param.height = (selectionSecondY + document.scrollY())-(selectionFirstY + document.scrollY())
      document = File.new()
      tempNewPic = Image.createEmpty(document.img():width(),document.img():height())      
      tempNewPic:blit(0,0,tempPic,tempX,tempY,param.width,param.height)
      document.imgE(tempNewPic)
      tempNewPic = nil
      collectgarbage()
      document.zoom("in",2)
      playI()
     else
      document.zoom("in",2)
      playI()
     end
    end
   elseif checkToolsOptionOver() ==  "Tracer une ligne" then
    cursor.statutE("line")
    firstVerticeSelected = false
    playI()
   elseif checkToolsOptionOver() ==  "Coller selection" then
    System.sleep(200)
    if pad:l() then
    copyActive = false
    tempCopy = nil
    collectgarbage()
   else
    selectionActive = false
    firstVerticeSelected = false
    endCopy = false
    copyPhase = true
    copyPhaseX = 100
    copyPhaseY = 21
   playI()
    end
  playI()
   elseif checkToolsOptionOver() ==  "Copier selection" then
    System.sleep(200)
  copyActive = true
  copyFirstX = (selectionFirstX + 1) + document.scrollX()
  copyFirstY = (selectionFirstY + 1) + document.scrollY()
  copySecondX = (selectionSecondX - 1) + document.scrollX()
  copySecondY = (selectionSecondY - 1) + document.scrollY()
  tempCopy = Image.createEmpty(copySecondX-copyFirstX,copySecondY-copyFirstY)
  tempSelect = Image.createEmpty(copySecondX-copyFirstX,copySecondY-copyFirstY)
  for i=0,tempSelect:width()-1 do
   if math.mod(i,2) == 0 then
    tempSelect:pixel(i,0,Color.new(0,0,0))
   else
    tempSelect:pixel(i,0,Color.new(255,255,255))
   end
  end
  for i=0,tempSelect:width()-1 do
   if math.mod(i,2) == 0 then
    tempSelect:pixel(i,tempSelect:height()-1,Color.new(0,0,0))
   else
    tempSelect:pixel(i,tempSelect:height()-1,Color.new(255,255,255))
   end
  end
  for i=0,tempSelect:height()-1 do
   if math.mod(i,2) == 0 then
    tempSelect:pixel(0,i,Color.new(0,0,0))
   else
    tempSelect:pixel(0,i,Color.new(255,255,255))
   end
  end
  for i=0,tempSelect:height()-1 do
   if math.mod(i,2) == 0 then
    tempSelect:pixel(tempSelect:width()-1,i,Color.new(0,0,0))
   else
    tempSelect:pixel(tempSelect:width()-1,i,Color.new(255,255,255))
   end
  end
  tempP = document.img()
  tempCopy:blit(0,0,tempP,copyFirstX-100,copyFirstY-21,tempCopy:width(),tempCopy:height())
  tempP = nil
  collectgarbage()
  playI()
   end
   --// Si on est sur la boite de gestion des fichiers
   elseif onFilebox() then
   if brushActive then
   brushActive = false
   cursor.picE("02")
   end
  if checkFileOptionOver() == "Nouveau fichier ..." then
   selectionZoom = false
   w = askN("Largeur")
   playI()
   if w ~= false then
    h = askN("Hauteur")
     playI()
    if h ~= false then
     param.width = w
     param.height = h
     w = nil
     h = nil
     document = File.new()
     documentOpen = true
     playI()
     System.sleep(100)
    end
   end 
    elseif checkFileOptionOver() == "Ouvrir fichier ..." then
    selectionZoom = false
    tempAction = "open"
    dofile("System/script/explorer.lua")
    if fileName ~= nil then
     document = File.open(fileName)
	 if not(document == "notLoaded") then
      documentOpen = true
      documentSave = true
	 end
     playI()
    end
  elseif checkFileOptionOver() == "Enregistrer image ..." then
   if documentOpen then
    selectionZoom = false 
    playI()
    tempAction = "save"
    texte = ''
    dofile("System/script/explorer.lua")
    if confirmS  then
     while true do
    if document.zoomN() ~= 0 then
     document.zoom("out",2)
    else
     break
    end
     end
     document.save()
      end
   end
   playI()
  elseif checkFileOptionOver() == "Configuration " then
   alert('Configuration','Non disponible',true)  
   playI()
  elseif checkFileOptionOver() == "Installer une MAJ " then
   dofile('System/librairie/update.lua')
   playI()
  elseif checkFileOptionOver() == "Telechargement" then
   playI()
  elseif checkFileOptionOver() == "Quitter DAPES" then
   confirm("Quitter DAPES","Voulez-vous quittez DAPES ?")
   playI()
  end
  --// Si on est sur l'image
  elseif onPicture() then
   if cursor.statut() == "normal" then
    if documentOpen then
     pic = document.img() 
     if brushActive and not(selectionZoom) then
      if document.zoomN() == 0 then
       pic:blit((cursor.x()-100)+document.scrollX(),(cursor.y()-21)+document.scrollY(),brushPic)
      else
       tempBrushDoc = Picture.new(brushPic:width(),brushPic:height(),"","","",true)
       tempBrush = tempBrushDoc.img()
       tempBrush:blit(0,0,brushPic)
       tempBrushDoc.imgE(tempBrush)
       tempBrushDoc.zoom("in",document.zoomN())
       tempBrush = tempBrushDoc.img()
       pic:blit(((cursor.x()-100)+document.scrollX())-(math.mod((cursor.x()-100)+document.scrollX(),document.zoomN())),((cursor.y()-21)+document.scrollY())-(math.mod((cursor.y()-21)+document.scrollY(),document.zoomN())),tempBrush)
       tempBrush = nil 
       tempBrushDoc = nil
       collectgarbage()
      end
     else
      if document.zoomN() == 0 then
       pic:pixel((cursor.x()-100)+document.scrollX(),(cursor.y()-21)+document.scrollY(),param.primaryCO)
      else
       -- // Si l'image a subi un zoom
       pic:fillRect(((cursor.x()-100)+document.scrollX())-(math.mod((cursor.x()-100)+document.scrollX(),document.zoomN())),((cursor.y()-21)+document.scrollY())-(math.mod((cursor.y()-21)+document.scrollY(),document.zoomN())),document.zoomN(),document.zoomN(),param.primaryCO)
       --// Renvoi des donnees + rafraichisemment 
      end
     end
     document.imgE(pic)
    end
   elseif cursor.statut() == "line" then
    if firstVerticeSelected then
     temp = document.img()
     if document.zoomN() == 0 then
    temp:drawLine((firstVerticeX-100)+document.scrollX(),(firstVerticeY-21)+document.scrollY(),(cursor.x()-100)+document.scrollX(),(cursor.y()-21)+document.scrollY(),param.primaryCO)
    document.imgE(temp)
     else
    for i=0,document.zoomN()-1 do
     temp:drawLine((((firstVerticeX-100)+document.scrollX())-(math.mod((firstVerticeX-100)+document.scrollX(),document.zoomN())))+i,(((firstVerticeY-21)+document.scrollY())-(math.mod((firstVerticeY-21)+document.scrollY(),document.zoomN())))+i,(((cursor.x()-100)+document.scrollX())-(math.mod((cursor.x()-100)+document.scrollX(),document.zoomN())))+i,(((cursor.y()-21)+document.scrollY())-(math.mod((cursor.y()-21)+document.scrollY(),document.zoomN())))+i,param.primaryCO)
     temp:drawLine((((firstVerticeX-100)+document.scrollX())-(math.mod((firstVerticeX-100)+document.scrollX(),document.zoomN())))+i,(((firstVerticeY-21)+document.scrollY())-(math.mod((firstVerticeY-21)+document.scrollY(),document.zoomN()))),(((cursor.x()-100)+document.scrollX())-(math.mod((cursor.x()-100)+document.scrollX(),document.zoomN())))+i,(((cursor.y()-21)+document.scrollY())-(math.mod((cursor.y()-21)+document.scrollY(),document.zoomN()))),param.primaryCO)
     temp:drawLine((((firstVerticeX-100)+document.scrollX())-(math.mod((firstVerticeX-100)+document.scrollX(),document.zoomN()))),(((firstVerticeY-21)+document.scrollY())-(math.mod((firstVerticeY-21)+document.scrollY(),document.zoomN())))+i,(((cursor.x()-100)+document.scrollX())-(math.mod((cursor.x()-100)+document.scrollX(),document.zoomN()))),(((cursor.y()-21)+document.scrollY())-(math.mod((cursor.y()-21)+document.scrollY(),document.zoomN())))+i,param.primaryCO)
    end
     end
     temp = nil
     collectgarbage()
     firstVerticeSelected = false
    else
     firstVerticeSelected = true
     firstVerticeX = cursor.x()
     firstVerticeY = cursor.y()
    end
    System.sleep(200)
    playI()
   elseif cursor.statut() == "fiole" then
    temp = document.img()
    param.primaryCO = temp:pixel((cursor.x()-100)+document.scrollX(),(cursor.y()-21)+document.scrollY())
    paletteRefresh()
    temp = nil 
    collectgarbage()
    playI()
   elseif cursor.statut() == "pot" then
    tempF = document.img()
    alert("Pot de peinture","Remplissage en cours",false)
	_first = true
	_x = cursor.x()-100
	_y = cursor.y()-21
	_color = param.primaryCO
	fillProcess = coroutine.create(fill)
	statut , erreur = coroutine.resume(fillProcess)
    tempF = nil
    collectgarbage()
    playI()
   elseif cursor.statut() == "select" and not(copyPhase) then
      System.sleep(200)
    -- Selection part
    if selectionActive then
     selectionActive = false
     firstVerticeSelected = true
     firstVerticeX = cursor.x()
     firstVerticeY = cursor.y()
    else
     if firstVerticeSelected then
        -- // Sauvegarde des sommet de la selection par ordre croissant
      -- // Seulement si la selection depace les 1 pixel de hauteur / largeur 
      if (firstVerticeX ~= cursor.x()) and (firstVerticeY ~= cursor.y()) then
     if firstVerticeX < cursor.x() then
      selectionFirstX = firstVerticeX
      selectionSecondX = cursor.x()
     elseif firstVerticeX > cursor.x() then
      selectionFirstX = cursor.x()
      selectionSecondX = firstVerticeX
       end
     if firstVerticeY < cursor.y() then
      selectionFirstY= firstVerticeY
      selectionSecondY = cursor.y()
     elseif firstVerticeY > cursor.y() then
      selectionFirstY = cursor.y()
      selectionSecondY = firstVerticeY
     end
     firstVerticeSelected = false
     selectionActive = true
     tempSelect = Image.createEmpty(selectionSecondX-selectionFirstX,selectionSecondY-selectionFirstY)
     for i=0,tempSelect:width()-1 do
      if math.mod(i,2) == 0 then
       tempSelect:pixel(i,0,Color.new(0,0,0))
      else
       tempSelect:pixel(i,0,Color.new(255,255,255))
      end
     end
    for i=0,tempSelect:width()-1 do
     if math.mod(i,2) == 0 then
      tempSelect:pixel(i,tempSelect:height()-1,Color.new(0,0,0))
     else
      tempSelect:pixel(i,tempSelect:height()-1,Color.new(255,255,255))
     end
      end
    for i=0,tempSelect:height()-1 do
     if math.mod(i,2) == 0 then
      tempSelect:pixel(0,i,Color.new(0,0,0))
     else
      tempSelect:pixel(0,i,Color.new(255,255,255))
     end
      end
      for i=0,tempSelect:height()-1 do
     if math.mod(i,2) == 0 then
      tempSelect:pixel(tempSelect:width()-1,i,Color.new(0,0,0))
     else
      tempSelect:pixel(tempSelect:width()-1,i,Color.new(255,255,255))
     end
    end
     end
    else
     firstVerticeSelected = true
     firstVerticeX = cursor.x()
     firstVerticeY = cursor.y()
    end
   end
   playI()
   --// Fin de selection
   end
  end
 end
 

--//==========================================
--// Gestion du bouton triangle (Activer / Desactiver menu de selection filtre)
if pad:triangle() then
System.sleep(200)
if filtreActive == true then
filtreActive = false
else
filtreActive = true
filtreSelected = "none"
tempselect = 1
end
playI()
end

if pad:square() and not(pad:l()) then
if copyPhase then
tempP = document.img()
tempP:blit((copyPhaseX-100)+document.scrollX(),copyPhaseY-21+document.scrollY(),tempCopy)
document.imgE(tempP)
tempP = nil
copyPhase = false
textInput = false
copyActive = false
selectionActive = false
collectgarbage()
System.sleep(200)
cursor.statutE("normal")
elseif brushActive then
brushActive = false
cursor.picE("02")
elseif selectionActive then
selectionActive = false
end
playI()
end


if pad:square() and pad:l() then
if selectionActive then
tempPic = document.img()
tempPic:fillRect((selectionFirstX-100)+document.scrollX(),(selectionFirstY-21)+document.scrollY(),tempSelect:width(),tempSelect:height(),param.primaryCO)  
document.imgE(tempPic)
tempPic = nil 
collectgarbage()
playI()
end
end

if pad:start() and selectionZoom then
while not(document.zoomN() == 0) do
playI()
document.zoom("out",2)
end      
playI()
tempSelectionPic = document.img()
document = tempDoc
tempPic = document.img()
tempPic:blit(tempX,tempY,tempSelectionPic)
document.imgE(tempPic)      
tempPic = nil
tempDoc = nil
tempSelectionPic = nil
tempX = nil
tempY = nil
selectionZoom = false
collectgarbage()
playI()
end

if pad:cross() and filtreActive then
 System.sleep(200)
 if filtreSelected == "none" then
  if tempselect == 1 then
   filtreSelected = "Transparence"
  elseif tempselect == 2 then
   filtreSelected = "Manipulation"
  elseif tempselect == 3 then
   filtreSelected = "Brush"
  elseif tempselect == 4 then
   filtreSelected = "Effet"
  elseif tempselect == 5 then
   filtreSelected = "Texte"
  end
 elseif filtreSelected == "Transparence" then
  filtreActive = false
  playI()
  if tempselect == 1 then
   --// Procedure pour definir une coleur de transparence
   if confirm("Transparence","Definir comme couleur de transparence ?") then
    playI()
    alert("Couleur de transparence","Traitement en cours",false)
    tempP = document.img()
    tempNewP = Image.createEmpty(tempP:width(),tempP:height())  
    for i=0,tempP:width()-1 do
     for j=0,tempP:height()-1 do
      if tempP:pixel(i,j) == param.primaryCO then
      else
       tempNewP:pixel(i,j,tempP:pixel(i,j))
      end
     end
    end
   end
   document.imgE(tempNewP)
   tempNewP = nil
   tempP = nil
   collectgarbage()
   playI()
  elseif tempselect == 2 then
   playI()
   alphaColor = askN("Canal alpha") 
   playI()
   r = askN("Rouge")
   playI() 
   v = askN("Vert")
   playI() 
   b = askN("Bleu")
   param.primaryCO = Color.new(r,v,b,alphaColor) 
   paletteRefresh()
   playI()
  end 
 elseif filtreSelected == "Brush" then
  filtreActive = false
  playI()
  cursor.statutE("normal")
  brushActive = true
  if tempselect == 1 then
   brushSelected = 1
  end
  if tempselect == 2 then
   brushSelected = 2
  end
  if tempselect == 3 then
   brushSelected = 3
  end
  reloadBrush()
  playI()
 elseif filtreSelected == "Manipulation" then
  filtreActive = false
  playI()
  if tempselect == 1 then
  --// Symetrie vertical
   if copyPhase then
    playI()
    alert("Symetrie verticale","Traitement en cours",false)
    tempNewPic = Image.createEmpty(tempCopy:width(),tempCopy:height())
    for i=0,tempCopy:width()-1 do
     for j=0,tempCopy:height()-1 do
      tempNewPic:pixel(i,(tempCopy:height()-1)-j,tempCopy:pixel(i,j))
     end
    end
    tempCopy = tempNewPic
    tempNewPic = nil
    collectgarbage()
   else
    playI()
    alert("Symetrie verticale","Traitement en cours",false)
    tempPic = document.img()
    tempNewPic = Image.createEmpty(tempPic:width(),tempPic:height())
    for i=0,tempPic:width()-1 do
     for j=0,tempPic:height()-1 do
      tempNewPic:pixel(i,(tempPic:height()-1)-j,tempPic:pixel(i,j))
     end
    end
    document.imgE(tempNewPic)
    tempNewPic = nil
    tempPic = nil
    collectgarbage() 
   end
  elseif tempselect == 2 then
    --// Symetrie horizontal
   if copyPhase then
    playI()
    alert("Symetrie horizontale","Traitement en cours",false)
    tempNewPic = Image.createEmpty(tempCopy:width(),tempCopy:height())
    for i=0,tempCopy:width()-1 do
     for j=0,tempCopy:height()-1 do
      tempNewPic:pixel((tempCopy:width()-1)-i,j,tempCopy:pixel(i,j))
     end
    end
    tempCopy = tempNewPic
    tempNewPic = nil 
    collectgarbage()
   else
    playI()
    alert("Symetrie horizontale","Traitement en cours",false)
    tempPic = document.img()
    tempNewPic = Image.createEmpty(tempPic:width(),tempPic:height())
    for i=0,tempPic:width()-1 do
     for j=0,tempPic:height()-1 do
      tempNewPic:pixel((tempPic:width()-1)-i,j,tempPic:pixel(i,j))
     end
    end
    document.imgE(tempNewPic)
    tempNewPic = nil
    tempPic = nil
    collectgarbage() 
   end  
  elseif tempselect == 3 then
   --// Rotation
   if selectionActive then
   end
  end
 elseif filtreSelected == "Effet" then
  filtreActive = false
  playI()
  if tempselect == 1 then
   tempPic = document.img()
   playI()
   l = askN("Largeur des carreaux :")
   playI()
   h = askN("Hauteur des carreaux :")
   playI()
   alert("Quadrillage","Traitement en cours",false)
   for i = 0,tempPic:width() do
    if math.mod(i,l) == 0 then
     tempPic:drawLine(i,0,i,tempPic:height()-1,param.primaryCO)
    end
   end
   for i = 0,tempPic:height() do
    if math.mod(i,h) == 0 then
     tempPic:drawLine(0,i,tempPic:width()-1,i,param.primaryCO)
    end
   end    
  elseif tempselect == 2 then
   --// Maillage
  elseif tempselect == 3 then
  --//Degrade
  end
 elseif filtreSelected == "Texte" then
  filtreActive = false
  playI()
  if tempselect == 1 then
  --// font
  elseif tempselect == 2 then
  --// taille
  end
 end
 tempselect = 1
 playI()
end


--//==========================================
--// Gestion du bouton select
if pad:select() and not(pad:l()) then
System.sleep(200)
if box.active == "none" then
box.active = lastBox
else 
lastBox = box.active
box.active = "none"
end
playI()
end


--//==========================================
--// Gestion du click secondaire (rond)
if pad:circle() then

if onPalette() then
param.secondaryCO = palette:pixel(cursor.x()-9,cursor.y()-10)
paletteRefresh()
playI()


elseif onPicture() then
if cursor.statut() == "normal" then
if documentOpen  then
pic = document.img()
if document.zoomN() == 0 then
pic:pixel((cursor.x()-100)+document.scrollX(),(cursor.y()-21)+document.scrollY(),param.secondaryCO)
else
-- // Si l'image a subi un zoom
pic:fillRect(((cursor.x()-100)+document.scrollX())-(math.mod((cursor.x()-100)+document.scrollX(),document.zoomN())),((cursor.y()-21)+document.scrollY())-(math.mod((cursor.y()-21)+document.scrollY(),document.zoomN())),document.zoomN(),document.zoomN(),param.secondaryCO)
--// Renvoi des données + rafraichisemment 
end
document.imgE(pic)
end
elseif cursor.statut() == "fiole" then
temp = document.img()
param.secondaryCO = temp:pixel((cursor.x()-100)+document.scrollX(),(cursor.y()-21)+document.scrollY())
paletteRefresh()
playI()
temp=nil
elseif cursor.statut() == "select" then
elseif cursor.statut() == "pot" then
tempF = document.img()
alert("Pot de peinture","Remplissage en cours",false)
playI()
fill(cursor.x()-100,cursor.y()-21,param.secondaryCO,true)
tempF = nil
collectgarbage()
playI()
end
end

end

if pad:select() and pad:l() then
screen:save("scr"..compteur..".png")
compteur = compteur + 1
end

if onFilebox() then
if oldFileOver == "none" then
fileOver = checkFileOptionOver()
oldFileOver = checkFileOptionOver()
if fileOver ~= false then
playI()
end
else
fileOver = checkFileOptionOver()
if fileOver ~= oldFileOver then
oldFileOver = fileOver
if fileOver ~= false then
playI()
end
end
end
end

if onToolsbox() then
if oldToolsOver == "none" then
toolsOver = checkToolsOptionOver()
oldToolsOver = checkToolsOptionOver()
if toolsOver ~= false then
playI()
end
else
toolsOver = checkToolsOptionOver()
if toolsOver ~= oldToolsOver then
oldToolsOver = toolsOver
if toolsOver ~= false then
playI()
end
end
end
end

end