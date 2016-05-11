--======================================================================
--- ClientLogin function and services alias mapping
--@author Félix Voituret (felix.voituret@gmail.com)

module("google.auth",package.seeall)

_NAME = "google.auth"
_VERSION = "1.0"

require "google.https"

local CLIENT_LOGIN_URL = "https://www.google.com/accounts/ClientLogin"
service = { spreadsheet = "wise" , calendar = "cl" , document = "writely" , mail = "mail" , contact = "cp"}

--- Login to Google service using ClientLogin and return a session token
--@param user Google account's email
--@param password Google account's password
--@param service Google service wanted
--@param source Application's name (optional)
--@return Session token
function newToken(user,password,service,source)
        local p = "Email="..socket.url.escape(user).."&Passwd="..socket.url.escape(password).."&accountType=GOOGLE&source ="..(source or "lua_script_using_GoogleAPI").."&service="..service
        local a = newQueryBuilder(CLIENT_LOGIN_URL):post(p)
        return "GoogleLogin auth="..a:match("Auth=([^\n]+)")
end
