/************************************************************************
* Background class, handle background image and background animation layer
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#include <string>

#ifndef LIBGE_HEADER
	#include <libge/libge.h>
	#define LIBGE_HEADER 1
#endif

class Background {
	protected:
		ge_Image * image;
	public:
		Background();
		Background(std::string);
		Background(ge_Image*);
		~Background();
		ge_Image * getImage() const;
		void setImage(ge_Image *);
		void setImage(std::string);
		void draw();
};