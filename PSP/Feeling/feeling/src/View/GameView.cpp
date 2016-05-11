/************************************************************************
* GameView class, handle display, graphics effect, using model. 
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#include "GameView.hpp"

// ***********************************************************************************************************************************
// Public Constructor
GameView::GameView() : View() {
	setModel(NULL);
	setTemplate(NULL);
}

GameView::GameView(Model * m) : View() {
	setModel(m);
	setTemplate(NULL);
}

GameView::GameView(Model * m,Template * t) : View() {
	setModel(m);
	setTemplate(t);
}

// ***********************************************************************************************************************************
// Public destructor
GameView::~GameView(){
}

// ***********************************************************************************************************************************
// Getters
Model * GameView::getModel() const {return model; }
Template * GameView::getTemplate() const { return tpl; }

// ***********************************************************************************************************************************
// Setters
void GameView::setModel(Model * m) { model = m; }
void GameView::setTemplate(Template * t) { tpl = t; }

// ***********************************************************************************************************************************
// Draw method

// Draw the list of falling item
void GameView::drawBlock(std::list<Block> * l){
	for (std::list<Block>::iterator i = l->begin() ; i != l->end() ; i++)
		drawBlock(&(*i));
}

// Draw the given falling item
void GameView::drawBlock(Block * i){
	int k = i->start , j = 0;
	do {
		geDrawImage(((int)i->x)+((j == 1 || j == 2) ? 20 : 0),((int)i->y)+((j == 2 || j == 3) ? 20 : 0),tpl->getResource(i->data[k]));
		k == 3 ? k = 0 : k++;
	} while ( ++j < 4 );
}

// Draw all the view
void GameView::draw(){
	// Draw template
	if (tpl == NULL) return;
	tpl->draw();
	// Draw items
	for (int i = 0 ; i < model->getWidth() ; i++){
		for (int j = 0 ; j < model->getHeight() ; j++){
			if (model->getMapping(i,j) != EMPTY){
				geDrawImage(GRID_X+(i*20),GRID_Y+(j*20),tpl->getResource(model->getMapping(i,j)));
				if (model->getClear(i,j)) geDrawImage(GRID_X+(i*20),GRID_Y+(j*20),tpl->getResource(Template::CLEAR)); // Draw clear picture 
	}}}
	// Draw Next Block
	drawBlock(model->getNext());
	// Draw Falling Block
	drawBlock(model->getFalling());
	// Print score and time
	geFontPrintScreen(420, 160, tpl->getFont(), "Score :", RGB(255,255,255));
	geFontPrintScreen(420, 185, tpl->getFont(), Tools::DTS(model->getScore()).c_str(), RGB(255,255,255));
	geFontPrintScreen(420, 210, tpl->getFont(), "Clear :", RGB(255,255,255));
	geFontPrintScreen(420, 235, tpl->getFont(), Tools::ITS(model->getDelay() - model->getTimeline()).c_str(), RGB(255,255,255));
	geSwapBuffers();
}