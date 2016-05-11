--- Game state class.
--@file class.Game.lua
--@author Faylixe (felix.voituret@univ-avignon.fr)

require 'class.game.PlayerModel';
require 'class.game.LevelModel';
require 'class.graphics.PlayerView';

--- Game class method container.
local Game = {} 

--- Game constructor.
function Game:initialize() 
	-- Creating player
	self.player = {}
	-- Player built for test purposes
	self.player.model = new(PlayerModel,100,100);
	self.player.view = new(PlayerView,self.player.model);
	self.level = nil;
end

--- Serialize the current game state as string.
--@return The serialized current object.
function Game:serialize()
	local serializedGame = "savedGame = {";
	serializedGame = serializedGame .. self.player:serialize() .. ",";
	serializedGame = serializedGame .. self.level:serialize() .. ",";
	serializedGame = serializedGame .. "};\nreturn savedGame;";
	return serializedGame;
end

--- Reverse serialize process and restore the corresponding game state.
--@param serializedGame The serialized game state data as string.
function Game:unserialize(serializedGame)
	local gameState = loadstring(serializedGame)();
end

--- Drawing method.
function Game:draw()
	self.player.view:draw();
end

--- Update method.
--@param delta The time during now and the last call.
function Game:update(delta)
	self.player.view:update(delta);
	return self;
end

--- Mouse click event callback.
--@param x The x coordinate of the mouse when the click occured.
--@param y The y coordinate of the mouse when the click occured.
--@param button The button clicked.
function Game:onMouseClick(x,y,button)
end

--- Destructor, free object.
function Game:finalize()
end

--- Finally register the class to the OO system.
registerClass("Game",Game);

