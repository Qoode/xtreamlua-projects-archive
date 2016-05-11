--======================================================================
--- Spreadsheet API, allow to retrieve and manipulate worksheet data
--@author Félix Voituret (felix.voituret@gmail.com)

module("google.spreadsheet",package.seeall)

_NAME = "google.spreadsheet"
_VERSION = "1.1"

require "google.https"
local XML = require "google.XML"

local BASE_URL = "https://spreadsheets.google.com/feeds/"
local URL =   {
                cells = BASE.URL.."cells/%s/%s/private/full",
                cell = BASE_URL.."cells/%s/%s/private/full/R%sC%s",
                worksheets = BASE_URL.."worksheets/%s/private/full/",
                worksheet = BASE_URL.."worksheets/%s/private/full/%s",
                spreadsheet = BASE_URL.."spreadsheets/private/full"
              }

local atom =    {
                                        worksheet = [==[
                                                                        <entry xmlns="http://www.w3.org/2005/Atom"
                                                                                xmlns:gs="http://schemas.google.com/spreadsheets/2006">
                                                                                <title>%s</title>
                                                                                <gs:rowCount>10</gs:rowCount>
                                                                                <gs:colCount>10</gs:colCount>
                                                                        </entry>
                                                                ]==],
                                        cell =                  [==[
                                                                        <entry xmlns="http://www.w3.org/2005/Atom"
                                                                                xmlns:gs="http://schemas.google.com/spreadsheets/2006">
                                                                                <id>https://spreadsheets.google.com/feeds/cells/%s/%s/private/full/R%dC%d</id>
                                                                                <link rel="edit" type="application/atom+xml" href="%s"/>
                                                                                <gs:cell row="%i" col="%i" inputValue="%s"/>
                                                                        </entry>
                                                                ]==]
                                }

local ROW_COUNT , COL_COUNT = "<gs:rowCount>%s</gs:rowCount>" , "<gs:colCount>%s</gs:colCount>"

-- ====================================================================================================================
-- Worksheet class definition, following method use a Cell-based feeds

local worksheetMethod = {}

local function getEditLink(feed)
        for _,link in XML.iGetNodeByTag(feed,"link") do
                if (XML.getAttribute(link,"rel") == "edit") then return XML.getAttribute(link,"href") end
        end
        return ""
end

--- Constructor for Worksheet Object
--@param this Worksheet object reference
--@return Worksheet object reference
function worksheetMethod.init(this)
        -- Erase previous collection
        this.data = {}
        -- Build query
        local feed = newQueryBuilder(URL.cells:format(this.parent.key,this.id),this.parent.token):get()
        -- Import online data
        for _,entry in XML.iGetNodeByTag(feed,"entry") do
                local i,j,v = XML.getAttribute(XML.getNodeByTag(entry,"gs:cell")[1],"row","col","inputValue")
                i,j = tonumber(i),tonumber(j)
                if not(this.data[i]) then this.data[i] = {} end
                this.data[i][j] = v
        end
        return this
end

--- Update the value of cell (i,j)
--@param this Worksheet object reference
--@param i
--@param j
--@param v new value
function worksheetMethod.set(this,i,j,v)
        -- Update local data
        if not(this.data[i]) then this.data[i] = {} end
        this.data[i][j] = v
        -- Get edit link
        local feed = newQueryBuilder(URL.cell:format(this.parent.key,this.id,i,j,this.parent.token):get()
        -- Build query and update data online
        newQueryBuilder(getEditLink(feed),this.parent.token):put(atom.cell:format(this.parent.key,this.id,i,j,edit,i,j,v))
end

--- Return value of cell (i,j)
--@param this Worksheet object reference
--@param i
--@param j
--@return value of cell(i,j)
function worksheetMethod.get(this,i,j)
        if data[i] then return this.data[i][j] end
end

--- Update the size of the given worksheet
--@param this Worksheet object reference
--@param r Row size
--@param c Column size
function worksheetMethod.setSize(this,r,c)
        -- Retrieve exact data feed and update it
        local feed = newQueryBuilder(URL.worksheet:format(this.parent.key,this.id),this.parent.token):get()
        feed = feed:gsub(ROW_COUNT:format(this.row),ROW_COUNT:format(r)):gsub(COL_COUNT:format(this.col),COL_COUNT:format(c))
        -- Build query and post new data online
        newQueryBuilder(getEditLink(feed),this.parent.token):put(feed)
        -- Update local data
        this.row , this.col = r , c
end

--- Update title of the given worksheet
--@param this Worksheet object reference
--@param title Worksheet's title
function worksheetMethod.setTitle(this,title)
        -- Retrieve exact data feed and update it
        local feed = newQueryBuilder(URL.worksheet:format(this.parent.key,this.id),this.parent.token):get()
        feed = feed:gsub("<title[^>]*>"..this.title.."</title>","<title type=\"text\">"..title.."</title>")
        -- Build query and post new data online
        newQueryBuilder(getEditLink(feed),this.parent.token):put(feed)
        -- Update local data
        this.title = title
end

-- ====================================================================================================================
-- Spreadsheet class definition

local spreadsheetMethod = {}

--- Constructor for Spreadsheet Object
--@param this Spreadsheet object reference
--@return Spreadsheet object reference
function spreadsheetMethod.init(this)
        -- Erase previous workesheet collection
        this.worksheet = {}
        -- Build query
        local feed  = newQueryBuilder(URL.worksheets:format(this.key),this.token):get()
        -- Parse XML anwser and retrive all worksheet link to our object
        for _,e in XML.iGetNodeByTag(feed,"entry") do
                table.insert(
                        this.worksheet,
                        setmetatable(
                                {
                                        id =    XML.getValue(XML.getNodeByTag(e,"id")[1]):match("([^/]+)$"),
                                        title = XML.getValue(XML.getNodeByTag(e,"title")[1]),
                                        row = XML.getValue(XML.getNodeByTag(e,"gs:rowCount")[1]),
                                        col = XML.getValue(XML.getNodeByTag(e,"gs:colCount")[1]),
                                        parent = this
                                },
                                {__index=worksheetMethod}):init()
                )
        end
        return this
end

--- Create and add a new worksheet to the current spreadsheet object
--@param this Spreadsheet object reference
--@param title Worksheet's title
function spreadsheetMethod.addWorksheet(this,title)
        -- Build and execute query
        newQueryBuilder(URL.worksheets:format(this.key),this.token):post(atom.worksheet:format(title),"application/atom+xml")
        -- Reload the spreadsheet
        this:init()
end

--- Delete a worksheet
--@param this Spreadsheet object reference
--@param id Worksheet id (local id, worksheet table id)
function spreadsheetMethod.removeWorksheet(this,id)
        local feed = newQueryBuilder(URL.worksheet:format(this.key,this.worksheet[id].id),this.token):get()
        newQueryBuilder(getEditLink(feed),this.token):delete()
        table.remove(this.worksheet,id)
end

--- Worksheet getters
--@param this Spreadsheet object reference
--@param title worksheet's title
--@return Worksheet object
function spreadsheetMethod.getWorksheet(this,title)
        for _,worksheet in ipairs(this.worksheet) do
                if worksheet.title == title then return worksheet end
        end
end

-- ====================================================================================================================
-- Spreadsheet package function

--- Get the list of available spreadsheet online and return it
-- as a list of pairs
--@param token Session token use so as to access to the service
--@return table
function getList(token)
        local feed , l = newQueryBuilder(URL.spreadsheet,token):get() , {}
        for _,entry in XML.iGetNodeByTag(feed,"entry") do
                table.insert(l,{key=XML.getValue(XML.getNodeByTag(entry,"id")[1]):match("([^/]+)$"),name=XML.getValue(XML.getNodeByTag(entry,"title")[1])})
        end
        return l
end

--- Get the list of spreasheet and return an iterator on it
--@param token Session token use so as to access to the service
--@return Iterator
function iGetList(token)
        return ipairs(getList(token))
end

--- Load a spreadsheet using it key as identifier
--@param token Session token use so as to access to the service
--@param key Spreadsheet's key
--@return Spreadsheet object
function loadFromKey(token,key)
        return setmetatable({key=key,worksheet={},token=token},{__index = spreadsheetMethod}):init()
end

--- Load a spreadsheet using it title as identifier
--@param token Sesssion token use so as to access to the service
--@param title Spreadsheet's title
--@return Spreadsheet Object
function loadFromTitle(token,title)
        for _,spreadsheet in iGetList(token) do
                if spreadsheet.title == title then return loadFromKey(token,spreadsheet.key) end
        end
end
