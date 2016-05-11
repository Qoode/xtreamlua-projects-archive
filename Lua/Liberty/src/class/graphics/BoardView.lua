--- BoardView class.
--@file BoardView.lua
--@author Faylixe (felix.voituret@univ-avignon.fr)

local BoardView = {};

--- Default constructor.
function BoardView:initialize(model)
	self.model = model;
end

--- Drawing method.
function BoardView:draw() 
	for x = 1 , #self.model.map do
		for y = 1 , #self.model.map[x] do
			local tile = BoardView.tile[self.model.map[x][y]];
			love.graphics.draw( tile , ( x - 1 ) * tile:getWidth() , ( y - 1 ) * tile:getHeight() );
		end
	end
end

--- Update method.
--@param delta The time during now and the last call.
function BoardView:update(delta)
end

registerClass("BoardView",BoardView);


