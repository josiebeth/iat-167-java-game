class Abductor extends Character {
  //fields
  float angle;
  int hitTimer = 0;
  float topSpeed = 8;
  PVector accel;
  
  //constructor
  Abductor(PVector pos) {
    super(pos);
    dim = new PVector(35, 35);
    health = 25;
  }
  
  //method to update movement and rendering
  void update() {
    render(elcri);
      followPrincess();
    if (hitTimer > 0) hitTimer--;
  }
  
  //moving method to follow the princess around the screen
  void followPrincess() {
    angle = atan2(elcri.pos.y- pos.y, elcri.pos.x-pos.x); 
    PVector vel = PVector.fromAngle(angle);
    if (state == BOSS) {
      vel.mult(5);
    } else {
      vel.mult(3.5);
    }
    pos.add(vel);
  }
  
  //method to render image depending on state
  void render(Character c) {
    pushMatrix();
    if (state == BOSS) {
      translate(pos.x, pos.y);
      image(tagonBoss, 0, 0);
    } else {
      translate(-c.pos.x+tileSize+c.dim.x/2+pos.x, -c.pos.y+tileSize+c.dim.y/2+pos.y);
      image(abductor, 0, 0);
    }
    popMatrix();
  }
}