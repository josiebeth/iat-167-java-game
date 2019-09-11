class Projectile {
  //fields
  PVector pos, vel, dim;
  boolean isAlive;
  
  //constructor
  Projectile (PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    dim = new PVector(10, 10);
    isAlive = true;
  }
  
  //update method
  void update () {
    pos.add(vel);
  }
  
  //renders projectile for level 3 enemies
  void render (Character c) {
    pushMatrix();
    translate(-c.pos.x+tileSize+c.dim.x/2+pos.x, -c.pos.y+tileSize+c.dim.y/2+pos.y);
    stroke(0, 0, 0, 50);
    fill(0);
    ellipse(0, 0, dim.x, dim.y);
    popMatrix();
  }
  
  //renders projectile for elcri in boss battle
  void renderElcri () {
    image(arrow, pos.x, pos.y);
  }
  
  //hit character method
  boolean hit (Character c) {
    if(abs(pos.x - c.pos.x) < dim.x/2 + c.dim.x/2 && abs(pos.y - c.pos.y) < dim.y/2 + c.dim.y/2) return true;
    return false;  
  }
}