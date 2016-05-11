--======================================================================
--- Https class overload ssl.https module so as to make it more handy ;)
--@author Félix Voituret (felix.voituret@gmail.com)

require "ssl"
require "https"

local handyMethod = {}

--- HandyCurl object constructor
--@param URL target url
--@return reference to the object
function handyMethod.init(this,URL,token)
        this.buffer = {}
        this.query = { url = URL, sink = ltn12.sink.table(this.buffer) , headers = {}}
        if token then this.query.headers["Authorization"] = token end
        return this
end

--- Set a POST query and execute it
--@param p POST value of the query
--@return result of the query
function handyMethod.post(this,p,content_type)
        this.query.method = "POST"
        this.query.headers["Content-Length"] = #p
        this.query.headers["Content-Type"] = (content_type or "application/x-www-form-urlencoded")
        this.query.source = ltn12.source.string(p)
        ssl.https.request(this.query)
        return table.concat(this.buffer,"")
end

--- Set a PUT query and execute it
--@param p POST value of the query
--@return result of the query
function handyMethod.put(this,p,content_type)
        this.query.method = "PUT"
        this.query.headers["Content-Length"] = #p
        this.query.headers["Content-Type"] = (content_type or "application/atom+xml")
        this.query.source = ltn12.source.string(p)
        ssl.https.request(this.query)
        return table.concat(this.buffer,"")
end

--- Perform the query as a GET request
--@return result of the query
function handyMethod.get(this)
        this.query.method = "GET"
        ssl.https.request(this.query)
        return table.concat(this.buffer,"")
end

--- Perform the query as a DELETE request
function handyMethod.delete(this)
        this.query.method = "DELETE"
        ssl.https.request(this.query)
end

--- Adding header(s) to the request
--@param h List of header
function handyMethod.addHeader(this,name,value) this.query.headers[name] = value  end

--- Anwser getters
--@return anwser of the request (if any)
function handyMethod.getOutput(this) return this.buffer end

--- Object allocator
--@return A new handyCurl object
--@see handyMethod.init(this,URL)
function newQueryBuilder(...) return setmetatable({},{__index = handyMethod}):init(unpack(arg)) end
