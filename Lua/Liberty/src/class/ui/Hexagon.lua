--- Hexagon class.
--@file Hexagon.lua
--@author Faylixe (felix.voituret@univ-avignon.fr)

local Hexagon = {};

--- Default constructor.
function Hexagon:initialize(model)
	self.model = model;	
end

--- Boolean method to find out if the mouse is over the tile.
function Hexagon:isMouseOver() 
	local x , y = love.mouse.getPosition();
	local p = ( ( self.model.x - x ) ^ 2 ) + ( ( self.model.y - y ) ^ 2 );
	return ( p <= ( self.model.width ^ 2 ) );
end

--- Drawing method.
function Hexagon:draw()
	local color = ( self:isMouseOver() and {255,153,0} or {255,255,255});
	love.graphics.setColor(color);
	love.graphics.circle("fill",self.model.x,self.model.y,self.model.width,6);
	love.graphics.setColor({0,0,0});
	love.graphics.circle("line",self.model.x,self.model.y,self.model.width-2,6);
end

registerClass("Hexagon",Hexagon);


