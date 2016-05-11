TARGET = Feeling
OBJS = src/main.o src/game.o src/Model/model.o src/View/view.o src/View/GameView.o src/Controller/controller.o src/Controller/GameController.o src/View/template.o src/View/background.o src/tools.o src/View/effect.o src/View/effect/melted.o

CFLAGS = -O2 -G0 -Wall -DPSPFW3xx
CXXFLAGS = $(CFLAGS) -fno-exceptions -fno-rtti
ASFLAGS =  $(CFLAGS) 

LIBS = 	-lstdc++ -lge -lfreetype -lpspmp3 -lm
EXTRA_TARGETS = EBOOT.PBP
PSP_EBOOT_TITLE = Feeling
PSP_EBOOT_ICON = ICON0.png
PSP_EBOOT_PIC1 = PIC1.png

PSPSDK = $(shell psp-config --pspsdk-path)
include $(PSPSDK)/lib/build.mak