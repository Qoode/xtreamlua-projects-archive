/************************************************************************
* Game class, the top level structure which handle MVC system
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/

#ifndef MODEL_HEADER
	#include "Model/model.hpp"
	#define MODEL_HEADER 1
#endif

#include "View/GameView.hpp"
#include "Controller/GameController.hpp"

#ifndef LIBGE_HEADER
	#include <libge/libge.h>
	#define LIBGE_HEADER 1
#endif

class Game {
	protected:
		Model * model;
		GameView * view;
		GameController * controller;
	public:
		Game();
		~Game();
		Model * getModel() const;
		GameView * getView() const;
		GameController * getController() const;
		void setModel(Model *);
		void setView(GameView *);
		void setController(GameController *);
		bool run();
};