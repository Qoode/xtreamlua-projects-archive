__wlan__ = {connecting = false}
function __bin__.iwconfig(...)
	if arg[1] == "up" then 
		pge.net.init() 
		pge.utils.netinit()
		__wlan__.connecting = true 
	elseif arg[1] == "down" then pge.net.disconnect() pge.net.shutdown() end
end
