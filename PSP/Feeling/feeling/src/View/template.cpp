/************************************************************************
* Template class, store graphics resources. 
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#include "template.hpp"

// DEBUG FUNCTION
void printT(const char * s) {
	pspDebugScreenSetXY(0,0);
	pspDebugScreenPrintf(s);
}

// ***********************************************************************************************************************************
// Static method which return a default template
Template * Template::build(std::string path){
	Template * t = new Template();
	t->setBackground(new Background("Data/Level/background.png"));
	t->setResource(GRID,"Data/Level/grid.png");
	t->setResource(BLUE,"Data/Level/blue.png");
	t->setResource(GREEN,"Data/Level/green.png");
	t->setResource(RED,"Data/Level/red.png");
	t->setResource(CLEAR,"Data/Level/clear.png");
	t->setResource(BLACKBORDER,"Data/Level/blackBorder.png");
	t->setResource(WHITEBORDER,"Data/Level/whiteBorder.png");
	t->setResource(PANEL,"Data/Level/panel.png");
	t->setFont("Data/Level/font.ttf",18);
	return t;
}

// ***********************************************************************************************************************************
// Public Constructor
Template::Template(){
	// Allocation du tableau de ge_Image
	resource = new ge_Image*[END];
	setBackground(NULL);
}

// ***********************************************************************************************************************************
// Public Destructor
Template::~Template(){
	for (int i = 0; i < END ; i++){
		geFreeImage(resource[i]);
	}
	delete * resource;
}

// ***********************************************************************************************************************************
// Getters
ge_Image * Template::getResource(int i) const { return resource[i]; }
ge_Font * Template::getFont() const { return font; }
Background * Template::getBackground() const { return background; }

// ***********************************************************************************************************************************
// Setters
void Template::setResource(int i,ge_Image* p) { 
	if (resource[i] != NULL) geFreeImage(resource[i]);
	resource[i] = p; 
}

void Template::setResource(int i,std::string p) { 
	if (resource[i] != NULL) geFreeImage(resource[i]);
	resource[i] = geLoadImage(p.c_str());
	geSwizzle(resource[i]); 
}

void Template::setBackground(Background * b) { background = b; }

void Template::setFont(ge_Font * f,int s) { 
	if (font != NULL) geFreeFont(font);
	font = f; 
	geFontSize(font, s);
}

void Template::setFont(std::string p,int s) { 
	if (font != NULL) geFreeFont(font);
	font = geLoadFont(p.c_str()); 
	geFontSize(font, s);
}

// ***********************************************************************************************************************************
// Draw method
void Template::draw(){
	background->draw();
	geDrawImage(0,0,resource[PANEL]);
	geDrawImage(GRID_X,GRID_Y,resource[GRID]);
	geDrawImage(0,0,resource[WHITEBORDER]);
}
