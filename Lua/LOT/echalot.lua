--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- EchaLOT
-- Author : Shaolan (http://shaolan.net)
--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- File manipulation function

-- Open the given file and return a handle for it
function _open(path,mode)
	local handle = io.open(path,mode)
	if handle then return handle
	else error(string.format("Cannot open %s",path)) end
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
-- AST Node class

_ASTNode = {}

function _ASTNode.getLeftChild(self) return self.leftChild end
function _ASTNode.getRightChild(self) return self.rightChild end
function _ASTNode.visit(self,v) return v.visit(self) end

function newASTNode(l,r) return setmetatable( { leftChild = l , rightChild = r } , { __index = _ASTNode } ) end
