
package.path = package.path..";C:\\Users\\Shaolan\\Desktop\\Shaolan\\Developpement\\SPC\\MILF\\?.lua"

require "MILF"
require "Web.UA" 


function checkTest(wb,link)
	-- Step 1 : check for application test link
	wb:go("http://appvip.com/"..link)
	local nextLink = MILF.getLink(wb.page,"Testez & gagnez")[1]
	if not(nextLink) then return end
	-- Step 2 : Get the confirmation link and follow it
	wb:go("http://appvip.com/"..nextLink)
	local confirmLink = MILF.getLink(wb.page,"Participer � l'offre")[1]
	if not(confirmLink) then return end
	wb:go("http://appvip.com/"..confirmLink)
	wb:sendMail("felix.voituret@gmail.com","New application's test confirm","The following application were confirm : http://appvip.com/"..nextLink)
	print("Link confirm : "..link)
end

function searchOpenTest(wb)
	local link = MILF.getLink(wb.page,"Tester")
	for _,l in ipairs(link) do
		 checkTest(wb,l) 
	end
end

function Bot(LOGIN,PASSWORD)
	local wb = MILF.newSession(Web.UA.make("chrome","windows7"),"cookie.appvip.com.txt")
	wb:go("http://appvip.com/index.php")
	wb:post("http://appvip.com/index.php",{mail_log=LOGIN,mdp_log=PASSWORD,connect="GO"})
	searchOpenTest(wb)
end

Bot("AppVip_Mail","AppVip_Pwd")