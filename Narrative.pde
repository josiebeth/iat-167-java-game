// states for each different narrative frame
final int FIRST = 0;
final int SECOND = 1;
final int THIRD = 2;
final int FOURTH = 3;
final int FIFTH = 4;
final int SIXTH = 5;
final int SEVENTH = 6;
final int EIGTH = 7;
final int CHOICE = 8;
final int ALONE = 9;
final int TOGETHER = 10;
final int KILL = 11;
final int SPARE = 12;
int frame = CHOICE;

//giving user time to click each one
int frameTimer = 30;

//position variables for narrative functions
float xPosFirst = 400;
float yPosFirst = 160;
float xPosSecond = 420;
float yPosSecond = 300;
float xPosThirdT = 150;
float yPosThirdT = 400;
float xPosThirdE = 380;
float yPosThirdE = 180;
float xPosSev = 290;
float yPosSev = 290;
float xPosKill = 320;
float yPosKill = 355;
float xPosSpare = 160;
float yPosSpare = 160;
float xPosTT = 750;
float yPosTT = 400;
float xPosTE = 380;
float yPosTE = 400;

//switching between frames when called
void narration () {
  switch (frame) {
    case FIRST: firstFrame(); break;
    case SECOND: secondFrame(); break;
    case THIRD: thirdFrame(); break;
    case FOURTH: fourthFrame(); break;
    case FIFTH: fifthFrame(); break;
    case SIXTH: sixthFrame(); break;
    case SEVENTH: seventhFrame(); break;
    case EIGTH: eigthFrame(); break;
    case CHOICE: choiceFrame(); break;
    case KILL: killTagon(); break;
    case SPARE: spareTagon(); break;
    case ALONE: aloneEnding(); break;
    case TOGETHER: togetherEnding(); break;
  }
  if (frameTimer > 0) frameTimer--;
}

//frame one before level one
void firstFrame() {
  pushMatrix();
  if (restart) translate(width/2, height/2);
  image(firstFrame, 0, 0);
  popMatrix();
  pushMatrix();
  if (restart) translate(200, 200);
  image(firstFrameElcri, xPosFirst, yPosFirst);
  popMatrix();
  if (xPosFirst < 530) xPosFirst += 0.75;
  if (yPosFirst < 190) yPosFirst += 0.2;
  
  if (mousePressed && frameTimer <= 0) {
    frameTimer = 30;
    frame = SECOND;
  }
}

//frame two before level one
void secondFrame() {
  pushMatrix();
  if (restart) translate(width/2, height/2);
  image(secondFrame, 0, 0);
  popMatrix();
  pushMatrix();
  if (restart) translate(200, 200);
  image(secondFrameTagon, xPosSecond, yPosSecond);
  popMatrix();
  if (xPosSecond < 520) xPosSecond += 0.75;
  
  if (mousePressed && frameTimer <= 0) {
    frameTimer = 30;
    frame = THIRD;
  }
}

//frame 3 before level 1
void thirdFrame() {
  pushMatrix();
  if (restart) translate(width/2, height/2);
  image(thirdFrame, 0, 0);
  popMatrix();
  pushMatrix();
  if (restart) translate(100, 100);
  image(thirdFrameTagon, xPosThirdT, yPosThirdT);
  image(thirdFrameElcri, xPosThirdE, yPosThirdE);
  popMatrix();
  if (xPosThirdT < 170) xPosThirdT += 0.1;
  if (yPosThirdT > 370) yPosThirdT -= 0.2;
  if (xPosThirdE < 420) xPosThirdE += 0.3;
  if (yPosThirdE > 150) yPosThirdE -= 0.3;
  
  if (mousePressed && frameTimer <= 0) {
    frameTimer = 30;
    state = LEVEL_ONE;
    elcri.pos.x = tileSize*3;
    elcri.pos.y = tileSize*8;
    tagon.pos.x = tileSize;
    tagon.pos.y = elcri.pos.y;
    if (restart) {
      elcri.dim.x /= 2;
      elcri.dim.y /= 2;
    }
  }
}

//frame one before level 2
void fourthFrame() {
  image(fourthFrame, width/2, height/2);
  if (mousePressed && frameTimer <= 0) {
    frameTimer = 30;
    frame = FIFTH;
  }
}

//frame two before level 2
void fifthFrame () {
  image(fifthFrame, width/2, height/2);
  if (mousePressed && frameTimer <= 0) {
    frameTimer = 30;
    state = LEVEL_TWO;
  }
}

//frame one before level 3
void sixthFrame () {
  image(sixthFrame, width/2, height/2);
  if (mousePressed && frameTimer <= 0) {
    frameTimer = 30;
    frame = SEVENTH;
  }
}

//frame two before level 3
void seventhFrame () {
  image(seventhFrame, width/2, height/2);
  image(seventhFrameElcri, xPosSev, yPosSev);
  if (xPosSev < 305) xPosSev += 0.5;
  
  if (mousePressed && frameTimer <= 0) {
    frameTimer = 30;
    state = LEVEL_THREE;
  }
}

//frame before boss battle
void eigthFrame () {
  image(eigthFrame, width/2, height/2);
  if (mousePressed && frameTimer <= 0) {
    frameTimer = 30;
    elcri.dim.mult(2);
    tagon.dim.mult(3);
    state = BOSS;
  }
}

//frame where decision is made to kill or spare the abductor
void choiceFrame () {
  image(choiceFrame, width/2, height/2);
  if (mousePressed && mouseX > 30 && mouseX < 260 && mouseY > 160 && mouseY < 280 && frameTimer <= 0) {
    frameTimer = 30;
    frame = SPARE;
  }
  if (mousePressed && mouseX > 720 && mouseX < 970 && mouseY > 170 && mouseY < 310 && frameTimer <= 0) {
    frameTimer = 30;
    frame = KILL;
  }
}

//killing frame
void killTagon () {
  image(killTagonFrame, width/2, height/2);
  image(killTagonElcri, xPosKill, yPosKill);
  if (xPosKill < 365) xPosKill += 1;
  
  if (mousePressed && frameTimer <= 0) {
    frameTimer = 30;
    frame = ALONE;
  }
}

//sparing frane
void spareTagon () {
  image(spareTagon, width/2, height/2);
  image(spareArrow, xPosSpare, yPosSpare);
  if (xPosSpare > 100) xPosSpare -= 0.8;
  if (yPosSpare > 100) yPosSpare -= 0.8;
  
  if (mousePressed && frameTimer <= 0) {
    frameTimer = 30;
    frame = TOGETHER;
  }
}

//ending after killing abductor
void aloneEnding () {
  background(0);
  image(aloneEnding, width/2, height/2);
  
  if (mousePressed && frameTimer <= 0) {
    frameTimer = 30;
    state = WIN;
  }
}

//ending after sparing abductor
void togetherEnding () {
  background(255);
  image(togetherEnding, width/2, height/2);
  image(togetherTagon, xPosTT, yPosTT);
  image(togetherElcri, xPosTE, yPosTE);
  if (xPosTT > 690) xPosTT -= 1;
  if (xPosTE < 450) xPosTE += 1;
  
  if (mousePressed && frameTimer <= 0) {
    frameTimer = 30;
    state = WIN;
  }
}