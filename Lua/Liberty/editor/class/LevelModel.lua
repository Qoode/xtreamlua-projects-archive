--- 
--@file
--@author Faylixe (felix.voituret@univ-avignon.fr)

require 'class.game.Board';

local LevelModel = {} 

function LevelModel:initialize(modelPath)
	local model = require(modelPath);	
end

function LevelModel:update()
end

function LevelModel:finalize()
end

registerClass("LevelModel",LevelModel);
