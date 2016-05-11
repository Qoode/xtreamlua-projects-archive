--[[
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
MILF (Malware Intelligent Lua Framework) is a framework which can be use
so as to design malware, bot, webspider and all other malware in Lua language.

--% file Parser.lua provide parsing facilities functions
--% author Shadow Programming Council
--% version 1.0
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
]]--

-- Package definition
module("Core.Parser",package.seeall)

_NAME = "MILF.Core.Parser"
_VERSION = "1.0"
			
-- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- Parser sub package, contains tools for parsing data
 			
--% func P.parser.match Return a list of occurence in <b>c<b> for the given pattern <b>p</b>
--% arg string c The content data which be parse
--% arg string p The pattern to match
--% ret table l The list of matched result in <b>c</b>
function match(c,p)
	local i , l = table.insert , {}
	while c:find(p) do
		i(l,c:match(p))
		local _,e = c:find(p)
		c = c:sub(e)
	end
	return l
end
