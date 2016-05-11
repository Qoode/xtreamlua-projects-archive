--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- LOT : Lua Obfuscator Tools
-- Author : Shaolan (http://shaolan.net)
--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- File manipulation function

-- Open the given file and return a handle for it 
function _open(path,mode)
	local handle = io.open(path,mode)
	if handle then return handle 
	else error(string.format("Canno't open %s",path)) end
end

-- Load the given file and return it as string value
function _load(path)
	local f = _open(path,"r")
	s = f:read("*a")
	f:close()
	return s
end

-- Save the given string into the given file
function _save(path,script)
	local f = _open(path,"w")
	f:write(script)
	f:close()
end

--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- Tree builder functions

-- Lua's grammar production rules 
production = 	{
					var = 		{ regex = 	{ 
												"|name|" ,
												"|prefixexp|[|exp|]",
												"|prefixexp|.|name|" 
											} 
								}
					chunk = 	{ regex = "(|stat| ';'? )*" }
					block = 	{ regex = "[chunk]" }
					stat =		{ regex = 	{
												"do [block] end",
												"(varlist1] = [explist1] ", 
												"while [exp] do [block] end",
												"repeat [block] until [exp]",
												"if [exp] then [block] (elseif [exp] then [block])* (else [block])? end",
												"return [explist1]",
												"break",
												"for [name] = [exp] , [exp] (, [exp])? do [block] end",
												"for [namelist] in [explist1] do [block] end",
												"[functioncall]",
												"local [namelist] (= [explist1])?",
												"function [funcname] [funcbody]",
												"local function [name] [funcbody]"
											}
								}
					varlist1 = 	{ regex = "[var] (',' [var])*" }
					explist1 =	{ regex = "[exp] (',' [exp])*" }
					namelist = 	{ regex = "Name (, Name)*" }
					exp = 		{ regex = 	{
												"[prefixexp]",
												"nil",
												"false",
												"true",
												"",
												"[String]",
												"[function]",
												"[tableconstructor"],
												"...",
												"[exp] [binop] [exp]",
												"[unop] [exp]"
											}
								}
					prefixexp =	 { regex = 	{
												"[var]",
												"[functioncall]",
												"'('[exp]')'"
											}
					tableconstructor = 	{ regex = "{ [fieldlist] }"}
					fieldlist = { regex = "[field] ([fieldsep] [field])* [fieldsep]?" }
					field 	  = { regex = 	{
												"'[' [exp] ']' = [exp]",
												"[name] = [exp]",
												"[exp]"
											}
								}
					fieldsep =	{ regex  =	{
												",",
												";"
											}
								}			
					functioncall = 	{ regex = {
												"[prefixexp] [args]",
												"[prefixexp] ':' [name] [args]"
											  }
									}
					args =		{ regex =	{
												"'(' [explist1]* ')'",
												"[tableconstructor]",
												"[String]",
											}
								}
					funcname = 	{ regex = "[name](.[name])* (:[name])?" }
					funcbody = 	{ regex = "'(' [parlist1]? ')' [block] end" }
					parlist1 = 	{ regex =	{
												"[namelist] (,...)?",
												"..."
											}
								}
				}	

-- Node class methods
local NodeMethod = {}
function NodeMethod.append(this,e) table.insert(this.child,e) end


-- Build and return a node object
function newNode(key) return setmetatable({parent = nil , child = {} , key = key},{__index = NodeMethod}) end

-- Build and return a tree from a given script
function _build(script)
	for key,matcher in pairs(production) do
		local s,e = script:find(matcher.regex)
		if s then
			local node = newNode(key,matcher.buildChild(s:sub(s,e)))
			local child , script = _build(s:sub(0,s-1)..s:sub(e+1))
			node:append(child)
			return node , script
		end
	end
	return nil , script
end

-- Parse and return a new script for the given tree
function _parse(root,level)
	local script = ""
	for _ , child in pairs(root.child) do
		script = script .. production[root[key]]
		script = script .. _parse(child,level+1)
	end
	return script
end

--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- Obfuscation function

-- Obsfucate the given tree
function _obsfucate(tree)
	-- First step : Obsfucation of True and False value
	-- Second step : build a function dispatcher 
	-- Third step : Start main obsfucation, rename variable
	-- Fourth step : replace function name by new name or dispatcher call randomly
	return tree
end

--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- Entry point 

local HELP = 	--[[
					Usage : lot source [target]
				]]--

if (arg.n and arg.n ~= 0) then	
	-- Parse argument
	local source , target = tostring(arg[1]) , tostring(arg[2]) 	
	-- Obsfuscation steps
	local script = _load(source)
	local tree = _build(script)
	tree = _obsfuscate(tree)
	local obsScript = _parse(tree)
	-- Output steps
	if target ~= "nil" then _save(target,obsScript)
	else print(obsScript) end
else print(HELP) end