--[[
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
MILF (Malware Intelligent Lua Framework) is a framework which can be use
so as to design malware, bot, webspider and all other malware in Lua language.

--% file UA.lua list and generate User Agent for session
--% author Shadow Programming Council
--% version 1.0
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
]]--

module("Web.UA",package.seeall)

-- Package definition
_NAME = "MILF.Web.UA"
_VERSION = "1.0"
			
--% const table browser Webbrowser code list			
local browser = {
					--% const string browser.firefox3.6 -> Mozilla/5.0 (%s rv:1.9.2) Gecko/20100115 Firefox/3.6
					["firefox3.6"] = "Mozilla/5.0 (%s rv:1.9.2) Gecko/20100115 Firefox/3.6",
					--% const string browser.chrome -> Mozilla/5.0 (%s rv:1.9.2) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.2.149.29 Safari/525.13
					["chrome"] = "Mozilla/5.0 (%s rv:1.9.2) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.2.149.29 Safari/525.13",
				}

--% const table system OS code list
local system = {
					--% const string system.windows7 -> Windows; U; Windows NT 6.1; fr;
					["windows7"] = "Windows; U; Windows NT 6.1; fr;",
					--% const string system.windowsXP -> Windows; U; Windows NT 5.1; fr;
					["windowsXP"] = "Windows; U; Windows NT 5.1; fr;",
			   }

--% func UA.make Build an user agent for the given OS and browser
--% arg string b Browser used (ex : firefox3.6)
--% arg string s OS used (ex : windows7)
--% ret string ua The generate user agent			   
function make(b,s) return browser[b]:format(system[s]) end		