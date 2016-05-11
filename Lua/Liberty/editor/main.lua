--- 
-- A board is a 40 * 30 tile.

require "core.Class";
require "class.LevelModel";
require "class.LevelView";
require "class.Ui"
local level = {};

function love.load()
	level.model = new(LevelModel);
	level.view = new(LevelView,level.model);
end

function love.draw()
	level.view:draw();
end

function love.update(delta)	
end
