/************************************************************************
* Menu 
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/

class Menu {
	protected:
		Option * list;
		int focus;
		MenuController * controller;
		MenuView * view;
	public:
		Menu();
		~Menu();
		bool run();
};