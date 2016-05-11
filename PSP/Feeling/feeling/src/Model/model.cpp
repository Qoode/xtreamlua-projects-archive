/************************************************************************
* Model class, describe data content, including mapping, next items, 
* color, etc ...
* Author : Shaolan
* Version : 1.0
* Website : http://shaolan.net
*/
#ifndef MODEL_HEADER
        #include "model.hpp"
        #define MODEL_HEADER 1
#endif

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// ***********************************************************************************************************************************
// Block structure definition
Block::Block(){
        x = y =  start = wait = 0;
		speed = 0.0;
        for (int i = 0 ; i < 4 ; i++) data[i] = EMPTY;
}

Block::Block(float i,float j,Item d[4]){
        x = i;
        y = j;
        start = wait = 0;
		speed = 0.0;
        for (int k = 0 ; k < 4 ; k++) data[k] = d[k];
}

// ***********************************************************************************************************************************
// Public Constructor
Model::Model(){
        mapping = NULL;
        setWidth(0);
        setHeight(0);
        setScore(0);
		setFocus(0);
        fillNext();
}

Model::Model(int w,int h){
        srand(time(NULL));
        setWidth(w);
        setHeight(h);
        // Set Mapping
        mapping = new Item*[width];
		clear = new bool*[width];
        for (int i = 0 ; i < width ; i++){
                mapping[i] = new Item[height];
                clear[i] = new bool[height];
                for (int j = 0 ; j < height ; j++){
					setMapping(i,j,EMPTY); 
					setClear(i,j,false);
        }}
		setFocus(0);
        setScore(0);
        fillNext();
		needClear = false;
}

// **********************************************************************************************************************************
// Public Destructor
Model::~Model(){
        for (int i = 0 ; i < width ; i++){
                delete mapping[i];
				delete clear[i];
        }
        delete * mapping;
		delete * clear;
}

// **********************************************************************************************************************************
// Getters              
int Model::getWidth() const { return width; }
int Model::getHeight() const { return height; }
int Model::getDelay() const { return delay; }
int Model::getTimeline() const { return timeline; }
double Model::getScore() const { return score; }
Item Model::getMapping(int i,int j) const { return mapping[i][j]; }
bool Model::getClear(int i,int j) const { return clear[i][j]; }
std::list<Block> * Model::getNext() { return &next; }
std::list<Block> * Model::getFalling() { return &falling; }
int Model::getFocus() const { return focus; }

bool Model::getNeedClear() const { return needClear; }

// **********************************************************************************************************************************           
// Setters
void Model::setWidth(int w) { width = w; }
void Model::setHeight(int h) { height = h; }
void Model::setDelay(int d) { delay = d; }
void Model::setTimeline(int t) { timeline = t; }
void Model::setFocus(int f) { focus = f; }
void Model::setScore(double s) {score = s; } 
void Model::setMapping(int i,int j,Item c) { mapping[i][j] = c; }
void Model::setClear(int i,int j,bool c) { clear[i][j] = c; }

// **********************************************************************************************************************************           
// Common data manipulation method

// Build and return a random block
Block Model::makeRandomBlock(){
        Block b;
        for (int i = 0 ; i < 4 ; i++) b.data[i] = (Item)((rand() % 2)+1);
        return b;
}

// Increase start value for the focused block
void Model::increaseBlock(){
	std::list<Block>::iterator i = falling.begin();
	std::advance(i,focus);
	Block * b = &(*i);
	if (b == NULL) return;
	b->start == 0 ? b->start = 3 : b->start--;
}

// Switch focus to the next element in the queue
void Model::nextFocus(){ focus < falling.size()-1 ? focus++ : 0; }

// Switch focus to the forward element in the queue
void Model::forwardFocus(){ focus > 0 ? focus-- : falling.size()-1; }

// Move the focused block into the given direction
void Model::move(int side){
	std::list<Block>::iterator i = falling.begin();
	std::advance(i,focus);
	Block * b = &(*i);
	if (b == NULL) return;
	int x = (b->x - GRID_X) / 20;
	int y = (b->y - GRID_Y) / 20;
	switch(side){
		case DOWN : if (b->y <= GRID_Y +((height-3)*20) && mapping[x][y+2] == EMPTY && mapping[x+1][y+2] == EMPTY) b->y += 20; b->wait = WAIT; break;	
		case LEFT : if (b->x >= GRID_X + 20 && (b->y == 5 || (mapping[x-1][y] == EMPTY && mapping[x-1][y+1] == EMPTY)) ) b->x -= 20; break;
		case RIGHT : if (b->x <= GRID_X +((width-3)*20) && ( b->y == 5 || (mapping[x+2][y] == EMPTY && mapping[x+2][y+1] == EMPTY))) b->x += 20; break;
}}

// Fill the next block queue with random block
void Model::fillNext(){
        for (int i = 0 ; i < NEXT ; i++){
                Block b = makeRandomBlock();
                b.x = 6;
                b.y = 17 + (i * 40) + (i*5); 
                next.push_back(b);
        }
}

// Pop the top block from the next block queue and push it into the falling block queue
void Model::popNextItem(){
        Block out = next.front();
        pushFallingItem(out);
        next.pop_front();
		for (std::list<Block>::iterator i = next.begin(); i != next.end(); i++) (&(*i))->y -= 45;
		Block in = makeRandomBlock();
		in.x = 6;
		in.y = 152;
        next.push_back(in);
}

// Push the given block into the falling block queue
void Model::pushFallingItem(Block b){
        b.speed = 0.5;
		b.y = GRID_Y - 40;
		b.x = GRID_X + ((rand() % (width-1)) * 20);
		falling.push_back(b);
}

// Connect the given block to the grid
void Model::connect(Block * b){
	// Connection
	int i = (b->x - GRID_X) / 20;
	int j = (b->y - GRID_Y) / 20;
	int k = b->start , l = 0;
	do {
		mapping[i+((l == 1 || l == 2) ? 1 : 0)][j+(l == 2 || l == 3 ? 1 : 0)] = b->data[k];
		k == 3 ? k = 0 : k++;
	} while ( ++l < 4 );
}

// Clear the full block 
void Model::updateClear(){
	int k = 0;
	for (int i = 0 ; i < width ; i++){
		for (int j = 0 ; j < height ; j++){
			// Check for elimination
			if (clear[i][j]){
				mapping[i][j] = EMPTY;
				clear[i][j] = false;
				k++;
	}}}
	score += (double)((k * k) * 5);
	needClear = false;
}

// Update mapping grid, check for full block and collision into the grid
void Model::updateMapping(){
	needClear = false;
	for (int i = 0 ; i < width ; i++){
		for (int j = 0 ; j < height ; j++){
			// Check for falling block
			if (j < height-1 && mapping[i][j+1] == EMPTY) {
				mapping[i][j+1] = mapping[i][j];
				mapping[i][j] = EMPTY;
			}
			// Check for uniform block
			if (i < width-1 && j < height-1 && mapping[i][j] != EMPTY && mapping[i][j] == mapping[i+1][j] && mapping[i][j] == mapping[i][j+1] && mapping[i][j] == mapping[i+1][j+1]) 
				clear[i][j] = clear[i+1][j] = clear[i][j+1] = clear[i+1][j+1] = true;
			// Check for cleared status
			if (clear[i][j]){
				bool cleared = false;
				if (i < width-1 && j < height-1) cleared = cleared || (mapping[i][j] != EMPTY && mapping[i][j] == mapping[i+1][j] && mapping[i][j] == mapping[i][j+1] && mapping[i][j] == mapping[i+1][j+1]);
				if (i < width-1 && j > 0) cleared = cleared || (mapping[i][j] != EMPTY && mapping[i][j] == mapping[i+1][j] && mapping[i][j] == mapping[i+1][j-1] && mapping[i][j] == mapping[i][j-1]);	
				if (i > 0 && j > 0) cleared = cleared || (mapping[i][j] != EMPTY && mapping[i][j] == mapping[i-1][j-1] && mapping[i][j] == mapping[i][j-1] && mapping[i][j] == mapping[i-1][j]);	
				if (i > 0 && j < height-1) cleared = cleared || (mapping[i][j] != EMPTY && mapping[i][j] == mapping[i-1][j] && mapping[i][j] == mapping[i-1][j+1] && mapping[i][j] == mapping[i][j+1]);	
				clear[i][j] = cleared;
				if (cleared) needClear = true;
	}}}
}

// Update falling block, check for collision of falling blocks and connect them if needed
Signal Model::updateFalling(){
	std::list<std::list<Block>::iterator> deleteList;
	for (std::list<Block>::iterator i = falling.begin() ; i != falling.end() ; i++){
		Block b = (*i);
		int x = (b.x - GRID_X) / 20;
		int y = (b.y - GRID_Y) / 20;
		// If need to fall again
		if (y+2 < height && mapping[x][y+2] == EMPTY && mapping[x+1][y+2] == EMPTY && b.wait == WAIT) (*i).y += b.speed;
		// Or to connect it to the grid
		else if (b.y == 5 && b.wait == WAIT) return SIGLOST;
		else if (b.y == 5 && b.wait != WAIT) (*i).wait++;
		else {
			connect(&b);		
			deleteList.push_back(i);
			popNextItem();
		}
	}
	for (std::list<std::list<Block>::iterator>::iterator i = deleteList.begin() ; i != deleteList.end() ; i++)	falling.erase(*i);
	// Checking for focus pointer 
	if ( focus > falling.size() ) focus = 0;
	return SIGDONE;
}
