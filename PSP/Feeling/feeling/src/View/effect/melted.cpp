/************************************************************************
* Melted effect
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/

#include "melted.hpp"

// ***********************************************************************************************************************************
// Public Constructor
Melted::Melted(std::string path){
	target = geLoadImage(path.c_str());
	geSwizzle(target);
	state = IN;
	alpha = 255;
	layer = geCreateSurface(480,272,RGBA(0,0,0,alpha));
}

// ***********************************************************************************************************************************
// Public Destructor
Melted::~Melted(){
	geFreeImage(target);
	geFreeImage(layer);
}

// ***********************************************************************************************************************************
// Update methode
bool Melted::update(){
	if (state == IN && --alpha == 0) state = OUT;
	else if (state == OUT && ++alpha == 256) return false;
	layer->color = RGBA(255, 255, 255, alpha);
	return true;
}

// ***********************************************************************************************************************************
// Draw method
void Melted::draw(){
	geDrawImage(0,0,target);
	geDrawImage(0,0,layer);
}
