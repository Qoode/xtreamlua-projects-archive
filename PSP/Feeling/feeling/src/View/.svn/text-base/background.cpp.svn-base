/************************************************************************
* Background class, handle background image and background animation layer
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#include "background.hpp"

// ***********************************************************************************************************************************
// Public Constructor
Background::Background(){
	setImage(NULL);
}

Background::Background(std::string path){
	setImage(path);
}

Background::Background(ge_Image * i){
	setImage(i);
}

// ***********************************************************************************************************************************
// Public Destructor
Background::~Background(){
	geFree(image);
}

// ***********************************************************************************************************************************
// Getters
ge_Image * Background::getImage() const { return image; }

// ***********************************************************************************************************************************
// Setters
void Background::setImage(ge_Image * i) { image = i; }
void Background::setImage(std::string path){
	image = geLoadImage(path.c_str()); 
	geSwizzle(image);
}

// ***********************************************************************************************************************************
// Draw method
void Background::draw(){
	geDrawImage(0,0,image);
}
