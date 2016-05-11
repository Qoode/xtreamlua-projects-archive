require "data"
require "tag"

function dumpTable(v,file)
	local f = io.open(file,"w")
	for i,s in pairs(v) do
		f:write(i.." -> "..s.."\r\n")
	end
	f:close()
end

html = {}

---------------------------------------------------------------------------------------------------
-- Partition une chaine de caractere en plusieurs chaine en fonction de sa longeur
function html.partitionString(s,size,w)
	local t,buffer = {},""
	local word = s:split()
	while #word ~= 0 do
		while (((buffer:len()+0.5)+word[1]:len())*(size/2)) < w do -- Bug , try to index field '?' a nil value
			buffer = buffer.." "..word[1]
			table.remove(word,1)
			if #word == 0 then break end
		end
		table.insert(t,buffer)
		buffer = ""
	end
	return t
end


---------------------------------------------------------------------------------------------------
-- Active un filtre pour une balise donnée
function html.applyFilter(f,v,p)
	if tag_type(v) == 1 then
		for key,value in pairs(tag[v].f) do f[key]:push(value) end
	else
		if tag[v].a then
			for key,value in pairs(tag[v].a) do if p[value.name] then f[key]:push(value.get(p[value.name])) end end
		end
	end
	return f
end

---------------------------------------------------------------------------------------------------
-- Desactive le un filtre pour une balise donnée
function html.disapplyFilter(f,v,p)
	if tag_type(v) == 1 then 
		for key,value in pairs(tag[v].f) do f[key]:pop() end
	else
		if tag[v].a then
			for key,value in pairs(tag[v].a) do if p[value.name] then f[key]:pop() end end
		end
	end
	return f
end

---------------------------------------------------------------------------------------------------
-- Retourne une taille en fonction du filtre courant
function html.getSize(f) end

---------------------------------------------------------------------------------------------------
-- Retourne une font en fonction du filtre courant
function html.getFont(f)
	local ttf
	if f.b:gettop() == 1 and f.i:gettop() == 1 then ttf = pge.font.load(f.font:gettop().."z.ttf",f.size:gettop())
	elseif f.b:gettop() == 1 then ttf = pge.font.load(f.font:gettop().."b.ttf",f.size:gettop())
	elseif f.i:gettop() == 1 then ttf = pge.font.load(f.font:gettop().."i.ttf",f.size:gettop())
	else ttf = pge.font.load(f.font:gettop()..".ttf",f.size:gettop()) end
	return ttf
end


---------------------------------------------------------------------------------------------------
-- Retourne une image formaté par le filtre courant
function html.getImage(p,f)
	local src = p.src:match("[%a%d%.]+")
	local buffer = pge.texture.load(src)
	if not(buffer) then error(src.." introuvable") end
	buffer:activate()
	buffer:draw(f.x:gettop(),f.y:gettop())
	f.x:push(0)
	f.y:push(f.y:gettop() + buffer:width())
	return f
end

---------------------------------------------------------------------------------------------------
function html.drawBuffer(buffer,f)
	-- Chargement de la police TTF
	local ttf = html.getFont(f)
	--  Affichage des données sur la texture
	for i,v in ipairs(buffer) do
		ttf:activate()
		ttf:print(f.x:gettop(),f.y:gettop(),f.color:gettop(),v)
		--# Underline 
		if f.u:gettop() == 1 then
			local yl = f.y:gettop() + (i*f.size:gettop())+1
			pge.gfx.drawline(f.x:gettop(),yl,f.x:gettop() + (v:len()*(f.size:gettop()/2)),yl,f.color:gettop())
		end
		-- Ajustement des coordonnées d'affichage
		if (f.br:gettop() ~= 0) then 
			f.x:push(0) 
			f.y:push(f.y:gettop() + (f.size:gettop()*f.br:gettop()))
		elseif #buffer > 1 and i ~= #buffer then 
			f.x:push(0) 
			f.y:push(f.y:gettop() + f.size:gettop())
		else 
			f.x:push(f.x:gettop() + ((v:len()+0.5)*(f.size:gettop()/2))) end
	end
	return f
end
			
---------------------------------------------------------------------------------------------------
-- Generation du rendu 
function html.generateRender(tree)
	local f = io.open("dump.log","w")
    -- Création d'un filtre par default
    local filter =  {
						x = newStack(0),
						y = newStack(0),
						size = newStack(10),
						color = newStack(pge.gfx.createcolor(0,0,0)),
						bgcolor = newStack(pge.gfx.createcolor(255,255,255)),
						u = newStack(0),
						i = newStack(0),
						b = newStack(0),
						w = newStack(480),
						h = newStack(272),
						br = newStack(0),
						font = newStack("Font/verdana")
				    }
	-- Stockage de la reference de l'arbre courant 
    local current = tree
	-- Création de la surface de rendu
	local layer = pge.texture.create(480,272)
	layer:tovram()
	layer:settarget()
	pge.gfx.clearscreen(pge.gfx.createcolor(255,255,255))
	-- Boucle de traitement 
    while current do 
		f:write(current.value.."\r\n")
		-- Si on est sur un noeud terminal (donnée textuelle)
        if current.type == 1 then
			-- Decoupage des données en fonction de la longeur
			if filter.x:gettop() + ((current.value:len()+0.5)*(filter.size:gettop()/2)) > filter.w:gettop() then 
				buffer = html.partitionString(current.value,filter.size:gettop(),filter.w:gettop()) 
			else buffer = {current.value} end
			-- Application du rendu courant sur la surface
			filter = html.drawBuffer(buffer,filter)
			-- Ensuite on remonte dans l'arbre 
			current = current.parent
			if not(current) then break end
			-- On supprime le noeud visité
			table.remove(current.child,1)
		-- Sinon (balise)
		else  
			-- Si le noeud a été évalué 
			if #current.child == 0 then
				-- Traitement des balise independante
				if tag_alone(current.value) then
					if current.value:find("br") then 
						filter.x:push(0)
						filter.y:push(filter.y:gettop() + (filter.size:gettop()))
					elseif current.value:find("img") then filter = html.getImage(current.property,filter)
					end
				else
					--  On retire le filtre courant
					filter = html.disapplyFilter(filter,current.value,current.property)
				end
				current = current.parent
				if not(current) then break end
				table.remove(current.child,1)
			else
				-- Sinon on applique la balise au filtre courant 
				if not(current.visited) then 
					filter = html.applyFilter(filter,current.value,current.property) 
					current.visited = 1
				end
				-- Et on descend dans l'arbre 
				current = current.child[1]
			end
		end
	end
	pge.gfx.rendertoscreen()
	layer:toram()
	return layer
end


