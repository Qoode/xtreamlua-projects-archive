
local standardPattern = "<([%a%d=%-#\"'/ ]+)>"
local openTagPattern = "<([%a%d=%-#\"']+)>"
local endTagPattern = "</(%a)>"


function String(s)
	local DOM = {}
	local current = DOM
	local buffer = s
	while buffer ~= "" do
		if buffer:find(standardPattern) then
			-- Ouverture d'un noeud
			if buffer:find(openTagPattern) then
				local data = buffer:match(openTagPattern)
				-- Actualisation du buffer
				buffer = buffer:gsub(openTagPattern,"",1)
			-- Fermeture d'un noeud
			elseif buffer:find(endTagPattern) then
				-- Actualisation du buffer
				buffer = buffer:gsub(endTagPattern,"",1)
			end
		else
		end
	end	
end