--- Set of functions that will be used to handle object oriented model through the code.
--@file core/class.lua
--@author Faylixe (felix.voituret@univ-avignon.fr)

--- Class container.
local _C = {}

--- Register the given class with the given name. 
--@param classname The name of the class to register.
--@param class The class to register with the given name.
function registerClass(classname,class) 
	_C[classname] = class;
	_G[classname] = classname;
end

--- Instanciate an object belonging to the given classname.
--@param classname The name of the class to use to instanciate the object.
--@param ... List of argument that will be tramsitted to the class constructor.
--@return A new instance of the given class.
function new(classname,...)
	local class = _C[classname];
	assert(class,"Class "..classname.."not found");
	assert(class.initialize,"Cannot instanciate "..classname.." object !");
	local instance = setmetatable({},{__index = class});
	instance:initialize(unpack(arg));
	return instance;
end
