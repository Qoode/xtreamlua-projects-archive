-- // Les doubles screen.flip() / screen.waitVblankStart() , avant et apres impression ecran
-- // sont la seule methode (pour une raison que j'ignore) de conserve la transparence 
-- // au fur et à mesure des appelles de boites de dialogues 

function confirm(category,question)
System.sleep(300)
screen.flip()
screen.waitVblankStart()
screen:blit(125,85,askBox)
screen:print(130,93,category,Color.new(255,255,255))
if string.len(question) > 28 then
screen:print(133,112,string.sub(question,0,28),Color.new(0,0,0))
screen:print(133,125,"- "..string.sub(question,28,-1),Color.new(0,0,0))
else
screen:print(133,112,question,Color.new(0,0,0))
end
screen:print(135,155,"X : Oui    O : Non",Color.new(0,0,0))
screen.flip()
screen.waitVblankStart()
while true do
pad = Controls.read()
if pad:cross() then
if category == "Quitter DAPES" and question == "Voulez-vous quittez DAPES ?" then
System.Quit()
elseif category == "Transparence" then
return true
end
elseif pad:circle() then
if category == "Quitter DAPES" and question == "Voulez-vous quittez DAPES ?" then
playI()
break
elseif category == "Transparence" then
return false
end
end
end
end

function askN(question)
System.sleep(300)
number = {}
number[1] = 1
number[2] = 0
number[3] = 0
screen:blit(125,85,askBox)
screen:print(130,92,question,Color.new(255,255,255))
screen:print(135,114,number[1] .."  ".. number[2] .."  ".. number[3],Color.new(0,0,0))
screen:print(136,124,"^",Color.new(0,0,0))
screen.flip()
screen.waitVblankStart()
selecteur = 1
while true do
pad = Controls.read()
if pad:square() then
screen:save("if.png")
end
if pad:up() and number[selecteur] < 9 then
System.sleep(100)
number[selecteur] = number[selecteur] + 1
playI()
screen.flip()
screen.waitVblankStart()
screen:blit(125,85,askBox)
screen:print(130,92,question,Color.new(255,255,255))
screen:print(135,114,number[1] .."  ".. number[2] .."  ".. number[3],Color.new(0,0,0))
screen:print(135 + (selecteur+((selecteur-1)*22)),124,"^",Color.new(0,0,0))
screen.flip()
screen.waitVblankStart()
elseif pad:down() and number[selecteur] > 0 then
System.sleep(100)
number[selecteur] = number[selecteur] - 1
playI()
screen.flip()
screen.waitVblankStart()
screen:blit(125,85,askBox)
screen:print(130,92,question,Color.new(255,255,255))
screen:print(135,114,number[1] .."  ".. number[2] .."  ".. number[3],Color.new(0,0,0))
screen:print(135 + (selecteur+((selecteur-1)*22)),124,"^",Color.new(0,0,0))
screen.flip()
screen.waitVblankStart()
elseif pad:left() and selecteur > 1 then
System.sleep(100)
selecteur = selecteur - 1
playI()
screen.flip()
screen.waitVblankStart()
screen:blit(125,85,askBox)
screen:print(130,92,question,Color.new(255,255,255))
screen:print(135,114,number[1] .."  ".. number[2] .."  ".. number[3],Color.new(0,0,0))
screen:print(135 + (selecteur+((selecteur-1)*22)),124,"^",Color.new(0,0,0))
screen.flip()
screen.waitVblankStart()
elseif pad:right() and selecteur < 3 then
System.sleep(100)
selecteur = selecteur + 1
playI()
screen.flip()
screen.waitVblankStart()
screen:blit(125,85,askBox)
screen:print(130,92,question,Color.new(255,255,255))
screen:print(135,114,number[1] .."  ".. number[2] .."  ".. number[3],Color.new(0,0,0))
screen:print(135 + (selecteur+((selecteur-1)*22)),124,"^",Color.new(0,0,0))
screen.flip()
screen.waitVblankStart()
elseif pad:cross() then
System.sleep(100)
final = (number[1]*100)+(number[2]*10) + number[3]
if final > 512 and not(question == "Canal alpha") and not(question == "Rouge") and not(question == "Vert") and not(question == "Bleu") then
playI()
alert("Error","Impossible de depasser 512 pixels",true)
numBox = nil
number = nil
final = nil
selecteur = nil
collectgarbage()
playI()
return false
elseif final > 255 and (question == "Canal alpha") and (question == "Rouge")  and (question == "Vert")  and (question == "Bleu") then
playI()
alert("Error","Valeur max : 255",true)
numBox = nil
number = nil
final = nil
selecteur = nil
collectgarbage()
playI()
else
numBox = nil
number = nil
selecteur = nil
collectgarbage()
playI()
return final
end
elseif pad:circle() then
System.sleep(100)
playI()
return false
end


end
end

function alert(category,message,padC)
 screen.flip()
 screen.waitVblankStart()
 System.sleep(300)
 screen:blit(125,85,askBox)
 screen:print(130,93,category,Color.new(255,255,255))
 if string.len(message) > 25 then
  screen:print(135,120,string.sub(message,0,27),Color.new(0,0,0)) 
  screen:print(135,130,string.sub(message,28),Color.new(0,0,0)) 
 else
  screen:print(135,120,message,Color.new(0,0,0)) 
 end
 if padC then
 screen:print(150,165,"X : Continuer",Color.new(0,0,0))
 end
 screen.flip()
 screen.waitVblankStart()
 while padC do
  pad = Controls.read()
  if pad:square() then
   screen:save("if1.png")
  end
  if pad:cross() and padC then
   System.sleep(200)
   break
  end
 end
end