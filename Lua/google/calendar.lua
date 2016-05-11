--@author Félix Voituret (felix.voituret@gmail.com)

module("google.calendar",package.seeall)

_NAME = "google.calendar"
_VERSION = "1.1"

require "google.https"
local XML = require "google.XML"

local BASE_URL = "https://www.google.com/calendar/feeds/"
local URL =   {
                calendars = BASE_URL.."default/%s/full",
                calendar = BASE_URL.."default/%s/full/%s",
				event = BASE_URL.."default/private/full/%s",
				events = BASE_URL.."default/private/full?start-min=%sT00:00:00&start-max=%sT23:59:59"
              }

local atom =    {
                        calendar =      [[
                                                <entry xmlns=http://www.w3.org/2005/Atom'
                                                        xmlns:gs='http://schemas.google.com/g/2005'
                                                        xmlns:gCal='http://schemas.google.com/gCal/2005'>
                                                        <title type='text'>%s</title>
                                                        <summary type='text'>%s</summary>
                                                        <gCal:timezone value='%s'></gCal:timezone>
                                                        <gCal:hidden value='false'></gCal:hidden>
                                                        <gCal:color value='#2952A3'></gCal:color>
                                                        <gd:where rel='' label='' valueString='%s'></gd:where>
                                                </entry>
                                        ]]
						event =			[[
												<entry xmlns='http://www.w3.org/2005/Atom'
													xmlns:gd='http://schemas.google.com/g/2005'>
													<category scheme='http://schemas.google.com/g/2005#kind'
														term='http://schemas.google.com/g/2005#event'></category>
													<title type='text'>%s/title>
													<content type='text'>%s</content>
													<gd:transparency
														value='http://schemas.google.com/g/2005#event.opaque'>
													</gd:transparency>
													<gd:eventStatus
														value='%s'>
													</gd:eventStatus>
													<gd:where valueString='%s'></gd:where>
													<gd:when startTime='%sT%s.000Z'
														endTime='%sT%s.000Z'></gd:when>
												</entry>
										]]
                }

local eventStatus = 	{
							confirmed = "http://schemas.google.com/g/2005#event.confirmed",
							cancelled = "http://schemas.google.com/g/2005#event.canceled",
							tentative = "http://schemas.google.com/g/2005#event.tentative"
						}

local function getLink(feed,name)
	for _,link in XML.iGetNodeByTag(feed,"link") do
		if (XML.getAttribute(link,"rel") == name) then return XML.getAttribute(link,"href") end
	end
	return ""
end

-- ====================================================================================================================
-- Event class definition

local eventMethod = {}

--- Constructor for Event object
--@param this Event object reference
--@param feed Atom entry for this event
--@return Event object reference
function eventMethod.init(this,feed)
	-- Retrieve Identification data
	this.key = XML.getNodeByTag(feed,"id")[1]:match("([^/]+)$")
	this.magic = XML.getNodeByTag(feed,"id")[1]:match("/private-([^/]+)/")
	-- Retrieve common information
	this.title = XML.getValue(XML.getNodeByTag(feed,"title")[1])
	this.content = XML.getValue(XML.getNodeByTag(feed,"content")[1])
	-- Retrieve author
	local author = XML.getNodeByTag(feed,"author")[1]
	this.author_name = XML.getValue(XML.getNodeByTag(author,"name")[1])
	this.author_id = XML.getValue(XML.getNodeByTag(author,"email")[1])
	-- Retrieve time , date and place
	local when = XML.getNodeByTag(feed,"gd:when")[1]
	for _,v in ipairs {"start","end"} do
		this[v] = 	{
						local y,m,d,h,m,s =
							XML.getAttribute(when,v.."Time"):match("(%d%d%d%d)-(%d%d)-(%d%d)T"),
							XML.getAttribute(when,v.."Time"):match("T(%d%d):(%d%d):(%d%d)")
						date = { year = y , month = m , day = d }
						time = { hours = h , minutes = m , seconds = s}
					}
	end
	this.place = XML.getAttribute(XML.getNodeByTag(feed,"gd:where")[1],"valueString")
	return this
end

--- Update event name online and offline
--@param this Event object reference
--@param title new event title
function eventMethod.setTitle(this,title)
	local feed ,this.title = newQueryBuilder():get() , title
	feed = feed:gsub(XML.getNodeByTag(feed,"title")[1],("<title type='text'>%s</title>"):format(title))
	newQueryBuilder(getLink(feed,"edit"),this.token):put(feed)
end

--- Update event property online
--@param this Event object reference
--@param property name of updating property
--@param value new value of property
function eventMethod.setTitle(this,property,value)
	local feed ,this[property] = newQueryBuilder():get() , value
	feed = feed:gsub(XML.getNodeByTag(feed,property)[1],(:format(value))
	newQueryBuilder(getLink(feed,"edit"),this.token):put(feed)
end

--- Delete event online and offline
--@param this Event object reference
function eventMethod.delete(this)
	newQueryBuilder([=[ TODO ]=],this.token):delete()
	this = nil
end

-- ====================================================================================================================
-- Calendar class definition

local calendarMethod = {}

--- Constructor for Calendar Object
--@param this Calendar object reference
--@return Calendar object reference
function calendarMethod.init(this)
	local feed = newQueryBuilder(URL.calendar:format(this.key)):get()
	return this
end

--- Delete calendar object offline and online
--@param this Calendar object reference
function calendarMethod.delete(this)
	newQueryBuilder(URL.calendar:format(this.key)):delete()
	this = nil
end

--- Find and return list of event during the given day
--@param this Calendar object reference
--@param day
function calendarMethod.getEventList(this,day)
	local feed , l = newQueryBuilder(URL.events:format(day,day)):get() , {}
	for _,entry in XML.iGetNodeByTag(feed,"entry") do
		table.insert(l,setmetatable({token=this.token},{__index=eventMethod):init(feed))
	end
	return l
end

-- ====================================================================================================================
--

--- Retrieve list of available online calendar and return it
-- as a list of pairs
--@param token Session token use so as to access to the service
--@param mode Used for retrieve all calendar or only user's one (optionnal)
--@return table
function getList(token,mode)
	local feed , l = newQueryBuilder(URL.calendars:format(mode or "all"),token):get() , {}
	for _,entry in XML.iGetNodeByTag(feed,"entry") do
		table.insert(l,{key = XML.getValue(XML.getNodeByTag(entry,"id")[1]):match("([^/]+)$"),name=XML.getValue(XML.getNodeByTag(entry,"title")[1])}
	end
	return l
end

--- Load calendar index by the given key
--@param token Session token use so as to access to the service
--@param key Calendar index key
function loadFromKey(token,key)
	return setmetatable({key=key,token=token},{__index = calendarMethod}):init()
end

--- Create a new calendar online and return it
--@param token Session token use so as to access to the service
--@param name
--@param summary
--@param timezone
--@param place
--@return Calendar object
function newCalendar(token,name,summary,timezone,place)
	local feed = newQueryBuilder(URL.calendars,token):post(atom.calendar:format(name ,summary or "",timezone or "UTC", place or "","application/atom+xml")
	return loadFromKey(token,getLink(feed,"self"):match("([^/]+)$"))
end

--- Create a new event online and return it
--@param token Session token use so as to access to the service
--@param name
--@param content
--@param status
--@param where
--@param startDay
--@param startTime
--@param endDay
--@param enTime
--@return Event object
function newEvent(token,name,content,status,where,startDay,startTime,endDay,endTime)
	local startDay , startTime = startDay or "20"..os.date("%y-%m-%d") , startTime or os.date("%H:%M:%S")
	local endDay , endTime = endDay or "20"..os.date("%y-%m-%d") , endTime or os.date("%H:%M:%S")
	local event = atom.event:format(name,content or "",status or eventStatus.tentative,where or "",startDay,startTime,endDay,endTime)
	local feed = newQueryBuilder(URL.event,token):post(event,"application/atom+xml")
	return setmetatable({token=token},{__index=eventMethod}):init(feed)
end
