/************************************************************************
* GameController class, handle user interaction, update model
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#include "GameController.hpp"

// ***********************************************************************************************************************************
// Public Constructor
GameController::GameController() : Controller() { init(); }
GameController::GameController(Model * m) : Controller() { 
	model = m;
	init(); 
}

void GameController::init(){
		timeline = geCreateTimer("timeline");
		geTimerStart(timeline);
		move = swap = down = 0;
		pause = false;
}

// ***********************************************************************************************************************************
// Public Destructor
GameController::~GameController() {}

// ***********************************************************************************************************************************
//	Getters
Model * GameController::getModel() const { return model; }

// ***********************************************************************************************************************************
//	Setters
void GameController::setModel(Model * m) { model = m; }

// ***********************************************************************************************************************************
// GameController callback method

Signal GameController::crossCallback(){
	if (pause) return SIGDONE;
	if (swap == SWAP_DELAY || repeatListener->released[GEK_CROSS]) {
		model->increaseBlock();
		swap = 0;
	}
	else if (!repeatListener->released[GEK_CROSS]) swap++;
	return SIGDONE;
}

Signal GameController::circleCallback(){
	if (pause) return SIGDONE;
	model->increaseBlock();
    return SIGDONE;
}

Signal GameController::squareCallback(){
	if (pause) return SIGDONE;
	model->increaseBlock();
    return SIGDONE;
}

Signal GameController::triangleCallback(){
	if (pause) return SIGDONE;
	model->increaseBlock();
    return SIGDONE;
}

Signal GameController::upCallback(){
	if (pause) return SIGDONE;
    return SIGDONE;
}

Signal GameController::downCallback(){
	if (pause) return SIGDONE;
	if (down == DOWN_DELAY || repeatListener->released[GEK_DOWN]) {	
		model->move(DOWN);
		down = 0;
	}
	else if (!repeatListener->released[GEK_DOWN]) down++;
    return SIGDONE;
}

Signal GameController::leftCallback(){
	if (pause) return SIGDONE;
	if (move == MOVE_DELAY || repeatListener->released[GEK_LEFT]) {	
		model->move(LEFT);
		move = 0;
	}
	else if (!repeatListener->released[GEK_LEFT]) move++;
    return SIGDONE;
}

Signal GameController::rightCallback(){
	if (pause) return SIGDONE;
	if (move == MOVE_DELAY || repeatListener->released[GEK_RIGHT]) {	
		model->move(RIGHT);
		move = 0;
	}
	else if (!repeatListener->released[GEK_RIGHT]) move++;
    return SIGDONE;
}

Signal GameController::rCallback(){
	if (pause) return SIGDONE;
	model->nextFocus();
	return SIGDONE;
}

Signal GameController::lCallback(){
	if (pause) return SIGDONE;
	model->forwardFocus();
	return SIGDONE;
}

Signal GameController::startCallback(){
	//pause = !pause;
	return SIGDONE;
}


// ***********************************************************************************************************************************
// Update method : read user input, and check game state
bool GameController::update(){
        // Update Model 
		if (!pause){
			model->updateMapping();	
			if (model->updateFalling() == SIGLOST) return false;	
			// Check for timed clear
			if (model->getNeedClear()){
				if (!started) {
					geTimerStart(timeline);
					started = true;
				}
				model->setTimeline(timeline->seconds);
				geTimerUpdate(timeline);
				if (timeline->seconds >= model->getDelay()){
					model->updateClear();
					started = false;
				}
			}			
			else model->setTimeline(0);
		}
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