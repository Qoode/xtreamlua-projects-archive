stack = {}

function stack.push(self,v) table.insert(self,v) end
function stack.pop(self) table.remove(self) end
function stack.gettop(self) return self[#self] end
function newStack(...) return setmetatable({unpack(arg)},{__index=stack}) end

list = {}

function list.push(self,v) table.insert(self,v) end
function list.remove(self,i) table.remove(self,i) end
function list.find(self,v)
	last = nil
	for i,n in ipairs(self) do
		if n == v then last = i end
	end
	return last
end

function newList() return setmetatable({},{__index=list}) end