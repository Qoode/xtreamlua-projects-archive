--- 
--@file
--@author Faylixe (felix.voituret@univ-avignon.fr)

require 'class.game.Board';

local LevelModel = {} 

--- Default constructor.
--@param rootModel The path of the root directory of the model.
function LevelModel:initialize(model)
end

--- Update method.
--@param delta The time during now and the last call.
function LevelModel:update()
end

--- Destructor, free object.
function LevelModel:finalize()
end

registerClass("LevelModel",LevelModel);
