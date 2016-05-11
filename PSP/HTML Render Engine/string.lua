function string.compression(self,c)
	local c = c or " "
	local flag = 0
	for i=1,self:len() do
		if self:sub(i,i) == c then
			if flag == 0 then flag = 1
			else self = self:sub(0,i-1)..self:sub(i+1) end
		else flag = 0 end
	end
	return self
end

function string.remove(self,c)
	local c = c or " "
	for i=1,self:len() do
		if self:sub(i,i) == c then self = self:sub(0,i-1)..self:sub(i+1) end
	end
	return self
end

function string.split(self,c)
	local s,t,c = 0,{},c or " "
	for p=0,self:len() do
		if self:sub(p,p) == c then
			table.insert(t,self:sub(s,p-1))
			s = p+1
		end
	end
	table.insert(t,self:sub(s))
	return t
end