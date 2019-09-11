//level 1 function
void levelOne () {
  background(0);
  //player keyboard movement
  if(up) elcri.accelerate(upAccel);
  if(down) elcri.accelerate(downAccel);
  if(left) elcri.accelerate(leftAccel);
  if(right) elcri.accelerate(rightAccel);
  
  //tile rendering with tile collision for player and enemies
  for(int i =0; i<tilesOne.size(); i++) {
    Tile t = tilesOne.get(i);
    t.collision(elcri, 0, 0.05);
    if(t.inWindow()) t.render(elcri);
    for (int j =0; j<ba1.size(); j++) {
      t.collision(ba1.get(j), -1, 1);
    }
  }
  
  //player  and abductor rendering and updating
  elcri.update();
  tagon.update();
  if (tagon.hitCharacter(elcri)) {
    if(elcri.hitTimer == 0) {
        elcri.health-=1;
        playSound(HIT);
     }
     elcri.hitTimer = 10;
  }
  
  //enemy rendering, updating and chesking for hits with player
  for(int i =0; i<ba1.size(); i++) {
    ba1.get(i).update(); 
    //enemy hit detection and health reduction for princess
    if(ba1.get(i).hitCharacter(elcri)) {
      if(elcri.hitTimer == 0) {
        elcri.health-=2;
        playSound(HIT);
      }
      elcri.hitTimer = 10;
    }
  }
  
  //rendering healthpacks and collection detection with player
  healthPack1.renderHealthPack(elcri);
  if (healthPack1.collected(elcri)) {
    healthPack1.packsCollected++;
    state = NARRATION;
    frame = FOURTH;
    elcri.health+=10;
    elcri.pos.x = 3*tileSize;
    elcri.pos.y = 13*tileSize;
    tagon.pos.x = tileSize;
    tagon.pos.y = 12*tileSize;
  }
  
  //power up rendering and collection detection with princess
  for(int i=0; i<pu1.size(); i++) {
    pu1.get(i).render(elcri);
    if (pu1.get(i).collected(elcri)) {
      curPUType = pu1.get(i).randomType;
      pu1.remove(i);
      score += 10;
      playSound(POWER_UP);
      curPU=1;
      elcri.powerUpTimer = 120;
    }
  }

  //activating and deactivating the speed and freeze power ups
  if (powerup && curPU >0) {
    powerUpUsed = true;
  }
  if (powerUpUsed) {
    elcri.powerUpTimer--;
    if (curPUType == 0) {
      elcri.vel.mult(1.2);  
      speed = 4;
    }
    if (curPUType == 1) {
      for (int i =0; i<ba1.size(); i++) {
        ba1.get(i).vel.x = 0;
        ba1.get(i).vel.y = 0;
      }
    }
  }
  if (elcri.powerUpTimer == -3 && curPUType == 0) {
    speed = 3;
    elcri.vel.mult(elcri.damp);
    curPUType = 3;
    curPU = 0;
    powerUpUsed = false;
  }
  if (elcri.powerUpTimer == -3 && curPUType == 1) {
    for (int i =0; i<ba1.size(); i++) {
      if (ba1.get(i).type.equals("Mountain One")) ba1.get(i).vel.x = 1;
      if (ba1.get(i).type.equals("Mountain Two")) ba1.get(i).vel.y = 1;
    }
    curPUType = 3;
    curPU = 0;
    powerUpUsed = false;
  }
  
  //HUD rendering
  HUD();
  
  //game over condition --> player health gone
  if (elcri.health <= 0) state = LOSE;
}

//level 2 function
void levelTwo () {
   background(0);
  //player keyboard movement
  if(up) elcri.accelerate(upAccel);
  if(down) elcri.accelerate(downAccel);
  if(left) elcri.accelerate(leftAccel);
  if(right) elcri.accelerate(rightAccel);
  
  //tile rendering and checking hit detection with player and enemies
  for(int i =0; i<tilesTwo.size(); i++) {
    Tile t = tilesTwo.get(i);
    t.collision(elcri, 0, 0.05);
    if(t.inWindow()) t.render(elcri);
    for(int j=0; j<ba2.size(); j++) {
      t.collision(ba2.get(j), -1, 1);
    }
  }
  
  //player and abductor rendering
  elcri.update();
  tagon.update();
  if (tagon.hitCharacter(elcri)) {
    if(elcri.hitTimer == 0) {
        elcri.health-=1;
        playSound(HIT);
     }
     elcri.hitTimer = 10;
  }
  
  //enemies rendering and checking hits with player
  for (int i =0; i<ba2.size(); i++) {
    ba2.get(i).update();
    //enemy hit detection and health reduction for princess
    if(ba2.get(i).hitCharacter(elcri)) {
      if(elcri.hitTimer == 0) {
        elcri.health-=2;
        playSound(HIT);
      }
      elcri.hitTimer = 10;
    }
  }
  
  //health pack rendering and checking if collected by player
  healthPack2.renderHealthPack(elcri);
  if (healthPack2.collected(elcri)) {
    healthPack2.packsCollected++;
    elcri.pos.x = tileSize*2;
    elcri.pos.y = 3*tileSize;
    tagon.pos.x = tileSize;
    tagon.pos.y = 3*tileSize;
    elcri.health += 10;
    state = NARRATION;
    frame = SIXTH;
  }
  
  //power up rendering and collection detection with princess
  for(int i=0; i<pu2.size(); i++) {
    pu2.get(i).render(elcri);
    if (pu2.get(i).collected(elcri)) {
      curPUType = pu2.get(i).randomType;
      pu2.remove(i);
      score += 10;
      playSound(POWER_UP);
      curPU = 1;
      elcri.powerUpTimer = 120;
    }
  }
  
  //activating and deactivating the speed power up
  if (powerup && curPU >0) {
    powerUpUsed = true;
  }
  if (powerUpUsed) {
    elcri.powerUpTimer--;
    if (curPUType == 0) {
      elcri.vel.mult(1.2);  
      speed = 4;
    }
    if (curPUType == 1) {
      for (int i =0; i<ba1.size(); i++) {
        ba2.get(i).vel.x = 0;
        ba2.get(i).vel.y = 0;
      }
    }
  }
  if (elcri.powerUpTimer == -3 && curPUType == 0) {
    speed = 3;
    elcri.vel.mult(elcri.damp);
    curPUType = 3;
    curPU = 0;
    powerUpUsed = false;
  }
  if (elcri.powerUpTimer == -3 && curPUType == 1) {
    for (int i =0; i<ba2.size(); i++) {
      if (ba2.get(i).type.equals("Mountain One")) ba2.get(i).vel.x = 1;
      if (ba2.get(i).type.equals("Mountain Two")) ba2.get(i).vel.y = 1;
    }
    curPUType = 3;
    curPU = 0;
    powerUpUsed = false;
  }
  
  //HUD rendering
  HUD();
  
  //game over condition --> player health gone
  if (elcri.health <= 0) state = LOSE;
}

//level 3 function
void levelThree () {
  background(0);
  //player keyboard movement
  if(up) elcri.accelerate(upAccel);
  if(down) elcri.accelerate(downAccel);
  if(left) elcri.accelerate(leftAccel);
  if(right) elcri.accelerate(rightAccel);
  
  //rendering tiles and checking for hits with player and enemies
  for(int i =0; i<tilesThree.size(); i++) {
    Tile t = tilesThree.get(i);
    t.collision(elcri, 0, 0.05);
    if(t.inWindow()) t.render(elcri);
    for(int j=0; j<ba3.size(); j++) {
      t.collision(ba3.get(j), -1, 1);
    }
  }
  
  //player and abductor rendering and hit detection
  elcri.update();
  tagon.update();
  if (tagon.hitCharacter(elcri)) {
    if(elcri.hitTimer == 0) {
        elcri.health-=1;
        playSound(HIT);
     }
     elcri.hitTimer = 10;
  }
  
  //enemies rendering and player hit detection
  for (int i =0; i<ba3.size(); i++) {
    ba3.get(i).update();
    //enemy hit detection and health reduction for princess
    if(ba3.get(i).hitCharacter(elcri)) {
      if(elcri.hitTimer == 0) {
        elcri.health-=2;
        playSound(HIT);
      }
      elcri.hitTimer = 10;
    }
  }
  
  //health pack rendering and collection detection with player
  healthPack3.renderHealthPack(elcri);
  if (healthPack3.collected(elcri)) {
    healthPack3.packsCollected++;
    state = NARRATION;
    frame = EIGTH;
    elcri.pos.x = 100;
    elcri.pos.y = height/2;
    tagon.pos.x = elcri.pos.x - 800;
    tagon.pos.y = height/2;
  }
  
  //power up rendering and collection detection with princess
  for(int i=0; i<pu3.size(); i++) {
    pu3.get(i).render(elcri);
    if (pu3.get(i).collected(elcri)) {
      curPUType = pu3.get(i).randomType;
      pu3.remove(i);
      score += 10;
      playSound(POWER_UP);
      curPU = 1;
      elcri.powerUpTimer = 120;
    }
  }
  
  //activating and deactivating the speed power up
  if (powerup && curPU >0) {
    powerUpUsed = true;
  }
  if (powerUpUsed) {
    elcri.powerUpTimer--;
    if (curPUType == 0) {
      elcri.vel.mult(1.2);  
      speed = 4;
    }
    if (curPUType == 1) {
      for (int i =0; i<ba3.size(); i++) {
        ba3.get(i).vel.x = 0;
        ba3.get(i).vel.y = 0;
      }
    }
  }
  if (elcri.powerUpTimer == -3 && curPUType == 0) {
    speed = 3;
    elcri.vel.mult(elcri.damp);
    curPUType = 3;
    curPU = 0;
    powerUpUsed = false;
  }
  if (elcri.powerUpTimer == -3 && curPUType == 1) {
    for (int i =0; i<ba3.size(); i++) {
      if (ba3.get(i).type.equals("Mountain One")) ba2.get(i).vel.x = 1;
      if (ba3.get(i).type.equals("Mountain Two")) ba2.get(i).vel.y = 1;
    }
    curPUType = 3;
    curPU = 0;
    powerUpUsed = false;
  }
  
  //HUD rendering
  HUD();
  
  //game over condition --> player health gone
  if (elcri.health <= 0) state = LOSE;
}

void bassBattle () {
  background(255);
  //BG image
  image(battleBG, width/2, height/2);
  
  //player keyboard movement
  if(up) elcri.accelerate(upAccel);
  if(down) elcri.accelerate(downAccel);
  if(left) elcri.accelerate(leftAccel);
  if(right) elcri.accelerate(rightAccel);
  
  //rendering and updating player and abductor
  elcri.update();
  tagon.update();
  if (tagon.hitCharacter(elcri)) {
    if(elcri.hitTimer == 0) {
        elcri.health-=1;
        playSound(HIT);
     }
     elcri.hitTimer = 10;
  }
  
  //firing projectiles
  if (fire && elcri.shotTimer <= 0) elcri.fire();
  
  //HUD rendering
  HUD();
  
  //abductor health end condition
  if (tagon.health == 1) {
    state = NARRATION;
    frame = CHOICE;
  }
  
  //player health end condition
  if (elcri.health <= 0) state = LOSE;
}

//static mouse interactive screens
//start screen with instructions button and start button
void startScreen () {
  pushMatrix();
  if (restart) translate(width/2, height/2);
  image(start, 0, 0);
  popMatrix();
  if(mouseX > 51 && mouseX < 313 && mouseY > 355 && mouseY < 438) {
    if(mousePressed) {
      state = NARRATION;
      frame = FIRST;
    }
  }
  if (mouseX > 51 && mouseX < 461 && mouseY > 469 && mouseY < 552 && mousePressed) {
    state = INSTRUCTIONS;
  }
}

//instructions screen
void instructions () {
  pushMatrix();
  if (restart) translate(width/2, height/2);
  image(instructions, 0, 0);
  popMatrix();
  if (mouseX > 834 && mouseX < 971 && mouseY > 518 && mouseY < 573 && mousePressed) {
    state = START;  
  }
}

//screen displayed when game is lost
void gameOver () {
  image(loss, width/2, height/2);
  if(mouseX > 771 && mouseX < 974 && mouseY > 518 && mouseY < 573) {
    if(mousePressed) {
      state = START;  
      elcri.health = 10;
      tagon.health = 20;
      score = 0;
      elcri.pos.x = 0;
      elcri.pos.y = 8*tileSize-64;
      restart = true;
    }
  }
}

//screen displayed when game is won
void winScreen () {
  image(win, width/2, height/2);
  if(mouseX > 771 && mouseX < 974 && mouseY > 518 && mouseY < 573) {
    if(mousePressed) {
      state = START;
      elcri.health = 10;
      tagon.health = 20;
      score = 0;
      elcri.pos.x = 0;
      elcri.pos.y = 8*tileSize-64;
      healthPack1.healthTimer = 0;
      restart = true;
    }
  }
}