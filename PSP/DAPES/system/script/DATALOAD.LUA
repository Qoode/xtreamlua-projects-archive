--#============================================
--# Script de chargement des ressources
--#============================================
-- Fonction de rafrachissement du logo 
function refresh(texte)
screen:clear()
screen:blit(0,0,background)
screen:print(10,10,texte,Color.new(0,0,0))
screen.flip()
screen.waitVblankStart()
end

System.usbDiskModeActivate()

refresh("Chargement de la librairie mouse.lua ...")
dofile("system/librairie/mouse.lua")
refresh("Chargement de la librairie keyboard.lua ...")
dofile("system/librairie/keyboard.lua")
refresh("Chargement de la librairie ask.lua ...")
dofile("system/librairie/ask.lua")
refresh("Chargement de la librairie file.lua ...")
dofile("system/librairie/file.lua")
refresh("Chargement de la librairie net.lua ...")
dofile("system/librairie/net.lua")
refresh("Chargement de la librairie draw.lua ...")
dofile("system/librairie/draw.lua")
refresh("Chargement de la configuration ...")
param = {primaryCO = Color.new(0,0,0),secondaryCO = Color.new(255,255,255),width = 150, height = 100,version = 'preview'}

refresh("Chargement des ressources graphique ...")
-- Chargement des images / icones
copy = Image.load("system/data/icon/copy.png")
del = Image.load("system/data/icon/del.png")
dir = Image.load("system/data/icon/dir.png")
exitP = Image.load("system/data/icon/exit.png")
fiole = Image.load("system/data/icon/fiole.png")
loupe = Image.load("system/data/icon/loupe.png")
net = Image.load("system/data/icon/net.png")
new = Image.load("system/data/icon/new.png")
cf = Image.load("system/data/icon/param.png")
pinceau = Image.load("system/data/icon/pinceau.png")
pot = Image.load("system/data/icon/pot.png")
save = Image.load("system/data/icon/save.png")
select = Image.load("system/data/icon/select.png")
texte = Image.load("system/data/icon/texte.png")
update = Image.load("system/data/icon/update.png")
line = Image.load("system/data/icon/line.png")

refresh("Chargement de l'interface ...")
-- Creations des boites de dialogues / boites à outils / palettes etc ...
-- Cadre de l'image
calque = Image.load("system/data/calque.png")
cadre = Image.createEmpty(362,242)
cadre:clear(Color.new(0,0,0))
cadre:blit(1,1,calque)

-- Palette 
palette = Image.createEmpty(76,106)
palette:clear(Color.new(0,0,0,90))
palette:fillRect(1,1,74,104,Color.new(140,140,140,80))

function paletteRefresh()
-- Couleur Secondaire
palette:fillRect(30,15,20,20,param.secondaryCO)
-- Couleur Primaire
palette:fillRect(20,5,20,20,param.primaryCO)
-- Gamme de rouge
x = 5
y = 40
for i = 0,5 do
palette:fillRect(x,y,10,10,Color.new(255-(i*37),0,0))
x = x + 11
end
-- Gamme de vert
x = 5
y = 51
for i = 0,5 do
palette:fillRect(x,y,10,10,Color.new(0,255-(i*37),0))
x = x + 11
end
-- Gamme de bleu
x = 5
y = 61
for i = 0,5 do
palette:fillRect(x,y,10,10,Color.new(0,0,255-(i*37)))
x = x + 11
end
-- Gamme de Jaune / Orange
x = 5
y = 71
for i = 0,5 do
palette:fillRect(x,y,10,10,Color.new(255-(i*37),255-(i*37),0))
x = x + 11
end
-- Gamme de violet
x = 5
y = 81
for i = 0,5 do
palette:fillRect(x,y,10,10,Color.new(255-(i*37),0,255-(i*37)))
x = x + 11
end
-- Gamme de Noir / Gris / blanc
x = 5
y = 91
palette:fillRect(x,y,10,10,Color.new(255,255,255))
x = x + 11
for i = 0,3 do
palette:fillRect(x,y,10,10,Color.new(255-(i*37),255-(i*37),255-(i*37)))
x = x + 11
end
palette:fillRect(x,y,10,10,Color.new(0,0,0))
end
paletteRefresh()
-- Boite à outils :
box = {}
box = {file = Image.createEmpty(302,62),tool = Image.createEmpty(392,62),active = "file"}
-- Manipulation de fichier (save , new , open)
box.file:clear(Color.new(0,0,0,50))
box.file:fillRect(1,1,300,60,Color.new(192,192,192,50))
box.file:blit(20,20,new)
box.file:blit(60,20,dir)
box.file:blit(100,20,save)
box.file:blit(140,20,cf)
box.file:blit(180,20,update)
box.file:blit(220,20,net)
box.file:blit(260,20,exitP)
box.file:print(185,5,"R -> Tools box ",Color.new(0,0,0))
-- Outil graphique (pot , pinceau , loupe , selection )
box.tool:clear(Color.new(0,0,0,50))
box.tool:fillRect(1,1,390,60,Color.new(192,192,192,50))
box.tool:blit(20,20,select)
box.tool:blit(60,20,fiole)
box.tool:blit(100,20,pinceau)
box.tool:blit(140,20,pot)
box.tool:blit(180,20,del)
box.tool:blit(220,20,texte)
box.tool:blit(260,20,loupe)
box.tool:blit(300,20,line)
box.tool:blit(340,20,copy)
box.tool:print(283,5,"R -> File box ",Color.new(0,0,0))


-- Boite de dialogue
askBox = Image.createEmpty(250,100)
askBox:clear(Color.new(0,0,0,150))
-- // Contour de la boite de dialogue
askBox:drawLine(0,0,250,0,Color.new(0,0,0))
askBox:drawLine(0,99,250,99,Color.new(0,0,0))
askBox:drawLine(0,0,0,100,Color.new(0,0,0))
askBox:drawLine(250,0,250,100,Color.new(0,0,0))
-- // Interieur de la boite (partie contenant la question)
askBox:fillRect(3,20,244,77,Color.new(0,0,0))
askBox:fillRect(4,21,242,75,Color.new(240,240,240))


police = {}
police[1] = Font.load('System/data/font/wonder.ttf') 
police[1]:setPixelSizes(20, 20) 
police[2] = Font.load('System/data/font/modern.ttf') 
police[2]:setPixelSizes(10, 10) 
police[3] = Font.load('System/data/font/write.ttf') 
police[3]:setPixelSizes(40, 40) 
police[4] = Font.load('System/data/font/score.ttf') 
police[4]:setPixelSizes(20, 20) 
police[5] = Font.load('System/data/font/point.ttf') 
police[5]:setPixelSizes(30, 30)  

fontSelected = "classic"

-- Menu filtre
filtreBox = Image.createEmpty(300,200)
filtreBox:clear(Color.new(0,0,0,150))
-- // Contour de la boite de dialogue
filtreBox:drawLine(0,0,300,0,Color.new(0,0,0))
filtreBox:drawLine(0,199,200,199,Color.new(0,0,0))
filtreBox:drawLine(0,0,0,200,Color.new(0,0,0))
filtreBox:drawLine(300,0,300,200,Color.new(0,0,0))
-- // Interieur de la boite (partie contenant la question)
filtreBox:fillRect(3,20,294,177,Color.new(0,0,0))
filtreBox:fillRect(4,21,292,175,Color.new(240,240,240))
filtreBox:print(5,8,'Filtre :',Color.new(255,255,255))
filtreBox:print(8,170,'Triangle : quitter',Color.new(0,0,0))
filtreBox:print(8,180,'Croix : valider',Color.new(0,0,0))

filtre = {}
filtre[1] = "Transparence"
filtre[2] = "Manipulation"
filtre[3] = "Brush"
filtre[4] = "Effet"
filtre[5] = "Texte"

filtre1 = {}
filtre1[1] = "Couleur de transparence"
filtre1[2] = "Canal de transparence"


filtre2 = {}
filtre2[1] = "Symetrie vertical"
filtre2[2] = "Symetrie horizontale"
filtre2[3] = "Rotation (non disponible)"

filtre3 = {}
filtre3[1] = "Brush 1"
filtre3[2] = "Brush 2"
filtre3[3] = "Brush 3"

filtre4 = {}
filtre4[1] = "Quadrillage"
filtre4[2] = "Maillage (non disponible)"
filtre4[3] = "Degrade (non disponible)"

filtre5 = {}
filtre5[1] = "Choisir font (non disponible)"
filtre5[2] = "Taille (non disponible)"

icon = {}
icon[1] = Image.load("system/data/Icon/ext/picture.png")
icon[2] = Image.load("system/data/Icon/ext/sound.png")
icon[3] = Image.load("system/data/Icon/ext/texte.png")
icon[4] = Image.load("system/data/Icon/ext/DIR.png")
icon[5] = Image.load("system/data/Icon/ext/unknown.png")

oldToolsOver = "none"
oldFileOver = "none"
documentOpen = false
documentSave = false
filtreActive = false

bg = nil
collectgarbage()