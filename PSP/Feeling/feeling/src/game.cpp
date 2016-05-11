/************************************************************************
* Game class, the top level structure which handle MVC system
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#include "game.hpp"

using namespace std;

// ***********************************************************************************************************************************
// Public Constructor
Game::Game(){
	model = new Model(18,11);
	view = new GameView(model);
	controller = new GameController(model);
}

// ***********************************************************************************************************************************
// Public Destructor
Game::~Game(){
	delete controller;
	delete view;
	delete model;
}

// ***********************************************************************************************************************************
// Getters
Model * Game::getModel() const { return model; }
GameView * Game::getView() const { return view; }
GameController * Game::getController() const { return controller; }

// ***********************************************************************************************************************************
// Setters
void Game::setModel(Model *m) {
	if (model != NULL) delete model;
	model = m; 
	view->setModel(model);
	controller->setModel(model);
} 

void Game::setView(GameView * v) {
	if (view != NULL) delete view;
	view = v; 
	view->setModel(model);
}

void Game::setController(GameController * c) { 
	if (controller != NULL) delete controller;
	controller = c; 
	
}

// ***********************************************************************************************************************************
// Run method
bool Game::run(){
	model->popNextItem();
	while (controller->update()){ 
		view->draw();
	}
	return true;
}