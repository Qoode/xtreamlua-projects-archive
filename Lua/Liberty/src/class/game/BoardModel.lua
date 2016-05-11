---  
--@file
--@author Faylixe (felix.voituret@univ-avignon.fr)

local BoardModel = {} 

--- Default constructor. Load the model.
--@param model The path of the model file of the board.
function BoardModel:initialize(model)
	self.map = require(model);
end

--- Update method.
--@param delta The time during now and the last call.
function BoardModel:update(delta)
	
end

--- Destructor, free object.
function BoardModel:finalize()
	table.free(self.model);
	table.free(self);
end

registerClass("BoardModel",BoardModel);
