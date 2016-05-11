/************************************************************************
* Controller class, handle user interaction, update model
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#ifndef MODEL_HEADER
        #include "../Model/model.hpp"
        #define MODEL_HEADER 1
#endif

#ifndef LIBGE_HEADER
        #include <libge/libge.h>
        #define LIBGE_HEADER 1
#endif

#define N_KEYS 11


class Controller {
        protected:
                ge_Keys * input;
                ge_Keys * repeatListener;
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
                typedef Signal (Controller::*Callback)();
                static int Keys[];
                static Callback action[];
                Controller();
                ~Controller();
				void init();
                virtual bool update();  
};
