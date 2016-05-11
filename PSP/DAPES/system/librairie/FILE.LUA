--# ENSEMBLE DES OBJETS RELATIFS A LA MANIPULATION DES FICHIERS
--# Objet Picture
Picture = {}
function Picture.new(w,h,name,dir,save,text)
local self = {width = w , height = h, name = name, dir = dir,save = save,zoom = 0,scrollX = 0,scrollY = 0}
self.scrollXmax = self.width - 360
self.scrollYmax = self.height - 240
local picS = Image.createEmpty(self.width,self.height)
if text == true then
else
picS:clear(Color.new(255,255,255)) 
end
local draw = {}
local checkScrollMax = function()
                        self.scrollX = 0
                        self.scrollY = 0 
                        self.height = picS:height()
                        self.width = picS:width()
                        self.scrollXmax = self.width - 360
                        self.scrollYmax = self.height - 240
                        if self.scrollXmax < 0 then
                        self.scrollXmax = 0 
                        end
                        if self.scrollYmax < 0 then
                        self.scrollYmax = 0 
                        end
                       end
local save = function ()
        picS:save(filePath..'/'..texte..'.png')
       end

local zoom = function (s,n)
        --// Si on veut un zoom arriere
        if s == "out" then
         if self.zoom == 0 then
          alert("Zoom","Impossible de retrecir plus !",true)
          playI()
         else
          alert("Zoom","Zoom en cours",false)
          zoomPic = Image.createEmpty(picS:width()/n,picS:height()/n)
           i = 0
           j = 0
           xz = 0
           yz = 0
           
           while yz < (picS:height()-1) do
            while xz < (picS:width()-1) do
             zoomPic:pixel(i,j,picS:pixel(xz,yz))
             i = i + 1
             xz = xz + n 
            end
            j = j + 1
            i = 0
            yz = yz + n
            xz = 0
           end
          picS = zoomPic
          self.zoom = self.zoom - n
          checkScrollMax()
         end
        --// Si on veut un zoom avant
        elseif s == "in" then
         if picS:width() * n < 512 and picS:height() < 512 then
          alert("Zoom","Zoom en cours",false)
          zoomPic = Image.createEmpty(picS:width()*n,picS:height()*n)
           for y = 0,picS:height() - 1 do
            for x = 0,picS:width() -1 do
             for i=0,n-1 do
              for j=0,n-1 do      
               zoomPic:pixel((x*n)+i,(y*n)+j,picS:pixel(x,y))          
              end
             end
            end
           end
           picS = zoomPic
           self.zoom = self.zoom + n
          checkScrollMax()
          else
         alert("Zoom","Impossible d'agrandir plus !",true)
         playI()
        end   
        end
       end 

local zoomN = function ()
               return self.zoom
              end
     
local img = function () return picS end
local imgE = function (p)  picS = p end
local scrollDown = function (s)
                    self.scrollY = self.scrollY + s
                   end
local scrollUp = function (s)
                     if s == 0 then
                     self.scrollY  = 0
                     else
                     self.scrollY = self.scrollY - s
                     end
                   end
local scrollLeft = function (s)
                    if s == 0 then
                    self.scrollX = 0
                    else
                    self.scrollX = self.scrollX - s
                    end
                   end                   
local scrollRight = function (s)
                    self.scrollX = self.scrollX + s
                   end
local  scrollX = function ()
                  return self.scrollX
                 end                  
local  scrollY = function ()
                  return self.scrollY
                 end
local  scrollXmax = function ()
                  return self.scrollXmax
                 end                  
local  scrollYmax = function ()
                  return self.scrollYmax
                 end
local  width = function ()
                  return self.width
                 end
local  height = function ()
                  return self.height
                 end
return {save = save,
    img = img,
    imgE = imgE,
    zoom = zoom,
    zoomN = zoomN,
    scrollX = scrollX,
    scrollY = scrollY,
    scrollXmax = scrollXmax,
    scrollYmax = scrollYmax,
    scrollDown = scrollDown,
    scrollUp = scrollUp,
    scrollRight = scrollRight,
    scrollLeft = scrollLeft,
	width = width,
	height = height,
     }
end

--# Objet File
File = {}
function File.open(name)
 local testPic = function()
                   testImg = Image.load(name)
				 end
 testProcess = coroutine.create(testPic)
 statut ,erreur = coroutine.resume(testProcess)
 if not(statut) then
  alert("Erreur","Impossible de charger(Image trop grande)",true)
  return "notLoaded" 
 else
  local img = Image.load(name)
  local doc = Picture.new(img:width(),img:height(),name,'0',true)
  doc.imgE(img)
  img = nil
  return doc
 end
 testPic = nil
 testImg = nil
 testProcess = nil
 collectgarbage()
end

function File.new()
local pic = Picture.new(param.width,param.height,0,0,0,false)
return pic
end