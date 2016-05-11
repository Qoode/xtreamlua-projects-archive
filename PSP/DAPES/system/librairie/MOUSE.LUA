
function onPicture()
if documentOpen == true then
local pic = document.img()
if cursor.x() < (100 + pic:width()) and cursor.x() > 99 then
if box.active == "none" or pic:height() < 220 then
if cursor.y() < 21 + pic:height() and cursor.y() > 20 then
return true
else
return false
end
elseif (box.active == "file" and pic:height() > 220) or (box.active == "tools" and pic:height() > 220) then
if cursor.y() < 220 and cursor.y() > 20 then
return true
else
return false
end
end
else
return false
end
end
end

--# Objet mouse
Mouse = {}

function Mouse.new()
local self = {
        x = 220,
        y = 150,
        statut = "normal",
        img = Image.createEmpty(35,35),
       }

self.img:blit(0,0,Image.load("Data/mouse/02.png"))

local getX = function ()
        return self.x
         end
local getY = function ()
        return self.y
         end
local statut = function()
        return self.statut
         end
local statutE = function(statut)
        self.statut = statut
         end
local play = function ()
        screen:blit(self.x,self.y,self.img)
       end

local move = function (side,speed)
        if side == 1 then
        if (self.x + speed) < 480 then
        self.x = self.x + speed
        end
        elseif side == 2 then
        if (self.y + speed) > 0 then
        self.y = self.y - speed
        end
        elseif side == 3 then
        if (self.x - speed) > 0 then
        self.x = self.x - speed
        end
        elseif side == 4 then
        if (self.y + speed) < 272 then
        self.y = self.y + speed
        end
        end
       end
       
local picE = function(s)
              if not(brushActive) then
               self.img = Image.createEmpty(35,35)
               self.img:blit(0,0,Image.load("system/data/mouse/"..s..".png"))
              elseif brushActive and not(onPicture()) then
               self.img = Image.createEmpty(35,35)
               self.img:blit(0,0,Image.load("system/data/mouse/"..s..".png"))
              else
               self.img = Image.createEmpty(35,35)
               self.img:blit(0,0,s)
              end 
       end
return {x = getX,
    y = getY,
    play = play,
    move = move,
    statut = statut,
    statutE = statutE,
    picE = picE,
     }
end

--# Fonction relative à la detection de la souris par rapport au element de l'interface
function onPalette()
if cursor.x() > 14 and cursor.x() < 76 then
if cursor.y() > 50 and cursor.y() < 111 then
return true
else
return false
end
else
return false
end
end

function onToolsbox()
if box.active == "tool" then
if cursor.x() > 90 and cursor.x() < 480 then
if cursor.y() > 220 and cursor.y() < 272 then
return true
else
return false
end
else
return false
end
else
return false
end
end

function onFilebox()
if box.active == "file" then
if cursor.x() > 180 and cursor.x() < 480 then
if cursor.y() > 220 and cursor.y() < 272 then
return true
else
return false
end
else
return false
end
else
return false
end
end


function checkFileOptionOver()
if cursor.y() < 272 and cursor.y() > 235 then
if cursor.x() < 235 and cursor.x() > 200 then
fileOption =  "Nouveau fichier ..."
elseif cursor.x() < 285 and cursor.x() > 240 then
fileOption = "Ouvrir fichier ..."
elseif cursor.x() < 315 and cursor.x() > 280 then
fileOption = "Enregistrer image ..."
elseif cursor.x() < 355 and cursor.x() > 320 then
fileOption = "Configuration "
elseif cursor.x() < 395 and cursor.x() > 360 then
fileOption = "Installer une MAJ "
elseif cursor.x() < 435 and cursor.x() > 400 then
fileOption = "Telechargement"
elseif cursor.x() < 480 and cursor.x() > 440 then
fileOption = "Quitter DAPES"
else 
fileOption = false
end
else
fileOption = false
end
return fileOption
end

function checkToolsOptionOver()
if cursor.y () < 272 and cursor.y() > 235 then
if cursor.x() < 145 and cursor.x() > 110 then
toolsOption =  "Selectionner une zone "
elseif cursor.x() < 185  and cursor.x() > 150 then
toolsOption = "Prelever une couleur"
elseif cursor.x() < 225 and cursor.x() > 190 then
toolsOption = "Pinceau"
elseif cursor.x() < 265 and cursor.x() > 230 then
toolsOption = "Remplissage"
elseif cursor.x() < 305 and cursor.x() > 270 then
toolsOption = "Supprimer l'image"
elseif cursor.x() < 345 and cursor.x() > 310 then
toolsOption = "Inserer du texte"
elseif cursor.x() < 385 and cursor.x() > 350 then
toolsOption = "Zoom"
elseif cursor.x() < 415 and cursor.x() > 390 then
toolsOption = "Tracer une ligne"
elseif cursor.x() < 455 and cursor.x() > 420 then
if copyActive then 
toolsOption = "Coller selection"
else 
toolsOption = "Copier selection"
end
else 
toolsOption = false
end
else
toolsOption = false
end
return toolsOption
end

function onSelect()
if onPicture() and documentOpen then
if (cursor.x() < copyPhaseX) or (cursor.x() > (copyPhaseX+tempCopy:width()))  or (cursor.y() < copyPhaseY) or (cursor.y() < (copyPhaseY+tempCopy:height()))  then
return false
else
return true
end
end
end