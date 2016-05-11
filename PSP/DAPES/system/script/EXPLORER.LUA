--# Script de navigation MS 
compteur = 1
--  Fenetre d'affichage du contenu de la MS
msBox = Image.createEmpty(440,230)
msBox:clear(Color.new(0,0,0,150))
-- // Contour de la fenetre
msBox:drawLine(0,0,440,0,Color.new(0,0,0))
msBox:drawLine(0,229,440,229,Color.new(0,0,0))
msBox:drawLine(0,0,0,230,Color.new(0,0,0))
msBox:drawLine(440,0,440,230,Color.new(0,0,0))
-- // Interieur de la fenetre
msBox:fillRect(3,20,434,207,Color.new(0,0,0))
msBox:fillRect(4,21,432,206,Color.new(240,240,240))
--// Decoration 
msBox:fillRect(10,25,230,177,Color.new(0,0,0))
msBox:fillRect(11,26,228,175,Color.new(255,255,255))

path = "ms0:/" 
pathRoute = {}
pathRoute[1] = path
pathSelector = 1
fileList = System.listDirectory(path)  
count = 0
selector = 3

function refresh()
                 fileList = System.listDirectory(path)
				  for i=1,table.getn(fileList) do
				   if not(fileList[i].directory) then 
				    extTemp = string.sub(fileList[i].name,-4)
				    if extTemp == ".JPG" or extTemp == ".jpg" or extTemp == ".png" or extTemp == ".PNG" then
                     fileList[i].ext = 1 					
					elseif extTemp == ".mp3" or extTemp == ".MP3" or extTemp == ".ogg" or extTemp == ".OGG" then 
					 fileList[i].ext = 2
					elseif extTemp == ".LUA" or extTemp == ".lua" or extTemp == ".txt" or extTemp == ".TXT" then
					 fileList[i].ext = 3
					else
					 fileList[i].ext = 5
					end		   
				   else	
				   fileList[i].ext = 4 
				   end
				  end
                 end 
function upDir()
                pathSelector = pathSelector + 1
				pathRoute[pathSelector] = path..fileList[selector].name.."/"
				path = pathRoute[pathSelector]
				selector = 3
				refresh()
               end
function downDir()
                  pathSelector = pathSelector - 1
			  	  path = pathRoute[pathSelector]
				  refresh()
                 end
function reload()
 -- Suppression de l'ecran
 screen:clear()
 --Impression du fond
 screen:blit(0,0,background)
 screen:blit(20,20,msBox)
 if tempAction == "save" then
  screen:print(25,30,'Enregistrer ...',Color.new(255,255,255))
  screen:print(270,70,'Croix : Ecraser fichier',Color.new(0,0,0))
  screen:print(270,80,'Triangle : Enregister ',Color.new(0,0,0))
  screen:print(270,90,'Select: clavier virtuel',Color.new(0,0,0))
 elseif tempAction == "open" then
  screen:print(25,30,'Ouvrir ...',Color.new(255,255,255))
  screen:print(270,70,'Croix : Ouvrir fichier',Color.new(0,0,0))
 end
 screen:print(270,50,'Rond : Annuler',Color.new(0,0,0))
 screen:print(270,60,'L : dossier parent',Color.new(0,0,0))
 -- Boucle d'impression du repertoire 
 j = 1
 if table.getn(fileList) == 2 then
  screen:print(75,80,"Le dossier est vide",Color.new(0,0,0))
 elseif table.getn(fileList) > 2 and table.getn(fileList) < 5 then
  for i=3,table.getn(fileList) do
   if i == selector then
   	screen:print(75,40+(j*25),fileList[i].name,Color.new(150,150,150))
   else
    screen:print(75,40+(j*25),fileList[i].name,Color.new(0,0,0))
   end
   screen:blit(40,40+(j*22),icon[fileList[i].ext])
   j = j + 1
  end
 else
  if selector < table.getn(fileList) - 5 then
   for i = selector ,selector + 5  do
     if i == selector then
   	  screen:print(75,40+(j*25),fileList[i].name,Color.new(150,150,150))
     else
 	  screen:print(75,40+(j*25),fileList[i].name,Color.new(0,0,0))
     end
     screen:blit(40,40+(j*22),icon[fileList[i].ext])
     j = j + 1	
   end			 
  else
   for i = table.getn(fileList) - 5,table.getn(fileList) do
	 if i == selector then
 	  screen:print(75,40+(j*25),fileList[i].name,Color.new(150,150,150))
	 else
	  screen:print(75,40+(j*25),fileList[i].name,Color.new(0,0,0))
	 end
	 screen:blit(40,40+(j*22),icon[fileList[i].ext])
	 j = j + 1
    end	
  end
 end  
 --Rafraichissement de l'ecran
 screen.waitVblankStart()
 screen.flip()
end
 refresh()
 reload()
--Boucle principale

while true do
 pad = Controls.read()

 if pad:up() and (selector > 3) then
  System.sleep(100)
  selector = selector - 1
  reload()
 end

 if pad:down() and (selector < table.getn(fileList)) then
  System.sleep(100)
  selector = selector + 1
  reload()
 end

if pad:cross() then
 System.sleep(100)
 if fileList[selector].directory then
  upDir()
  refresh()
 else
  --# Detection de l'extension
  ext = string.sub(fileList[selector].name,string.len(fileList[selector].name)-3)
  -- Si l'extension est valide on ouvre le fichier 
  if (ext == ".png") or (ext == ".jpg") or (ext == ".PNG") or (ext == ".JPG") then
   if tempAction == "open" then
    fileName = path..fileList[selector].name
    break
   end
  else -- Sinon on envoi un message d'erreur 
   break
  end
 end
 reload()
end

if pad:select() and tempAction == 'save' then
 Keyboard.init()
 System.sleep(200)
 reload()
end

if pad:l() and not(path == "ms0:/")  then
 System.sleep(100)
 downDir()
 reload()
end

if pad:circle() then
 System.sleep(100)
 confirmS = false
 break
end




if pad:triangle() then
 System.sleep(200)
 if tempAction == "save" then
  fileName = tostring(texte)
  filePath = path
  confirmS = true
  break
  end
 reload()
end

end

msBox = nil
collectgarbage()
playI()