/************************************************************************
* Controller class, handle user interaction, update model
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#include "Controller.hpp"

class MenuController : public Controller {
        protected:
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
                MenuController();
                ~MenuController();
				void init();
                virtual bool update();  
};
