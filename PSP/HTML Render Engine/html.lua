dofile("string.lua")

function newNode(type,value)
	return {child = {},property = {},type = type,value = value}
end

function printTree(tree,layer,f)
	local buffer = "" 
	for i=0,layer do buffer = buffer.."\t" end
	buffer = buffer..(tree.value or "nil").."|"
	f:write(buffer.."\n")
	for i,node in ipairs(tree.child) do
		printTree(node,layer+1,f)
	end
end

function parseHTML(path)
	-- Création d'un liste de balise 
	local list = newList()
	-- Initialisation de notre arbre DOM
	local tree = {child = {},parent = nil}
	-- Initialise l'arbre courant comme la racin de l'arbre DOM
	local current = tree
	-- Ouverture du fichier en lecteur
	local f = io.open(path,"r")
	-- Pour chaque lignes du fichier 
	for l in f:lines() do
		while l ~= "" do
			l = l:compression():remove("\t"):remove("\r"):remove("\n")
			regex = "<[%a%d;%.:=%-#\"'/ ]+>"
			s,e = l:find(regex) 
			-- Si on trouve un balise (peut importe le type)
			if s then
				-- Si on trouve du texte avant la balise
				if s ~= 1 then
				    if l:sub(0,s-1):remove():remove("\t") ~= "" then
						local n = newNode(1,l:sub(0,s-1))
						n.parent = current
						table.insert(current.child,n)
					end
					l = l:sub(s)
				end
				-- On regarde le type de la balise
				regex = "<[%a%d;%.:=%-#\\\"' /]+>"
				s,e = l:find(regex)
				if s and not(l:sub(s,e):find("</")) then -- Si la balise est ouvrante ou independante 
					balise = newNode(0,l:sub(s+1,e-1)) -- on recupere la balise
					balise.parent = current
					-- Traitement des attributs
					local word = balise.value:split()
					for _,item in ipairs(word) do
						if item:find("=") then
						    p = item:split("=")
							balise.property[p[1]:lower()] = p[2]
						end
					end
					balise.value = word[1]
					table.insert(current.child,balise)
					-- Distinction entre balise ouvrante et indépendante
					if not(l:remove():find("/>")) and not(tag_alone(balise.value)) then 
						list:push(balise.value)
						current = balise 
					end
					l = l:sub(0,s-1)..l:sub(e+1) -- on enleve la balise de la ligne
				else -- Sinon (cas de la balise fermante)
				-- ########### Probleme de fermeture de branche avec balise de fermeture sur la même ligne ######################
					s = l:match("</([%a%d]+)>")
					if s then
						local i = list:find(s)
						-- Si la balise a deja etait ouverte alors on peux remonter
						if i then 
							local e = #list+1
							while e ~= i do 
								current = current.parent
								if not(current) then break end 
								e = e - 1
								list:remove(e)
							end				
						end
						s,e = l:find("</[%a%d]+>")
						l = l:sub(0,s-1)..l:sub(e+1) -- on enleve la balise du buffer
					end
				end
			else -- Sinon (texte uniquement)
				local n = newNode(1,l)
				n.parent = current
				table.insert(current.child,n)
				l = ""
			end
		end
	end
	f:close()
	return tree
end
