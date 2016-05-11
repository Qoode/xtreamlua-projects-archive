--[[
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
MILF (Malware Intelligent Lua Framework) is a framework which can be use
so as to design malware, bot, webspider and all other malware in Lua language.

--% file Session.lua main class for web intelligent navigation
--% author Shadow Programming Council
--% version 1.0
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
]]--

require "curl"

-- Package definition
module("Web.Session",package.seeall)
_NAME = "MILF.Web.Session"
_VERSION = "1.0"

-- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- MILF SESSION class definition

--% class Session web browsing session class
MILF_SESSION_OBJECT = 	{

									--% attribute string user_agent the user_agent used for browsing
									USER_AGENT = "",
									--% attribute string url the current page URL
									URL = "",
									--% attribute string cookies the path of the cookies file
									COOKIE = "",
									--% attribute string page the page source code
									page = "",
								}
								
MILF_SESSION_META = {}

--% method go Execute a GET request into our session
--% arg string link The link to the GET request 
function MILF_SESSION_META.go(this,link)
		local c = curl.easy_init()
		this.page = ""
		c:setopt(curl.OPT_URL,link)
		c:setopt(curl.OPT_REFERER,this.URL)
		c:setopt(curl.OPT_COOKIEFILE,this.COOKIE)
		c:setopt(curl.OPT_WRITEFUNCTION,function(s,l) this.page = this.page..tostring(s) return l,nil end)
		if c:perform() then
			this.URL = link
		end
end			

--% method post Exeucte a POST request into our session
--% arg string link The link to the POST request
--% arg table formData The POST data to send
function MILF_SESSION_META.post(this,link,formData)
	local c = curl.easy_init()
	this.page = ""
	c:setopt(curl.OPT_URL,link)
	c:setopt(curl.OPT_REFERER,this.URL)
	c:setopt(curl.OPT_COOKIEJAR,this.COOKIE)
	c:setopt(curl.OPT_WRITEFUNCTION,function(s,l) this.page = this.page..tostring(s) return l,nil end)
	local post = ""
	for k,v in pairs(formData) do post = post..k.."="..curl.escape(v).."&" end
	c:setopt(curl.OPT_POSTFIELDS,post)
	if c:perform() then
		this.URL = link
	end
end


--% method MILF.sendMail send a mail via MILF smtp
--% arg string to The target
--% arg string subject The subject 
--% arg string message The message body
function MILF_SESSION_META.sendMail(this,to,subject,message)
	local mail = {to = to, subject = subject, message = message}
	mail["MILFforTheWin"] = "true"
	this:post("http://www.xtreamlua.com/MILF/smtp.php",mail)
end