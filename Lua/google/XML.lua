--======================================================================
--- XML parsing functions
--@author Félix Voituret (felix.voituret@gmail.com)

module("google.XML",package.seeall)

_NAME = "google.XML"
_VERSION = "1.0"

local pattern = {
         open_tag_generic = "<%s[^>]*[/]*>",
         single_tag = "<%s[^>]*/>" ,
         close_tag = "</%s>" ,
         attribute = "%s='([^']*)'",
         node_value = "<[^>]+>(.+)</[^>]+>"
      }

--- Parse the given XML document and return a list of element identified by tag
--@param document XML document to parse
--@param tag Tag searched
--@return list of XML element
function getNodeByTag(document,tag)
   local list = {}
   while document:find(pattern.open_tag_generic:format(tag)) do
      -- Check first for single tag :
      if document:find(pattern.single_tag:format(tag)) then
         local s,e = document:find(pattern.single_tag:format(tag))
         table.insert(list,document:sub(s,e))
         document = document:sub(0,s-1)..document:sub(e+1)
      else
         local s,_ = document:find(pattern.open_tag_generic:format(tag))
         local _,e = document:find(pattern.close_tag:format(tag))
         table.insert(list,document:sub(s,e))
         document = document:sub(0,s-1)..document:sub(e+1)
      end
   end
   return list
end

--- Return an iterator of XML node matched by tag
--@param document XML document to parse
--@param tag node tag searched
--@return iterator
function iGetNodeByTag(document,tag)
   return ipairs(getNodeByTag(document,tag))
end

--- Return attribute of first node identified by tag
--@param document XML document to parse
--@param tag Tag searched
--@param ... Attribute(s) queried
--@return value of attribute(s)
function getAttribute(node,...)
   if #arg == 0 then return end
   local attr = {}
   for _,name in ipairs(arg) do table.insert(attr,node:match(pattern.attribute:format(name))) end
   return unpack(attr)
end

--- Return the value of a given node
--@param node The node to parse
function getValue(node)
   return node:match(pattern.node_value)
end

