-- Background  :
upCbg = Image.load("System/data/updateC.jpg")

-- Menu box :
menuBox = Image.createEmpty(121,272) 
menuBox:clear(Color.new(200,200,200,80)) -- Clear picture with transparency
menuBox:drawLine(0,0,121,0,Color.new(10,10,10)) -- Border Line top
menuBox:drawLine(120,0,120,272,Color.new(10,10,10)) -- Border Line right
menuBox:drawLine(0,271,121,271,Color.new(10,10,10)) -- Border Line bottom
menuBox:print(20,10,'News',Color.new(255,255,255))
menuBox:print(20,40,'Update',Color.new(255,255,255))
menuBox:print(20,70,'Filtre',Color.new(255,255,255))
menuBox:print(20,100,'Font',Color.new(255,255,255))
menuBox:print(20,130,'Effect',Color.new(255,255,255))
-- Content BOX :
contentBox = Image.createEmpty(300,232) 
contentBox:clear(Color.new(100,100,100,80)) -- Clear picture with transparency
contentBox:drawLine(0,0,300,0,Color.new(10,10,10)) -- Border Line top
contentBox:drawLine(299,0,299,232,Color.new(10,10,10)) -- Border Line right
contentBox:drawLine(0,231,300,231,Color.new(10,10,10)) -- Border Line bottom
contentBox:drawLine(0,0,0,231,Color.new(10,10,10)) -- Border Line left
onMenu = true
onPage = false
menuSelect = news
compteur = 1
inConnect = true
function reloadScreen()
screen:clear()
screen:blit(0,0,upCbg)
screen:blit(0,0,menuBox)
screen:blit(150,20,contentBox)
if inConnect then
screen:print(200,135,'Connexion en cours ...',Color.new(255,255,255))
end
if contentGot then
for i=0,table.getn(content) do
screen:print(160,30+(i*10),content[i],Color.new(255,255,255))
end
end
screen.flip()
screen.waitVblankStart()
end
reloadScreen()
content = serverRequest("www.shaolanweb.cs.cx","/dapesUpdate/news.php")
contentGot = true
inConnect = false
reloadScreen()
while true do
 pad = Controls.read()
 if onMenu then
  if pad:up() and compteur > 1 then
   System.sleep(200)
   compteur = compteur - 1
   reloadScreen()
  end
  if pad:down()and compteur < 5 then
   System.sleep(200)
   compteur = compteur + 1
   reloadScreen()
  end
  if pad:cross() then
  System.sleep(200)
   contentGot = false
   inConnect = true 
   reloadScreen()
   if compteur == 1 then	 
    content = serverRequest("www.shaolanweb.cs.cx","/dapesUpdate/news.php")
	contentGot = true
	inConnect = false
	reloadScreen()
   elseif compteur == 2 then
    content = serverRequest("www.shaolanweb.cs.cx","/dapesUpdate/update.php")
	contentGot = true
	inConnect = false
	reloadScreen()
   elseif compteur == 3 then
    content = serverRequest("www.shaolanweb.cs.cx","/dapesUpdate/filtre.php")
	contentGot = true
	inConnect = false
	reloadScreen()
   elseif compteur == 4 then
    content = serverRequest("www.shaolanweb.cs.cx","/dapesUpdate/font.php")
	contentGot = true
	inConnect = false
	reloadScreen()
   elseif compteur == 5 then
    content = serverRequest("www.shaolanweb.cs.cx","/dapesUpdate/effect.php")
	contentGot = true
	inConnect = false
	reloadScreen()
   end	
  end
 end
end
