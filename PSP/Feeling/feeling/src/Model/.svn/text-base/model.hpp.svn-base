/************************************************************************
* Model class, describe data content, including mapping, next items, 
* color, etc ...
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#include <string>
#include <list>

#ifndef LIBGE_HEADER
        #include <libge/libge.h>
        #define LIBGE_HEADER 1
#endif

#define GRID_X 56
#define GRID_Y 45
#define NEXT 4
#define WAIT 100

enum Item { EMPTY, RED , BLUE , GREEN , SHADOW};
enum Side { DOWN , LEFT , RIGHT };      
enum Signal { SIGDONE , SIGWIN , SIGLOST};

struct Block {
        int start;
		int wait;
		float x,y,speed;
        Item data[4];
        Block();
        Block(float,float,Item[4]);
};


class Model {
        public:
                // Constructor
                Model();
                Model(int,int);
                // Destructor
                ~Model();
                // Getters
                int getWidth() const;
                int getHeight() const;
                int getDelay() const;
                int getTimeline() const;
                double getScore() const;
                Item getMapping(int,int) const;
                bool getClear(int,int) const;
                std::list<Block> * getNext();
                std::list<Block> * getFalling();
				int getFocus() const;
				bool getNeedClear() const;
                // Setters
                void setWidth(int);
                void setHeight(int);
                void setDelay(int);
                void setTimeline(int);
                void setFocus(int);
                void setScore(double);
                void setMapping(int,int,Item);
				void setClear(int,int,bool);
                // Common method        
                Block makeRandomBlock();
				void increaseBlock();
				void nextFocus();
				void forwardFocus();
				void move(int);
                void fillNext();
                void popNextItem(); 
                void pushFallingItem(Block); 
                void connect(Block *);
				void updateClear();
                void updateMapping();
				Signal updateFalling();
        protected:
                double score;
				int delay;
				int timeline;
				int focus;
                std::list<Block> next;
                std::list<Block> falling;
				Item ** mapping;
				bool ** clear;
				bool needClear;
                int width, height;
};