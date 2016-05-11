--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--
--



local DEFAULT_STYLE = "style.css"
local DEFAULT_OUTPUT = "doc.html"

local DEFAULT_HEADER = --[[
							<html>
								<head>
									<title>%s</title>
									<link rel="stylesheet" type="text/css" href="%s" />
									<script type="text/javascript">
										var currentLayer = "home";
										function set(layer){
											document.getElementById(currentLayer).style.display = "none";
											document.getElementById(layer).style.display = "block";
											currentLayer = layer;
										}
									</script>
								</head>
								<body>
									%s
								</body>
							</html>
						]]--
-------------------------------------------------------------------------------------------------
-- POO section

local __class = {}
-- Object allocator
function new(template,...)  return __class[template](unpack(arg)) end
-- Class register
function register(name,f) __class[name] , _G[name] = f , name end


register("Element",	function(n,t,d,a,arg) return {name = n,type = t, description = d, author = a, arg = arg} end)


-------------------------------------------------------------------------------------------------
-- Generator module, handle document generation

local generator = {}

function generator.header(header,title,style,body) return header:format(title,style,body) end
function generator.body() end


-------------------------------------------------------------------------------------------------
-- Parser module, handle script parsing

local p = {}

local regex = 	{
					func = "function ([%w_][%w%d_]*)%(",
					comment = "--%%",
				}

function p.getAuthor(this)
	local a = this.fileAuthor
	if this.currentAuthor then a = this.currentAuthor ; this.currentAuthor = nil end
	return a
end

function p.func(this,l) this.element.function[l:match(regex.func)] = new(Element,l:match(regex.func),"func",this:getDescription(),this:getAuthor(),nil) end
function p.class(this,l) end
function p.method(this,l) end
function p.comment(this,l) end

-- Parse the given line
function p.parseLine(this,line)
	if this.required then this[this.required](this,l)
	else for k, exp in pairs(regex) do if line:find(regex) then this:parse(k,line) end end end
end

-- Parse file line by line
function p.parseFile(this,path)
	-- Handle file openning
	local f = io.open(path,"r")
	if not(f) then error("Cannot open "..path) end
	-- Linear parsing
	for l in f:lines() do this:parseLine(l:compress()) end
end

-- Start global parsing
function p.execute(this) for _,f in pairs(this.file) do this:parse(f) end end

register("Parser",function(f) return setmetatable({file=f},{__index=p}) end)

-------------------------------------------------------------------------------------------------
--
-- Main function : generate the document for the given parameter


parser = new(Parser,config)
parser:execute()

