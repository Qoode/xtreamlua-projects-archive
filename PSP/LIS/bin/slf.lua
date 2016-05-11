slf = {}

function slf.checkDependancies(t)
	local d = {}
	for i,v in ipairs(t) do if not(table.exist(__reg__,v)) then table.insert(d,v) end end
	if table.getn(d) ~= 0 then
		print("Les dependances suivantes sont requis :")
		for i,v in ipairs(d) do print(v) end
		for i,v in ipairs(d) do slf.install(v) end
	end
end

function slf.getDependancies(f)
	local t = {}
	for i in f:lines() do table.insert(t,i) end
	return t
end

function slf.install(s)
	pge.net.getfile("http://pyla-dev.net.slf/get.php?mode=install&name="..s,s..".slf")
	local package = pge.zip.open(s..".slf")
	package:extract()
	dofile(s.."/setup.lua")
end

slf.search = function(s) end

function __bin__.slf(...)
	local method,name = arg[1],arg[2]
	slf.connect()
	slf[method](name or nil)
end
