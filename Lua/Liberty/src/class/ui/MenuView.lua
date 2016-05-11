--- MenuView class.
--@file MenuView.lua
--@author Faylixe (felix.voituret@univ-avignon.fr)

require "class.ui.Hexagon";

local MenuView = {} 

--- Default constructor.
function MenuView:initialize(model)
	self.tiles = {};
	-- Importing model.
	local components = require(model);
	local insert = table.insert;
	-- Create hexagon tiles objects.
	for _ , tile in ipairs(components.tiles) do
		insert(self.tiles,new(Hexagon,tile));
	end
	-- Import label object.
	self.labels = components.label;
	-- Now we importing the images.
	--if ( components.images ) then
	--	for _ , images in ipairs(components.images) do
			--local image = love.graphics.newImage()
			--insert(self.images, { x = images.x , y = images.y , })
	--	end
	--end
end

--- Drawing method.
function MenuView:draw()
	-- First we draw hexagon tile.
	for _ , tile in ipairs(self.tiles) do
		tile:draw();
	end
	-- Now we draw labels.
	love.graphics.setColor({0,0,0});
	for _ , label in ipairs(self.labels) do
		love.graphics.print(label.text,label.x,label.y);
	end
end

--- Update method.
--@param delta The time during now and the last call.
function MenuView:update(delta)
	if ( self.isDestroy ) then
		self.timeout = ( self.timeout and ( self.timeout + delta ) or delta );
		if ( self.timeout >= 0.05 ) then		
			table.remove(self.tiles,math.random(1,#self.tiles));
			self.timeout = nil;
			if ( #self.tiles == 0 ) then
				self.isDestroy = nil;
				return "dead";
			end
		end
	end
	return "alive";
end

--- Mouse click event callback.
--@param x The x coordinate of the mouse when the click occured.
--@param y The y coordinate of the mouse when the click occured.
--@param button The button clicked.
--@return A signal.
function MenuView:onMouseClick(x,y,button)
	-- Checking for each tiles if mouse is over 
	for _,tile in ipairs(self.tiles) do
		if ( tile:isMouseOver() and tile.model.sig) then
			return tile.model.sig;
		end
	end
end

--- Destructor, free object.
function MenuView:finalize()
	-- Free tiles.
	self.tiles = nil;
end

registerClass("MenuView",MenuView);

