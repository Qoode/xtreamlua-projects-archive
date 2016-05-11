-- Ls function By Elesthor

__system__.path = pge.dir.getcwd()
__system__.mainpath = pge.dir.getcwd()
local tmpdir = pge.dir.open(__system__.path)
__system__.filelist = tmpdir:read()
tmpdir:close()

function __bin__.ls(...)
	local dir = pge.dir.open(arg[1] or __system__.path)
	__system__.filelist = dir:read()
	for i,v in pairs(dir:read()) do
			local e = new(String,"  "..v.name)
			if v.dir then e:setColor(pge.gfx.createcolor(100,100,255)) 
			else e:setColor(pge.gfx.createcolor(200,200,0)) end
			print(e)
	end
	dir:close()
end 

function __bin__.pwd() print(new(String,__system__.path,pge.gfx.createcolor(100,100,255))) end

function __bin__.cp(...) print("cp non disponible") end

function __bin__.rm(...) print("rm non disponible") end

function __bin__.cd(path) 
	if path == nil then __system__.path = __system__.mainpath
	elseif string.sub(path,0,3) == "ms0" then __system__.path = path
	else __system__.path = __system__.path.."/"..path end
end

function __bin__.touch(path)
	local tmp = io.open(path,"w")
	tmp:close()
end

function __bin__.cat(path)
	local tmp = io.open(path,"r")
	for l in tmp:lines() do print(l) end
	tmp:close()
end
