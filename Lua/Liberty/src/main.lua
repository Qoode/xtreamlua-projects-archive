---
--@file Main.lua 
--@author Faylixe (felix.voituret@univ-avignon.fr)

require "model.resources";
require "core.Utils";
require "core.Class";
require "core.Encrypt";
require "class.game.Game";
require "class.ui.Menu";


local activeObject;

--- Gamestate loading function.
--@param path The path of the file to read.
function loadGame(path)
	-- Open file and read it content data.
	local f = io.open(path,"r");
	assert(f,"Cannot open "..path.." : file not found");
	local serializedGame = Encrypt.decrypt( f:read("*a") );
	f:close();
	-- Now unserialize game state.
	game:unserialize(serializedGame);	
end

--- Gamestate saving function.
--@param path The path of the file to write.
function saveGame(path)	
	-- Open file in write mode.
	local f = io.open(path,"w");
	assert(f,"Cannot open "..path.." : do you have enough permission ?");
	-- Serialize the game and write it.
	local serializedGame = game:serialize();
	f:write( Encrypt.encrypt( serializedGame) );
	f:close();
end

--- Love loading function
function love.load()
	activeObject = new(Menu);
end

--- Love drawing callback.
function love.draw()
	love.graphics.clear();
	if activeObject then
		activeObject:draw();
	end
end

--- Update callback.
--@param delta The time during now and the last call.
function love.update(delta)
	activeObject = activeObject:update(delta);
	if not(activeObject) then
		love.event.quit();
	end
end

--- Mouse click event callback.
--@param x The x coordinate of the mouse when the click occured.
--@param y The y coordinate of the mouse when the click occured.
--@param button The button clicked.
function love.mousepressed(x,y,button)
	if activeObject then
		activeObject:onMouseClick(x,y,button);
	end
end

