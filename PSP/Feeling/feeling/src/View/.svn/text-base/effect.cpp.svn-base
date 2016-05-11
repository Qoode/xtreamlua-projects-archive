/************************************************************************
* Effect abstract class
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/

#include "effect.hpp"

void Effect::execute(Effect * e){
	while (e->update()){
		geClearScreen();
		e->draw();
		geSwapBuffers();
}}
