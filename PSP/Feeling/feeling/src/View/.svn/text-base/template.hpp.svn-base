/************************************************************************
* Template class, store graphics resources. 
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#include "background.hpp"

#ifndef LIBGE_HEADER
	#include <libge/libge.h>
	#define LIBGE_HEADER 1
#endif

#ifndef MODEL_HEADER
	#include "../Model/model.hpp"
	#define MODEL_HEADER 1
#endif

class Template {
	protected:
		ge_Image ** resource;
		ge_Font * font;
		Background * background;
	public:
		enum TPLID { GRID,  RED , BLUE , GREEN , CLEAR , BLACKBORDER , WHITEBORDER , PANEL,  END };
		static Template * build(std::string);
		Template();
		~Template();
		ge_Image * getResource(int) const;
		ge_Font * getFont() const;
		Background * getBackground() const;
		void setResource(int,ge_Image*);
		void setResource(int,std::string);
		void setBackground(Background *);
		void setFont(ge_Font *,int);
		void setFont(std::string,int);
		void draw();
};