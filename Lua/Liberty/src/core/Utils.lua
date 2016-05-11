--- Set of utils functions.
--@file core/Utils.lua
--@author Faylixe (felix.voituret@univ-avignon.fr)

--- Remapping require to import in order to
-- make difference between Model and Model data.
import = require;

--- Niling function.
--@param data The table to free.
function table.free(t)
	if not( type(t) == "table") then
		return;
	end
	for k , v in pairs(t) do
		if ( type(v) == "table" ) then
			table.free(v);
		else
			t[k] = nil;
		end
	end
end
