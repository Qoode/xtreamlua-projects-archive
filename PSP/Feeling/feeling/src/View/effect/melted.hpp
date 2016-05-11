/************************************************************************
* Melted effect
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/

#include "../effect.hpp"
#include <string>

#ifndef LIBGE_HEADER
        #include <libge/libge.h>
        #define LIBGE_HEADER 1
#endif

#define IN 1
#define OUT 2

class Melted : public Effect {
	public:
		bool update();
		void draw();
		Melted(std::string);
		~Melted();
	protected: 
		int alpha;
		int state;
		ge_Image * layer;
		ge_Image * target;
};