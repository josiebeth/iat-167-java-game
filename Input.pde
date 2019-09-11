//variables for sizes
int tileSize = 64;
int score = 0;
int curPU = 0;
int curPUType = 3;
boolean powerUpUsed = false;

//variables for images and fonts
PImage princess, princessSpeed, princessFreeze, arrow, abductor, princessBoss, tagonBoss;
PImage mountainEnemy1, mountainEnemy2, oceanEnemy1, oceanEnemy2, forestEnemy1, freezePU, speedPU, health;
PImage start, instructions, win, loss, battleBG;
PImage firstFrame, firstFrameElcri, secondFrame, secondFrameTagon, thirdFrame, thirdFrameTagon, thirdFrameElcri;
PImage fourthFrame, fifthFrame, sixthFrame, seventhFrame, seventhFrameElcri, eigthFrame, choiceFrame, killTagonFrame, killTagonElcri;
PImage spareTagon, spareArrow, togetherEnding, togetherElcri, togetherTagon, aloneEnding;
PFont title;

//state variables
final int START = 0;
final int LEVEL_ONE = 1;
final int LEVEL_TWO = 2;
final int LEVEL_THREE = 3;
final int LOSE = 4;
final int WIN = 5;
final int INSTRUCTIONS = 6;
final int NARRATION = 7;
final int BOSS = 8;
int state = START;
//checking if the game has been restarted or not yet
boolean restart = false;

//keyboard control variables and functions
boolean up, down, left, right, powerup, fire;
float speed = 3;
PVector upAccel = new PVector(0, -speed);
PVector downAccel = new PVector(0, speed);
PVector leftAccel = new PVector(-speed, 0);
PVector rightAccel = new PVector(speed, 0);

void keyPressed () {
  if (curPUType == 0) elcri.seqState = 2;
  if (curPUType == 1) elcri.seqState = 3;
  if (curPUType == 3) elcri.seqState = 1;
  
  if (key == CODED && keyCode == UP)  up = true;  
  if (key == CODED && keyCode == DOWN) down = true; 
  if (key == CODED && keyCode == LEFT) left = true;
  if (key == CODED && keyCode == RIGHT) right = true; 
  if (key == 'e' || key == 'E') powerup = true;
  if (key == ' ') fire = true;
}

void keyReleased () {
  if (curPUType == 0) elcri.seqState = 4;
  if (curPUType == 1) elcri.seqState = 5;
  if (curPUType == 3) elcri.seqState = 0;
  
  if (key == CODED && keyCode == UP) up = false; 
  if (key == CODED && keyCode == DOWN) down = false; 
  if (key == CODED && keyCode == LEFT) left = false; 
  if (key == CODED && keyCode == RIGHT) right = false; 
  if (key == 'e' || key == 'E') powerup = false;
  if (key == ' ') fire = false;
}