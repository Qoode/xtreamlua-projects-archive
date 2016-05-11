#include "game.hpp"
#include "View/effect/melted.hpp"

GE_PSP_INFO("Feeling",0,1,512);

int main(){
	pspDebugScreenInit();
	geInit();
	geModuleProgram(true);
	
	// Splash Screen animation effect
	Melted * splash[3] = { new Melted("Data/Splash/genesis.png") , new Melted("Data/Splash/shaolan.png") , new Melted("Data/Splash/jiiceii.png") };
	for (int i = 0; i < 3 ; i++){
		Effect::execute(splash[i]);
	    delete splash[i];
	}
	
	// Game test
	Game test;	
	test.getView()->setTemplate(Template::build("Data/Level/"));
	test.getModel()->setDelay(3);
	test.run();
	
	// LOSE
	geClearScreen();
	geFontPrintScreen(220, 140, test.getView()->getTemplate()->getFont(), "YOU_LOSE", RGB(255,255,255));
	geFontPrintScreen(220, 160, test.getView()->getTemplate()->getFont(), "press_home_so_as_to_back_to_XMB", RGB(255,255,255));
	geSwapBuffers();
	sceKernelSleepThread();
	return 0;
}