--- Player testing.
--@author Faylixe (felix.voituret@univ-avignon.fr)

--- Import Dummy system as love package and testing environement.
love = require "Dummy";
require "core.Class";
require "class.game.PlayerModel";
require "lunit";
module("BuildingAndDisplayTest",lunit.testcase,package.seeall);

--- Set Player object
local player;

--- Testing object creation.
function testObjectBuilding()
	player = new(PlayerModel,100,100);
	assert_not_nil(player,"The player object is nil !");
	assert_equal(100,player.x,"The player attributes have not been settled correctly !");
	assert_equal(100,player.y,"The player attributes have not been settled correctly !");
	assert_equal(STAND,player.state,"The player attributes have not been settled correctly !");
	assert_equal(RIGHT,player.side,"The player attributes have not been settled correctly !");
end


