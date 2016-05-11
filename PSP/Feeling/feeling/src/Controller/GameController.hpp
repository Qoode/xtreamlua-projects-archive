/************************************************************************
* Controller class, handle user interaction, update model
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#include "Controller.hpp"

#define MOVE_DELAY 10
#define SWAP_DELAY 40
#define DOWN_DELAY 5	


class GameController : public Controller {
        protected:
				Model * model;
				ge_Timer* timeline;
				int move;
				int down;
				int swap;
				bool started;
				bool pause;
                // Callback method
                virtual Signal crossCallback();
                virtual Signal circleCallback();
                virtual Signal squareCallback();
                virtual Signal triangleCallback();
                virtual Signal upCallback();
                virtual Signal downCallback();
                virtual Signal leftCallback();
                virtual Signal rightCallback(); 
                virtual Signal rCallback(); 
                virtual Signal lCallback(); 
                virtual Signal startCallback(); 
        public:
                GameController();
                GameController(Model *);
                ~GameController();
				Model * getModel() const;
				void setModel(Model *);
				void init();
                virtual bool update();  
};
