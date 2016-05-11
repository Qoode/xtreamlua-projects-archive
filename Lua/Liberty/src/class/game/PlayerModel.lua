--- PlayerModel class.
--@file PlayerModel.lua
--@author Faylixe (felix.voituret@univ-avignon.fr)

local PlayerModel = {} 

--- Status enumeration.
STAND	= 1;
JUMP 	= 2;
RUN		= 3;
LEFT	= 1;
RIGHT 	= 2;

--- Default constructor.
--@param x The x coordinate of the PlayerModel.
--@param y The y coordinate of the PlayerModel.
function PlayerModel:initialize(x,y)
	self.x , self.y = x , y; 
	self.state = RUN;
	self.side = RIGHT;
end

--- Destructor, free objects.
function PlayerModel:finalize()
	self.x = nil;
	self.y = nil;
	self.state = nil;
	self.side = nil;
end

registerClass("PlayerModel",PlayerModel);

