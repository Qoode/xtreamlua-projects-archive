--- PlayerView class.
--@file PlayerView.lua
--@author Faylixe (felix.voituret@univ-avignon.fr)

local PlayerView = {};

--- Default constructor.
function PlayerView:initialize(model)
	self.model = model;
	self.sprite = love.graphics.newImage( Resources.images.player );
	self.frame = 1;
	self.timeout = 0;
	self.mapping = require "model.player";
	local v = self:getViewport();
	print(v.x,v.y,self.mapping.size.width,self.mapping.size.height);
	self.viewport = love.graphics.newQuad(
						v.x,
						v.y,
						self.mapping.size.width,
						self.mapping.size.height,
						self.sprite:getWidth(),
						self.sprite:getHeight());
end

--- Drawing method.
function PlayerView:draw() 
	love.graphics.drawq(self.sprite,self.viewport,self.model.x,self.model.y);
end

--- Update method.
--@param delta The time during now and the last call.
function PlayerView:update(delta)
	self.timeout = self.timeout + delta;
	if ( self.timeout >= self.mapping.frameRate ) then
		self.frame = self.frame + 1;
		if ( self.frame > #self.mapping[self.model.state] ) then
			self.frame = 1;
		end
		local v = self:getViewport();
		self.viewport:setViewport(v.x,v.y,self.mapping.size.width,self.mapping.size.height);
		self.timeout = 0;
	end
end

---
--@return
function PlayerView:getViewport()
	return self.mapping[self.model.state][self.frame][self.model.side];
end

registerClass("PlayerView",PlayerView);

