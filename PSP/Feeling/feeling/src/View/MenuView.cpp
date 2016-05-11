/************************************************************************
* MenuView class, handle display, graphics effect, using model. 
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#include "MenuView.hpp"

// ***********************************************************************************************************************************
// Public Constructor
MenuView::MenuView() : View() {
	resource = new ge_Image[END];
	
}

void MenuView::loadResource(){
	resource[BACKGROUND] = geLoadImage("");
	resource[ENTRY] = geLoadImage("");
	resource[ENTRYFOCUS] = geLoadImage("");
	resource[DESCRIPTION] = geLoadImage("");
}

// ***********************************************************************************************************************************
// Public destructor
MenuView::~MenuView(){
	unloadResource();
	delete * resource;
}

void MenuView::unloadResource(){
	geFreeImage(resource[BACKGROUND]); 
	geFreeImage(resource[ENTRY]); 
	geFreeImage(resource[ENTRYFOCUS]); 
	geFreeImage(resource[DESCRIPTION]); 
}

// ***********************************************************************************************************************************
// Draw method


// Draw all the view
void MenuView::draw(){
	geDrawImage(0,0,resource[BACKGROUND]);
}