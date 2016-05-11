package.path = package.path..";C:\\Users\\Shaolan\\Desktop\\Shaolan\\Developpement\\SPC\\MILF\\?.lua"

require "MILF"
require "Web.UA"


function Bot(LOGIN,PASSWORD)
	local wb = MILF.newSession(Web.UA.make("chrome","windows7"),"cookies.moneymillionaire.fr.txt")
	-- First step, visit home page
	wb:go("https://www.moneymillionnaire.fr/index.php")
	print("INDEX :")
	print("---------------------------------")
	print(wb.page)
	-- Second Step, login
	print("---------------------------------")
	local form = { login_username=LOGIN , login_password=PASSWORD , redirect="redirect" , login_btn="",remember="false"}
	wb:post("https://www.moneymillionnaire.fr/login.php",form)
	print(wb.page)
end

Bot("Shaolan","biroute")