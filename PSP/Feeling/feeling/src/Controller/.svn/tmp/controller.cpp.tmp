/************************************************************************
* Controller class, handle user interaction, update model
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#include "controller.hpp"

// ***********************************************************************************************************************************
// Public Constructor
Controller::Controller(){
		init();
}

void Controller::init(){
        input = geCreateKeys();
		repeatListener = geCreateKeys();
}

int Controller::Keys[] = { GEK_UP , GEK_DOWN , GEK_RIGHT , GEK_LEFT , GEK_CROSS , GEK_CIRCLE , GEK_SQUARE , GEK_TRIANGLE , GEK_RTRIGGER , GEK_LTRIGGER ,GEK_START};
Controller::Callback Controller::action[] = {   &Controller::upCallback , &Controller::downCallback , 
                                                                        &Controller::rightCallback , &Controller::leftCallback , 
                                                                        &Controller::crossCallback , &Controller::circleCallback , 
                                                                        &Controller::squareCallback , &Controller::triangleCallback,
																		&Controller::rCallback , &Controller::lCallback ,&Controller::startCallback};

// ***********************************************************************************************************************************
// Public Destructor
Controller::~Controller(){
}

// ***********************************************************************************************************************************
// Controller callback method

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
bool Controller::update(){
        // Read key 
        geReadKeys(input);
        for (int i = 0 ; i < N_KEYS; i++){
                if (input->pressed[Keys[i]]){
                        Signal s = (this->*action[i])();
                        if (s != SIGDONE) return false;
				}
		}
		geReadKeys(repeatListener);
        return true;
}