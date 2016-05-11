--- Menu class.
--@file Menu.lua
--@author Faylixe (felix.voituret@univ-avignon.fr)

require "class.ui.MenuView";

local Menu = {} 

--- Menu model path.
local MODELS = {
	main = "model.menu.start",
	play = "model.menu.play",
	option = "model.menu.option",
}

--=============================================================================

--- Default constructor.
function Menu:initialize()
	self.currentView = new(MenuView,MODELS.main);
end

--- Drawing method.
function Menu:draw()
	self.currentView:draw();
end

--- Update method.
--@param delta The time during now and the last call.
function Menu:update(delta)
	local status = self.currentView:update(delta);
	if ( status == "dead") then
		return Menu[self.currentSignal](self);
	end
	return self;
end

--- Mouse click event callback.
--@param x The x coordinate of the mouse when the click occured.
--@param y The y coordinate of the mouse when the click occured.
--@param button The button clicked.
function Menu:onMouseClick(x,y,button)
	-- Ensure the right click button has been used.
	if not( button == 'l' ) then
		return;
	end
	-- Call the MenuView update method and handle the return signal.
	local sig = self.currentView:onMouseClick(x,y,button);
	if sig then
		self:handleSignal(sig);
	end
end

--- This method handle a given signal.
--@param sig The sent signal.
function Menu:handleSignal(sig)
	self.currentSignal = sig;
	self.currentView.isDestroy = true;
end

--- Destructor, free object.
function Menu:finalize()
	self.currentView:finalize();
	self.currentView = nil;
end

--=============================================================================
-- Static methods that handles action between menus

function Menu:play()
	self:finalize();
	love.graphics.reset();
	return new(Game);
end

function Menu:option()
	return;
end

function Menu:quit()
	return;
end


registerClass("Menu",Menu);

