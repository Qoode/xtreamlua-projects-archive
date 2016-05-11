http = require "socket.http"

package.path = package.path..";C:\\Users\\Shaolan\\Desktop\\Shaolan\\Developpement\\SPC\\MILF\\?.lua"

require "Core.Parser"

local query = "http://www.google.com/search?q=site:megaupload.com+KB&start=%d"
local pattern = { "<cite>(www.megaupload.com/[^<]+)</cite>","<cite>(megaupload.com/[^<]+)</cite>" }


function Get(f,start)
	a = http.request(query:format(start))
	for _,list in ipairs({Core.Parser.match(a,pattern[1]),Core.Parser.match(a,pattern[2])}) do
		for _,link in ipairs(list) do
			f:write(link.."\n")
		end
	end
end

function spider()
	local f = io.open("LINKKB.txt","w")
	for i = 0,36800 do
		print(tostring((i*100) / 36800).."% done")
		Get(f,i*10)
	end
	f:close()
end

spider()



