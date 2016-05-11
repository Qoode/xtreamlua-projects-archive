/************************************************************************
* MenuController class, handle user interaction, update model
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#include "MenuController.hpp"

// ***********************************************************************************************************************************
// Public Constructor
MenuController::MenuController() : Controller() { init(); }

void MenuController::init(){
}

// ***********************************************************************************************************************************
// Public Destructor
MenuController::~MenuController() {}

// ***********************************************************************************************************************************
// MenuController callback method

Signal Controller::crossCallback()		{ return SIGDONE; }
Signal Controller::circleCallback()		{ return SIGDONE; }
Signal Controller::squareCallback()		{ return SIGDONE; }
Signal Controller::triangleCallback()	{ return SIGDONE; }
Signal Controller::upCallback()			{ return SIGDONE; }
Signal Controller::downCallback()		{ return SIGDONE; }
Signal Controller::leftCallback()		{ return SIGDONE; }
Signal Controller::rightCallback()		{ return SIGDONE; }
Signal Controller::rCallback()			{ return SIGDONE; }
Signal Controller::lCallback()			{ return SIGDONE; }
Signal Controller::startCallback()		{ return SIGDONE; }


// ***********************************************************************************************************************************
// Update method : read user input, and check game state
bool MenuController::update(){
        // Read key 
        geReadKeys(input);
        for (int i = 0 ; i < N_KEYS; i++){
                if (input->pressed[Keys[i]]){
                        Signal s = (this->*action[i])();
                        if (s == SIGWIN || s == SIGLOST) return false;
				}
		}
		geReadKeys(repeatListener);
        return true;
}