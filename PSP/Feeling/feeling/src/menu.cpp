/************************************************************************
* Menu 
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/

Menu::Menu(){
}

~Menu::Menu(){
}

bool Menu::run(){
	while (controller->update())
		view->draw();
	return true;
}