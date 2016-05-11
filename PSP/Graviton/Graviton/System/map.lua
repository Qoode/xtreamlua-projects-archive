Map = {}

function Map.new(bg,p)
 local self = {} -- Matrice des données
 local nPlayer = p
 local newTemp = {}
 local animation = false 
 local range = false 
 local destroy = false 
 local tempY = 0
 local tempX = 0
 local first = true
 local animationFinish = false
 local Hselector = Image.load("Data/Picture/Interface/Hselector.png")
 local Vselector = Image.load("Data/Picture/Interface/Vselector.png")
 local primary = Image.load("Data/Picture/Interface/primary.png")
 local background = Image.load("Data/Picture/Background/"..bg..".png") 
 local pic = Image.createEmpty(240,240) -- Image de la map 
 local graviton = {} -- Tableau contenant les images des gravitons 
 local side = "vertical"
 local playerData = {}
 local playerTurn = 1
 math.randomseed(os.time())
 for i=1,4 do
  playerData[i] = {g = 16, ID = math.random(1,4),temp = {}}
  find = false
 end 
 playerData[1].temp[1] = playerData[1].ID
 playerData[1].temp[2] = playerData[1].ID
 playerData[1].temp[3] = 5
 while true do
  tempID = math.random(1,4)
  if tempID ~= playerData[1].ID then
   playerData[2].ID = tempID
   playerData[2].temp[1] = playerData[2].ID
   playerData[2].temp[2] = playerData[2].ID
   playerData[2].temp[3] = 5
   break
  end 
 end
 while true do
  tempID = math.random(1,4)
  if tempID ~= playerData[1].ID and tempID ~= playerData[2].ID then
   playerData[3].ID = tempID
   playerData[3].temp[1] = playerData[3].ID
   playerData[3].temp[2] = playerData[3].ID
   playerData[3].temp[3] = 5
   break
  end 
 end
 while true do
  tempID = math.random(1,4)
  if tempID ~= playerData[1].ID and tempID ~= playerData[2].ID  and tempIDs ~= playerData[3].ID  then
   playerData[4].ID = tempID
   playerData[4].temp[1] = playerData[4].ID
   playerData[4].temp[2] = playerData[4].ID
   playerData[4].temp[3] = 5
   break
  end 
 end

 graviton[1] = Image.load("Data/Picture/Graviton/replicaton.png") -- Boule bleu 
 graviton[2] = Image.load("Data/Picture/Graviton/infecaton.png") -- Boule Verte
 graviton[3] = Image.load("Data/Picture/Graviton/destrucaton.png") -- Boule rouge
 graviton[4] = Image.load("Data/Picture/Graviton/immunocaton.png") -- Boule Jaune
 graviton[5] = Image.load("Data/Picture/Graviton/neutrograviton.png") -- Boule grise
 graviton[6] = Image.load("Data/Picture/Graviton/negagraviton.png") -- Boule Blanche
 graviton[7] = Image.load("Data/Picture/Graviton/posigraviton.png") -- Boule noir
 local destroyAnim = Image.load("Data/Picture/Graviton/blancAnim.png") 
 local lineID = 7
 local check = function () -- Fonction de controle des blocs , si un bloc est detecté elle lance l'animation ainsi que les controles d'affinités
                for i=0,6 do
				 for j=1,7 do
				  if self[i][j] == self[i][j-1] and self[i][j] == self[i+1][j] and self[i][j] == self[i+1][j-1] and not(self[i][j] == 5) and not(self[i][j] == 6) then
				   destroy = true   
				   destroyX = i
				   destroyY = j
				   nDestroy = 4 
				   count = 0
				   countAnim = 1
				   animation = true
				   animationFinish = false
				  end
				 end
				end
               end  	
			   
 local reload = function () -- Fonction de rafraichissement de la map
                 pic:clear(Color.new(255,255,255,0)) -- Supression du contenu de l'image avec transparence
				 pic:drawLine(0,0,pic:width()-1,0,Color.new(255,255,255))
				 pic:drawLine(0,0,0,pic:height()-1,Color.new(255,255,255))
				 pic:drawLine(0,pic:height()-1,pic:width()-1,pic:height()-1,Color.new(255,255,255))
				 pic:drawLine(pic:width()-1,0,pic:width()-1,pic:height()-1,Color.new(255,255,255))
				 if not(animation) then
				  -- Impression de tous les gravitons de la grilles  
				  for i=0,7 do
				   for j=0,7 do
				    pic:blit(i*30,j*30,graviton[self[i][j]])
				   end
				  end
				 else
				  if range then -- Si l'animation de deplacement est en cours 
				   if side == "horizontal" then
				   	for i=0,7 do
				     for j=0,7 do
					  if not(i == lineID) then
				       pic:blit(i*30,j*30,graviton[self[i][j]])
					  end
				     end
				    end	
				    if moveSide == "right" then 
				     for i=0,7 do
				      pic:blit(lineID*30,(i*30) + tempY,graviton[self[lineID][i]])
				     end
				     for i=1,3 do
				      pic:blit(lineID*30,((i-4)*30) + tempY,graviton[playerData[playerTurn].temp[i]])
				     end
				    elseif moveSide == "left" then
				     for i=0,7 do
				      pic:blit(lineID*30,(i*30) - tempY,graviton[self[lineID][i]])
				     end
				     for i=1,3 do
				      pic:blit(lineID*30,((i+7)*30) - tempY,graviton[playerData[playerTurn].temp[i]])
				     end  	   
				    end 
                   elseif side == "vertical" then
				    for i=0,7 do
				     for j=0,7 do
					  if not(j == lineID) then
				       pic:blit(i*30,j*30,graviton[self[i][j]])
					  end
				     end
				    end	
				    if moveSide == "right" then 
				     for i=0,7 do
				      pic:blit((i*30) + tempX,lineID*30,graviton[self[i][lineID]])
				     end
				     for i=1,3 do
				      pic:blit(((i-4)*30) + tempX,lineID*30,graviton[playerData[playerTurn].temp[i]])
				     end
				    elseif moveSide == "left" then
				     for i=0,7 do
				      pic:blit((i*30) - tempX,lineID*30,graviton[self[i][lineID]])
				     end
				     for i=1,3 do
				      pic:blit(((i+7)*30) - tempX,lineID*30,graviton[playerData[playerTurn].temp[i]])
				     end  	   
				    end   
				   end 
  			      elseif destroy then
				   for i=0,7 do
				    for j=0,7 do
				     pic:blit(i*30,j*30,graviton[self[i][j]])
				    end
				   end
				   if nDestroy == 4 then				   
 				    if count == 1 then
				     pic:blit(destroyX*30,destroyY*30,destroyAnim)
				     pic:blit((destroyX+1)*30,destroyY*30,destroyAnim)
				     pic:blit(destroyX*30,(destroyY-1)*30,destroyAnim)
				     pic:blit((destroyX+1)*30,(destroyY-1)*30,destroyAnim)
				    elseif count == 2 then
				     if self[destroyX][destroyY] == playerData[playerTurn].ID then
					  self[destroyX][destroyY] = 5
				      self[destroyX+1][destroyY] = 5 
				      self[destroyX][destroyY-1] = 5
				      self[destroyX+1][destroyY-1] = 5 
					 else
				 	  if playerData[playerTurn].ID == 1 then -- Replication
					   destroyContinue = false
				       self[destroyX][destroyY] = 1
				       self[destroyX+1][destroyY] = 5 
				       self[destroyX][destroyY-1] = 5
				       self[destroyX+1][destroyY-1] = 1 
			 		  elseif playerData[playerTurn].ID == 2 then -- Infection
					   destroyContinue = true
					   find = false
					   if nPlayer == 2 then
					    for i=0,7 do
					     for j=0,7 do
						  if self[i][j] == playerData[2].ID and not(find == true) then 
					       destroyX = i
						   destroyY = j
						   find = true
						  end 
						 end
                        end
                       else
					   
					   end	
				       self[destroyX][destroyY] = math.random(5,6)
				       self[destroyX+1][destroyY] = math.random(5,6) 
				       self[destroyX][destroyY-1] = math.random(5,6)
				       self[destroyX+1][destroyY-1] = math.random(5,6)
					  elseif playerData[playerTurn].ID == 3 then -- Destruction 
				       self[destroyX][destroyY] = 5
				       self[destroyX+1][destroyY] = 5 
				       self[destroyX][destroyY-1] = 5
				       self[destroyX+1][destroyY-1] = 5 
					   destroyContinue = true
					   find = false
					   if nPlayer == 2 then
					    if playerTurn == 1 then
						 tempPlayerID = 2
						elseif playerTurn == 2 then
						 tempPlayerID = 1						 
						end
					    for i=0,7 do
					     for j=0,7 do
						  if self[i][j] == playerData[tempPlayerID].ID and find == false then 
					       destroyX = i
						   destroyY = j
						   find = true
						   break
						  end 
						 end
						 if find then
						  find = false 
						  break
						 end
                        end
                       else
					   
					   end					   
				       self[destroyX][destroyY] = math.random(5,6)
				       self[destroyX+1][destroyY] = math.random(5,6) 
				       self[destroyX][destroyY-1] = math.random(5,6)
				       self[destroyX+1][destroyY-1] = math.random(5,6)
					  elseif playerData[playerTurn].ID == 4 then -- Immunisation
				       self[destroyX][destroyY] = 5
				       self[destroyX+1][destroyY] = 5 
				       self[destroyX][destroyY-1] = 5
				       self[destroyX+1][destroyY-1] = 5
					  end 
					 end 
					 if destroyContinue then
					  nDestroy = 1
					  count = 0
				      countAnim = 1
					 else
				      destroy = false
					  animationFinish = true
				      animation = false
					  destroyFinish = true
					  destroyContinue  = false
					  check()
					 end
				    end
				   elseif nDestroy == 1 then
                 	if count == 1 then
				     pic:blit(destroyX*30,destroyY*30,destroyAnim)
				    elseif count == 2 then	
					 if playerData[playerTurn].ID == 2 then					  
					  self[destroyX][destroyY] = playerData[playerTurn].ID
					 elseif playerData[playerTurn].ID == 3 then
					  self[destroyX][destroyY] = math.random(5,6)
					 end
					  destroy = false
					  animationFinish = true
				      animation = false
					  destroyFinish = true
					  destroyContinue  = false
					  check()
					end
				   end
				  end
				 end 
				 -- Impression de la linge selectionné
				 if side == "horizontal" then
				  pic:blit(lineID*30,0,Hselector)
				 elseif side == "vertical" then
				  pic:blit(0,lineID*30,Vselector)
                 end				 
                end
 local playerTurnUp = function()
                       if nPlayer == 2 then
                        if playerTurn == 1 then
                         playerTurn = 2
                        elseif playerTurn == 2 then
                         playerTurn = 1 
                        end						 
                       elseif nPlayer == 4 then
					    if playerTurn == 4 then
						 playerTurn = 1
						else
						 playerTurn = playerTurn + 1
						end
                       end		
                      end 
 local destroy = function ()
                  if countAnim == 1 and count == 10 then
				   countAnim = 2
				  elseif countAnim == 1 and count < 10 then
                   count = count + 1 
                  end				  
                 end
 local move = function (s)
                if first then
				 for i=0,7 do
				  if self[i][lineID] == 6 and side == "vertical" then
				   moveCheck = false
				   break
				  elseif self[lineID][i] == 6 and side =="horizontal" then
				   moveCheck = false
				   break
				  end
				  moveCheck = true
				 end
				 if moveCheck then
 				  moveSide = s
			      range = true
			      animation = true
				  first = false
				  animationFinish = false
				 else
				 
				 end 
				end 
			    if animationFinish then
				 if side == "horizontal" then
				  if moveSide == "right" then
				   newTemp = {}
			       newTemp[1] = self[lineID][5]
			       newTemp[2] = self[lineID][6]
			       newTemp[3] = self[lineID][7]
				   self[lineID][7] = self[lineID][4]
			       self[lineID][6] = self[lineID][3] 
			       self[lineID][5] = self[lineID][2] 
			       self[lineID][4] = self[lineID][1]
			       self[lineID][3] = self[lineID][0] 
			       self[lineID][2] = playerData[playerTurn].temp[3] 
			       self[lineID][1] = playerData[playerTurn].temp[2] 
			       self[lineID][0] = playerData[playerTurn].temp[1] 
				   playerData[playerTurn].temp[1] = newTemp[1]
				   playerData[playerTurn].temp[2] = newTemp[2]
				   playerData[playerTurn].temp[3] = newTemp[3]
				  elseif moveSide == "left" then
			       newTemp[1] = self[lineID][0]
			       newTemp[2] = self[lineID][1]
			       newTemp[3] = self[lineID][2]
				   self[lineID][0] = self[lineID][3]
			       self[lineID][1] = self[lineID][4] 
			       self[lineID][2] = self[lineID][5] 
			       self[lineID][3] = self[lineID][6]
			       self[lineID][4] = self[lineID][7] 
			       self[lineID][5] = playerData[playerTurn].temp[1] 
			       self[lineID][6] = playerData[playerTurn].temp[2] 
			       self[lineID][7] = playerData[playerTurn].temp[3] 
				   playerData[playerTurn].temp[1] = newTemp[1]
				   playerData[playerTurn].temp[2] = newTemp[2]
				   playerData[playerTurn].temp[3] = newTemp[3]
                  end
                 elseif side == "vertical" then
				  if moveSide == "right" then
				   newTemp = {}
			       newTemp[1] = self[5][lineID]
			       newTemp[2] = self[6][lineID]
			       newTemp[3] = self[7][lineID]
				   self[7][lineID] = self[4][lineID]
			       self[6][lineID] = self[3][lineID] 
			       self[5][lineID] = self[2][lineID]
			       self[4][lineID] = self[1][lineID]
			       self[3][lineID] = self[0][lineID]
			       self[2][lineID] = playerData[playerTurn].temp[3] 
			       self[1][lineID] = playerData[playerTurn].temp[2] 
			       self[0][lineID] = playerData[playerTurn].temp[1] 
				   playerData[playerTurn].temp[1] = newTemp[1]
				   playerData[playerTurn].temp[2] = newTemp[2]
				   playerData[playerTurn].temp[3] = newTemp[3]
				  elseif moveSide == "left" then
			       newTemp[1] = self[0][lineID]
			       newTemp[2] = self[1][lineID]
			       newTemp[3] = self[2][lineID]
				   self[0][lineID] = self[3][lineID]
			       self[1][lineID] = self[4][lineID] 
			       self[2][lineID] = self[5][lineID]
			       self[3][lineID] = self[6][lineID]
			       self[4][lineID] = self[7] [lineID]
			       self[5][lineID] = playerData[playerTurn].temp[1] 
			       self[6][lineID] = playerData[playerTurn].temp[2] 
			       self[7][lineID] = playerData[playerTurn].temp[3] 
				   playerData[playerTurn].temp[1] = newTemp[1]
				   playerData[playerTurn].temp[2] = newTemp[2]
				   playerData[playerTurn].temp[3] = newTemp[3]
                  end
                 end				 
	             animation = false
				 animPlayed = false
                 range = false
				 first = true
				 tempY = 0
				 tempX = 0
				 collectgarbage()
				 reload()
				 check()
				else
				 tempY = tempY + 10
				 tempX = tempX + 10
				 reload()
				 if tempY == 90 or tempX == 90 then
				  animationFinish = true
				 end
				end
			   end  
  
 local play = function () -- Fonction d'impression de la map sur l'ecran	
               if animation and range then 
			    reload() 
			    move()
               elseif animation and destroy then
                reload()
                destroy()				
			   end
			   if destroyFinish then 
			    reload()
                destroyFinish = false 
               end				
               screen:blit(0,0,background)   
               screen:blit(120,16,pic)
			   -- Temp du player 1
			   screen:blit(5,110,graviton[playerData[1].temp[1]])
			   screen:blit(35,110,graviton[playerData[1].temp[2]])
			   screen:blit(65,110,graviton[playerData[1].temp[3]])
			   -- Temp du player 2
			   screen:blit(385,110,graviton[playerData[2].temp[1]])
			   screen:blit(415,110,graviton[playerData[2].temp[2]])
			   screen:blit(445,110,graviton[playerData[2].temp[3]])
			   if nPlayer == 4 then
			    -- Temp du player 3
			    screen:blit(5,162,graviton[playerData[3].temp[1]])
			    screen:blit(35,162,graviton[playerData[3].temp[2]])
			    screen:blit(65,162,graviton[playerData[3].temp[3]])
			    -- Temp du player 4
			    screen:blit(385,162,graviton[playerData[4].temp[1]])
			    screen:blit(415,162,graviton[playerData[4].temp[2]])
			    screen:blit(445,162,graviton[playerData[4].temp[3]])
			   end	 
              end	   
 local init = function () --fonction de generation de la map avec animation
               math.randomseed(os.time()) -- Initialisation du generatur de chiffre aleatoire
				pic:drawLine(0,0,pic:width()-1,0,Color.new(255,255,255))
			    pic:drawLine(0,0,0,pic:height()-1,Color.new(255,255,255))
				pic:drawLine(0,pic:height()-1,pic:width()-1,pic:height()-1,Color.new(255,255,255))
				pic:drawLine(pic:width()-1,0,pic:width()-1,pic:height()-1,Color.new(255,255,255))
				play()
               for i=0,7 do -- Initialisation de la matrice des données
			    self[i] = {}
				for j=0,7 do
				 self[i][j] = nil
				end 
			   end		
                -- Puis 48 gravitons (12 par couleur) sont placé aleatoirement 		
                ID = 1	-- ID =correspond à la couleur du graviton 			
                for i=1,64 do
				 find = false
				 while find == false do -- tant que l'on a pas trouvé de place pour placé la boule on effectue la boucle
				  -- Determination aleatoire de coordonées sur la grille
                  x = math.random(0,7) 
                  y = math.random(0,7)
                  if self[x][y] == nil then -- Si la place n'est pas prise par une boule alors on affecte un Replication a cette place 
                   find = true
				   self[x][y] = ID
				   pic:blit(x*30,y*30,graviton[ID]) -- On imprime la boule sur la grille
				   play()
				   break
                  end				  
				 end
				 -- On rafraichi l'ecran
				 screen.flip()
				 screen.waitVblankStart()
				 if ID ~= 4 then
				  ID = ID + 1
				 else
                  ID = 1
                 end				  
                end						
              end  			  
 local tempE = function (v)
                 newTemp = nil
                 newTemp = {}
                if v == 1 then
				 newTemp[1] = playerData[playerTurn].temp[2]
				 newTemp[2] = playerData[playerTurn].temp[3]
				 newTemp[3] = playerData[playerTurn].temp[1]
				else
				 newTemp[1] = playerData[playerTurn].temp[3]
				 newTemp[2] = playerData[playerTurn].temp[1]
				 newTemp[3] = playerData[playerTurn].temp[2]
				end
				playerData[playerTurn].temp = newTemp
               end
 local setLine = function(n) lineID = n end 
 local getLine = function() return lineID end 
 local setSide = function(n) side = n end
 local getSide = function() return side end
 play() 
 init() -- Initialisation de la grille
 reload()
 check()
 -- Renvoi des propriété de manipulation de l'objet
 return {
         play = play,
		 move = move,
		 reload = reload,
		 init = init,
		 check = check,
		 tempE = tempE,
		 setLine = setLine,
		 getLine = getLine,
		 setSide = setSide,
		 getSide = getSide,
		 playerTurnUp = playerTurnUp,
        }
end
