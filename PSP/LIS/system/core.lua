--=======================================================================================================
--# Main API ,  core function
--=======================================================================================================
require("system/class")
require("system/output")
require("system/input")

__bin__ = {}

--// Path Search for binary load
__bin__.currentDir = pge.dir.open("bin/")
__bin__.list = __bin__.currentDir:read()
__bin__.currentDir:close()
for i=1,table.getn(__bin__.list) do dofile("bin/"..__bin__.list[i].name) end

--// Execution of given binary
function execute(input)
	local arg = new(String)
	for i,v in pairs(input:split("\r\n")) do arg = arg + v end
	arg = arg:split()
	local name = arg[1]
	table.remove(arg,1)
	__bin__[name](unpack(arg))
end

function __bin__.exist(b)
	for i,v in pairs(__bin__) do
		if i == b then return true end
	end
	return false
end

function __bin__.exit() pge.exit() end
function __bin__.echo(s) print(s) end


