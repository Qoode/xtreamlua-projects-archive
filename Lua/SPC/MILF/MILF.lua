--[[
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
MILF (Malware Intelligent Lua Framework) is a framework which can be use
so as to design malware, bot, webspider and all other malware in Lua language.

--% file MILF.lua Main entry for the framework
--% author Shadow Programming Council
--% version 1.0
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::]]--
-- Call dependencies

module("MILF",package.seeall)

_NAME = "MILF"
_VERSION = "1.0"

local Object = require "Core.Object"
local Parser = require "Core.Parser"
local Session = require "Web.Session"

-- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- Main package function

--% func MILF.newSession Init a new session object
--% ret object session -
function newSession(ua,cookiepath)
	local o = Object.clone(Session.MILF_SESSION_OBJECT)
	o.USER_AGENT = ua or ""
	o.COOKIE = cookiepath or ""
	return setmetatable(o,{__index = Session.MILF_SESSION_META})
end

--% func MILF.getLink Return all link of the given page
--% arg string page The page 
--% arg string label 
--% ret table l the list of all link match
function getLink(page,label)
	local pattern = "<a href=\"([^\"]+)\">"..(label or "")
	return Parser.match(page,pattern)
end



