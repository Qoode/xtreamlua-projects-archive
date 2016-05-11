/************************************************************************
* GameView class, handle display, graphics effect, using model. 
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#ifndef MODEL_HEADER
	#include "../Model/model.hpp"
	#define MODEL_HEADER 1
#endif

#include "template.hpp"
#include "view.hpp"

#include "../tools.hpp"

#include <sstream>

#ifndef LIBGE_HEADER
	#include <libge/libge.h>
	#define LIBGE_HEADER 1
#endif

class GameView : public View {
	protected:
		Model * model;
		Template * tpl;
	public:
		GameView();
		GameView(Model *);
		GameView(Model *,Template *);
		~GameView();
		Model * getModel() const;
		Template * getTemplate() const;
		void setModel(Model *);
		void setTemplate(Template *);
		virtual void draw();
		void drawBlock(std::list<Block> *);
		void drawBlock(Block *);
};