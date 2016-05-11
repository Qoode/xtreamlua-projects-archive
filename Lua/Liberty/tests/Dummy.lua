--- Dummy library that allow to use empty package.
--@file Dummy.lua
--@author Faylixe (felix.voituret@univ-avignon.fr) 

package.path = package.path .. ";../src/?.lua";

local dummy = {}

--- Dummy object allocator.
--@return A new dummy object.
local function newDummy()
	return setmetatable({},dummy);
end

--- Dummy mirror function.
--@param self The object reference.
--@param _ The key index (never used).
--@return A new dummy object.
function dummy.__index(self,_) 
	return newDummy();
end

--- Dummy calling dead end.
--@param self The object reference.
--@param ... Parameters provided to the call.
--@return Nil value.
function dummy.__call(self,...)
	return newDummy();
end

--- Tonumber mapping.
--@param self The object reference.
--@return 42
function dummy.__tonumber(self)
	return 42;
end

--- Tostring mapping
--@param self The object reference.
--@return A dummy string.
function dummy.__tostring(self)
	return "Dummy string";
end

return newDummy();
