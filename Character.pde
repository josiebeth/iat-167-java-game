class Character {
  //fields
  PVector pos, vel, dim;
  float damp = 0.8;
  int health;
  
  //constructor
  Character (PVector pos) {
    this.pos = pos;
    vel = new PVector();
    dim = new PVector(32, 32);
  }
  
  //acceleration method with PVector as parameter
  void accelerate (PVector accel) {
    vel.add(accel);  
  }
  
  //update the movement of the character
  void update () {
    vel.mult(damp);
    pos.add(vel);
  }
  
  //drawing the character method
  void render () {
    stroke(200);
    strokeWeight(2);
    fill(63);
    ellipse(tileSize+dim.x/2, tileSize+dim.y/2, dim.x, dim.y);  
  }
  
  //method for detecting hits between character objects
  boolean hitCharacter (Character c) {
    if((abs(pos.x - c.pos.x) < (dim.x/2 + c.dim.y/2)) && (abs(pos.y - c.pos.y) < (dim.y/2 + c.dim.y/2))) {
      return true;
    } else {
      return false;
    }
  }
}