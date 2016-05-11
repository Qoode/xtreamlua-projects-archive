/************************************************************************
* MenuView class, handle display, graphics effect, using model. 
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#include "view.hpp"

#include "../tools.hpp"

#include <sstream>

#ifndef LIBGE_HEADER
	#include <libge/libge.h>
	#define LIBGE_HEADER 1
#endif

class MenuView : public View {
	protected:
		enum { BACKGROUND , ENTRY , ENTRYFOCUS , END}
		ge_Image ** resource;
	public:
		MenuView();
		~MenuView();
		virtual void draw();
};