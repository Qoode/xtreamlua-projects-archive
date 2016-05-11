--[[
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
MILF (Malware Intelligent Lua Framework) is a framework which can be use
so as to design malware, bot, webspider and all other malware in Lua language.

--% file Object.lua provide object facilities function
--% author Shadow Programming Council 
--% version 1.0
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
]]--

-- Package definition
module("Core.Object",package.seeall)
_NAME = "MILF.Core.Object"
_VERSION = "1.0"
			
-- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- Object handle function

--% func clone Return an empty object for the given class
--% arg table class The class which be clone
--% ret table o the new object
function clone(class)
	local o = {}
	for name, attribute in pairs(class) do
		if type(attribute) == "table" then o[name] = clone(attribute)
		else o[name] = attribute end
	end
	return o
end