--=======================================================================================================
--# Main API , contain data structure and core function
--=======================================================================================================

__class__ = {}

-- Allocation of a new object instance
function new(object,...)
	arg.n = nil
	return __class__[object](unpack(arg))
end

-- Make inheritance for a class
function inherit(class,newmethod)
	local finalT = {}
	for i,v in pairs(class) do finalT[i] = v end
	for i,v in pairs(newmethod) do finalT[i] = v end
	return finalT
end

function class(typename)
    return  function(typedef)
                local t,const = {},0
                for i,v in pairs(typedef) do
                    if i ~= "self" then t[i] = v end
                    if i == typename then const = 1 end
                end
                __class__[typename] =   function(...)
                                            setmetatable(typedef.self,{__index = t})
                                            if const then typedef.self[typename](typedef.self,unpack(arg)) end
                                            return typedef.self
                                        end
                _G[typename] = typename
            end
end

--------------------------------------------------------------------------------------------------------
-- String class definition and method (use for execution of input)
--------------------------------------------------------------------------------------------------------

String , _str = "String" , {} -- Constant string for allocation and Table for index index method
--Initialisation function
function __class__.String(s,c)
	local mt = {__index = _str}
	function mt:__call(v) if v == nil then return self.value else self.value = v end end
	function mt.__add(a,b)
		local v
		if type(b) == "string" then v = a.value..b
		elseif type(a) == "string" then v = a..b.value
		else v = a.value..b.value end
		return __class__.String(v) 
	end
	return setmetatable({type=String,value = s or "",color = c or pge.gfx.createcolor(255,255,255)},mt)
end

-- Execution value of a string as Lua code 
function _str:execute()
	-- Write String value into temp file :
	local file = io.open("data/temp.lua","w")
	file:write(self.value)
	file:close()
	-- Execute temp file into coroutine and return execution status :
	__exec__ = coroutine.create(function() dofile("data/temp.lua") end)
	__try__,__error__ = coroutine.resume(__exec__)
	if not(__try__) then return __error__
	else return true end
end

-- Basic string manipulation function
function _str:len() return string.len(self.value) end
function _str:sub(s,e) return string.sub(self.value,s,e or nil) end
function _str:getColor() return self.color end
function _str:setColor(c) self.color = c end

function _str:split(s)
	s = s or " "
	local arg,i,prec,step = {}, 0 , s,string.len(s) - 1
	for c = 0,string.len(self.value) do
		local charSplit = string.sub(self.value,c,c+step) 
		if charSplit == s and prec ~= s then table.insert(arg,string.sub(self.value,i,c-1)) i = c+1+step
		elseif charSplit == s and prec == s then i = c+1+step end
		prec = charSplit
	end
	if not(prec == s) then table.insert(arg,string.sub(self.value,i)) end
	return arg
end


--------------------------------------------------------------------------------------------------------
-- List class definition and method
--------------------------------------------------------------------------------------------------------
List,_list = "List",{}

function __class__.List(...)
	local mt = {__index = _list}
	function mt:__call(i) return self.content[i] end
	function mt:__add(...)
		if arg.n == 1 and type(arg[1]) == "table" and arg[1].type == List then return __class__.List(unpack(self.content),unpack(arg[1].content))
		else for i,v in ipairs(arg) do table.insert(self.content,v) end end
	end
	return setmetatable({type = List,content = {unpack(arg)}},mt)
end

function _list:size() return table.getn(self.content) end
function _list:push_back(e) table.insert(self.content,e) end
function _list:push_front(e) table.insert(self.content,1,e) end
function _list:pop_back() return table.remove(self.content) end
function _list:pop_front() return table.remove(self.content,1) end
function _list:exist(e) 
	for i,v in ipairs(self.content) do if v == e then return true end end
	return false 
end

--------------------------------------------------------------------------------------------------------
-- Tuple class definition and method
--------------------------------------------------------------------------------------------------------
Tuple,_tuple = "Tuple" , {}

function __class__.Tuple(...)
	local mt = {__index = _tuple}
	function mt:__call(i) return self.content[i] end
	return setmetatable(
	{type = Tuple,size = arg.n,
	content = setmetatable( {unpack(arg)} , {__newindex = function(t,key,value) 
							 		error("Tuples object can not be rewriting") 
							      end})
 	},mt)
end

function _tuple:size() return self.size end

--------------------------------------------------------------------------------------------------------
-- Iterator class definition and method
--------------------------------------------------------------------------------------------------------
Iterator , _it = "Iterator",{}

function __class__.Iterator(obj)
	local mt = {}
	function mt:__call() return _it[self.typeit](self) end 
	return setmetatable({type=Iterator,typeit=obj.type,obj = obj},mt)
end

function _it.String(s) 
	local function iter(s,var)
		var = var + 1
		if var == string.len(s) + 1 then return end
		return var,string.sub(s,var,var)
	end
	return iter,s.obj.value,0
end
function _it.List(l) 
	local function iter(l,var)
		var = var + 1
		if var == table.getn(l) + 1 then return end
		return var,l[var]
	end
	return iter,l.obj.content,0
end

function _it.Tuple(t) return _it.List(t) end



