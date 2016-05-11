--======================================================================
--- HandyCurl class overload curl object so as to make it more handy ;)
--@author Félix Voituret (felix.voituret@gmail.com)

local http = require "luacurl"
local handyMethod = {}

--- HandyCurl object constructor
--@param URL target url
--@return reference to the object 
function handyMethod.init(this,URL)
	this.c = curl.new()
	this.buffer = ""
	this.c:setopt(curl.OPT_URL,URL)
	this.c:setopt(curl.OPT_SSL_VERIFYPEER,false)
	this.c:setopt(curl.OPT_WRITEFUNCTION,function(u,s) this.buffer = this.buffer..s; return #s,nil end)
	this.c:setopt(curl.OPT_VERBOSE,true)
	return this
end

--- Set a POST query and execute it 
--@param p POST value of the query
--@return result of the query
function handyMethod.post(this,p)
	this.c:setopt(curl.OPT_POSTFIELDS,p)
	this.c:perform()
	return this.buffer
end

--- Set a PUT query and execute it 
--@param p POST value of the query
--@return result of the query
function handyMethod.put(this,p)
	this.c:setopt(curl.OPT_UPLOAD,true)
	this.c:setopt(curl.OPT_PUT,true)
	this.c:setopt(curl.OPT_READFUNCTION, function(u,s) print(u:read()) return p end)
	this.c:setopt(curl.OPT_INFILESIZE_LARGE,#p)
	--this.c:setopt(curl.OPT_READDATA,f)
	this.c:perform()
	print(this.buffer)
	print()
	return this.buffer
end

--- Perform the query as a GET request
--@return result of the query
function handyMethod.get(this) 
	this.c:perform() 
	return this.buffer
end

--- Adding header(s) to the request
--@param h List of header
function handyMethod.setHeader(this,h) this.c:setopt(curl.OPT_HTTPHEADER,unpack(h)) end

--- Anwser getters
--@return anwser of the request (if any)
function handyMethod.getOutput(this) return this.buffer end


--- Object allocator
--@return A new handyCurl object
--@see handyMethod.init(this,URL)
function newQueryBuilder(...) return setmetatable({},{__index = handyMethod}):init(unpack(arg)) end
