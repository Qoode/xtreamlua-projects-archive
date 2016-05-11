
package.path = package.path..";C:\\Users\\Shaolan\\Desktop\\Shaolan\\Developpement\\SPC\\MILF\\?.lua"

require "MILF"
require "Web.UA"

local POST_TITLE = "Fion ouvert en masse"
local POST_MSG = "[img]http://goatse.ragingfist.net/hello.jpg[/img]"
local POST_URL = "http://www.nextprog.powa.fr/newthread.php?fid=%d"
local FORUM_ID = {3,5,76,9,7,8,18,19,20,64,65,37,72,73,46,54,38,47,55,39,48,56,40,67,68,69,70,71,49,58,42,59,50,43,51,60,44,52,62,45,53,63,11,12,13,15,16,75}

function save(path,data)
	local f = io.open(path,"w")
	f:write(data)
	f:close()
end

function Post(wb,ID)
	-- Step 1 : get the posting page so as to get the "my_post_key" field	
	wb:go(POST_URL:format(ID))
	save("getpostingpage.html",wb.page)
	local form =	{
						my_post_key = wb.page:match("<input type=\"hidden\" name=\"my_post_key\" value=\"([^\"]+)\">"),
						posthash = wb.page:match("<input type=\"hidden\" name=\"posthash\" value=\"([^\"]+)\">"),
						action = "do_newthread",
						subject = POST_TITLE,
						message_new = POST_MSG,
					}
	wb:post(POST_URL:format(ID).."&processed=1",form)
end

function Flood(wb)
	for _,ID in ipairs(FORUM_ID) do
		print(("Post in %d forum"):format(ID))
		Post(wb,ID)
	end
end

function Bot(login,password)
	local wb = MILF.newSession(Web.UA.make("chrome","windows7"),"cookies.nextprog.txt")
	-- Step 1 : Connection
	local form = { 
					action = "do_login",
					url = "http://www.nextprog.powa.fr/index.php",
					quick_login = "1",
					quick_username = login,
					quick_password = password,
					submit = "Se connecter",
					quick_remember = "yes",
				 }
	--wb:post("http://www.nextprog.powa.fr/member.php",form)
	--save("connection.html",wb.page)
	
	wb:go("http://www.nextprog.powa.fr/index.php")
	print(wb.page)
	--Post(wb,3)
	--save("posting.html",wb.page)
end

Bot("Shadow_S","biroute")
