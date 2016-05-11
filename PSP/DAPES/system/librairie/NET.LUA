--#==============================================================
--#  ..:: librairies codees par Shaolan ::..
--#==============================================================
--#==============================================================
--#==============================================================
--//-------------------------------------------------------------
--#==============================================================
--# -> DAPES NET CONFIG LIBRAIRIE     
--#==============================================================
function netConfig()
--// Phase de selection de connection
screen:save('System/Temp/bg.png')
local bg = Image.load('System/Temp/bg.png') 
local pic = Image.createEmpty(480,272)
Wlan.init()
config = Wlan.getConnectionConfigs()
selecteur = 1 
while true do
pad = Controls.read()
screen:clear()
pic:clear()
pic:blit(0,0,bg)
pic:clear(Color.new(150,150,150,180))
screen:blit(0,0,bg)
screen:blit(0,0,pic)
screen:fillRect(0,0,480,15,Color.new(0,0,0,130))
screen:print(10,3,'Connection internet',Color.new(255,255,255))
for i=1 ,table.getn(config) do
screen:print(180,(i*10)+60,i..':'..config[i],Color.new(255,255,255))
end
screen:print(160,(selecteur*10)+60,'->',Color.new(255,255,255))
screen:print(155,260,'X:Valider  O:Annuler',Color.new(255,255,255))
if pad:up() and (selecteur > 1)  then 
selecteur = selecteur - 1
end
if pad:down() and (selecteur < table.getn(config)) then 
selecteur = selecteur + 1
end
if pad:cross() then 
use = true
break
end
if pad:circle() then 
use = false
break
end

screen.flip()
screen.waitVblankStart()
end
-- si on a choisi une connection
if use == true then
screen:clear()
pic:clear()
pic:blit(0,0,bg)
pic:clear(Color.new(150,150,150,180))
screen:blit(0,0,bg)
screen:blit(0,0,pic)
screen:fillRect(0,0,480,15,Color.new(0,0,0,130))
screen:print(10,3,'Connection internet',Color.new(255,255,255))
screen:print(155,125,'Connection en cours ...',Color.new(255,255,255))
screen:print(155,140,config[selecteur],Color.new(255,255,255))
screen:drawLine(115,110,375,110,Color.new(255,255,255))
screen:drawLine(115,111,375,111,Color.new(60,60,60))
screen:drawLine(115,160,375,160,Color.new(255,255,255))
screen:drawLine(115,161,375,161,Color.new(60,60,60))
screen.flip()
screen.waitVblankStart()
--// Phase de connection
Wlan.useConnectionConfig(selecteur+1)
System.sleep(2000)
serverSocket = Socket.createServerSocket(80)
screen:clear()
pic:clear()
pic:blit(0,0,bg)
pic:clear(Color.new(150,150,150,180))
screen:blit(0,0,bg)
screen:blit(0,0,pic)
screen:fillRect(0,0,480,15,Color.new(0,0,0,130))
screen:print(10,3,'Connection internet',Color.new(255,255,255))
screen:print(150,125,"Obtention de l'adresse IP",Color.new(255,255,255))
screen:print(155,140,config[selecteur],Color.new(255,255,255))
screen:drawLine(115,110,375,110,Color.new(255,255,255))
screen:drawLine(115,111,375,111,Color.new(60,60,60))
screen:drawLine(115,160,375,160,Color.new(255,255,255))
screen:drawLine(115,161,375,161,Color.new(60,60,60))
screen.flip()
screen.waitVblankStart()
System.sleep(2000)
while true do
   ipAddress = Wlan.getIPAddress()
   if ipAddress then break end
   System.sleep(100)
end
screen:clear()
pic:clear()
pic:blit(0,0,bg)
pic:clear(Color.new(150,150,150,180))
screen:blit(0,0,bg)
screen:blit(0,0,pic)
screen:fillRect(0,0,480,15,Color.new(0,0,0,130))
screen:print(10,3,'Connection internet',Color.new(255,255,255))
screen:print(160,132,'Connection reussi',Color.new(255,255,255))
screen:drawLine(115,110,375,110,Color.new(255,255,255))
screen:drawLine(115,111,375,111,Color.new(60,60,60))
screen:drawLine(115,160,375,160,Color.new(255,255,255))
screen:drawLine(115,161,375,161,Color.new(60,60,60))
screen.flip()
screen.waitVblankStart()
System.sleep(2000)
dofile("system/script/dataunload.lua")
dofile("system/script/update_center.lua")
else
Wlan.term()
end
-- fin de fct
end


function serverCloseConnexion()
socket:close()
Wlan.term()
end

--// requete serveur
function serverRequest(server,page)
socket, error = Socket.connect(server, 80)
while not socket:isConnected() do System.sleep(100) end
bytesSent = socket:send("GET "..page.." HTTP/1.0\r\n")
bytesSent = socket:send("host: "..server.."\r\n\r\n")
System.sleep(100)
requestCount = 0
header = ""
headerFinished = false
while true do
   -- reception du resultat
   buffer = socket:recv()
   System.sleep(100)
   if string.len(buffer) > 0 then
      if headerFinished then
         System.sleep(100)
      else
         System.sleep(100)
         header = header .. buffer
         startIndex, endIndex = string.find(header, "\r\n\r\n")
         if endIndex then
            System.sleep(100)
            header = string.sub(header, endIndex)
            header = string.sub(header, 2)
            socket:close()
			-- Phase de traitement de la requete 
			result = {}
			j = 0
			k = 0
			for i=1,string.len(header) do
			if string.sub(header,i,i+3) == "<BR>" then
			result[j] = string.sub(header,k,i-1)
			if string.len(result[j])>34 then
			result[j+1] = string.sub(result[j],34) 
			result[j] = string.sub(result[j],0,34)
			j = j + 2
			else
			j = j + 1
			end
			k = i + 4
			i = i + 3
			end 
			end
			result[j] = string.sub(header,k)
            return result
         end
      end
   end
   end
end

