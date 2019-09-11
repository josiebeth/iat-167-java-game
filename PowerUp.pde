class PowerUp {
  //fields
  PVector pos;
  boolean collected = false;
  PVector diff, absDiff;
  int powerUpTimer = 0;
  int healthTimer = 0;
  int randomType;
  int packsCollected = 0;
  
  //constructor
  PowerUp (PVector pos) {
    this.pos = pos;
    randomType = (int) random(0, 2);
  }
 
  //renders power ups and removes them if collected
  void render (Character c) {
    if (randomType == 0) {
      pushMatrix();
      translate(-c.pos.x+tileSize+c.dim.x/2+pos.x, -c.pos.y+tileSize+c.dim.y/2+pos.y);
      image(speedPU, 0, 0);
      popMatrix();
    } else if (randomType == 1) {
      pushMatrix();
      translate(-c.pos.x+tileSize+c.dim.x/2+pos.x, -c.pos.y+tileSize+c.dim.y/2+pos.y);
      image(freezePU, 0, 0);
      popMatrix();
    } 
    
    //making the power ups disappear when touched by player
    if (powerUpTimer > 1) {
     pushMatrix();
     translate(-c.pos.x+tileSize+c.dim.x/2+pos.x, -c.pos.y+tileSize+c.dim.y/2+pos.y);
     fill(100, 197, 14);
     stroke(0);
     triangle(0, 10, -20, 0, 0, -10);
     popMatrix();
     powerUpTimer--;
    }
  }
  
  //renders the health pack which gives princess health, as well as defining end of level
  void renderHealthPack (Character c) {
    pushMatrix();
    translate(-c.pos.x+tileSize+c.dim.x/2+pos.x, -c.pos.y+tileSize+c.dim.y/2+pos.y);
    image(health, 0, 0);
    popMatrix();
    
    //if collected then draw accordingly
    if (healthTimer > 1) {
     pushMatrix();
     translate(-c.pos.x+tileSize+c.dim.x/2+pos.x, -c.pos.y+tileSize+c.dim.y/2+pos.y);
     fill(255, 0, 255);
     stroke(0, 0, 255);
     ellipse(0, 0, 50, 50);
     popMatrix();
     healthTimer--;
    }
  }
  
  //method to test if princess is touching the power up or health pack
  boolean collected (Character c) {
     diff = PVector.sub(c.pos, pos);
     absDiff = new PVector(abs(diff.x), abs(diff.y));
     if(absDiff.x < c.dim.x/2+20/2 && absDiff.y < c.dim.y/2+20/2) {
       powerUpTimer = 8;
       healthTimer = 3;
       return true;
     }
     return false;
  }
}