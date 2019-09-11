class BasicEnemy extends Character {
  //fields
  String type;
  PVector accel;
  int shotTimer = 40;
  
  //projectiles array list
  ArrayList<Projectile> projs = new ArrayList<Projectile>();
  
  //constructor
  BasicEnemy (PVector pos, String type) {
    super(pos);
    dim = new PVector(1, 1);
    this.type = type;
  }
  
  //update method to call movement and rendering
  void update () {
    render(elcri, type);
    
    //for level 3 enemies who fire bullets
    if (type.equals("Forest One") || type.equals("Forest Two")) {
      //firing bullets at incremented time
      if(shotTimer <= 0) {
        fire();
        shotTimer = 40;
      }
      shotTimer--;
      
      //bullet drawing and enemy hit detection with bullet
      for (int i = 0; i < projs.size(); i++) {
        Projectile p = projs.get(i);
        p.update();
        p.render(elcri);
        if (p.hit(elcri)) {
          if(elcri.hitTimer == 0) {
            elcri.health-=2;
            playSound(HIT);
          }
          elcri.hitTimer = 10;
        }
        for(int j =0; j<tilesThree.size(); j++) {
          Tile t = tilesThree.get(j);
          if (t.projCollision(p)) p.isAlive = false;
        }
        if (!p.isAlive) projs.remove(i); 
      }
    }
    //movement call
    move();
  }
  
  //method to move either back and forth or up and down depending on enemy
  void move () {
    pos.add(vel);
    accelerate(accel);
  }
  
  //method for level 3 enemies to fire projectiles
  void fire () {
    projs.add(new Projectile(new PVector(pos.x, pos.y), new PVector(-8, 0)));  
  }
  
  //rendering of enemies and declaring their size and movement direction
  void render (Character c, String type) {
    //level 1 enemies
    if (type.equals("Mountain One")) {
      accel = new PVector(0.2, 0);
      pushMatrix();
      translate(-c.pos.x+tileSize+c.dim.x/2+pos.x, -c.pos.y+tileSize+c.dim.y/2+pos.y);
      dim = new PVector(38, 34);
      image(mountainEnemy1,0, 0);
      popMatrix();
    }
    if (type.equals("Mountain Two")) {
      accel = new PVector(0, 0.2);
      pushMatrix();
      translate(-c.pos.x+tileSize+c.dim.x/2+pos.x, -c.pos.y+tileSize+c.dim.y/2+pos.y);
      dim = new PVector(30, 50);
      image(mountainEnemy2, 0, 0);
      popMatrix();
    }
    
    //level 2 enemies
    if (type.equals("Ocean One")) {
      accel = new PVector(0, 0.2);
      pushMatrix();
      translate(-c.pos.x+tileSize+c.dim.x/2+pos.x, -c.pos.y+tileSize+c.dim.y/2+pos.y);
      dim = new PVector(38, 36);
      image(oceanEnemy1, 0, 0);
      popMatrix();
    }
    if (type.equals("Ocean Two")) {
      accel = new PVector(0.2, 0);
      pushMatrix();
      translate(-c.pos.x+tileSize+c.dim.x/2+pos.x, -c.pos.y+tileSize+c.dim.y/2+pos.y);
      dim = new PVector(52, 31);
      image(oceanEnemy2, 0, 0);
      popMatrix();
    }
    
    //level 3 enemies
    if (type.equals("Forest One")) {
      accel = new PVector(0, 0.2);
      pushMatrix();
      translate(-c.pos.x+tileSize+c.dim.x/2+pos.x, -c.pos.y+tileSize+c.dim.y/2+pos.y);
      dim = new PVector(35, 53);
      image(forestEnemy1, 0, 0);
      popMatrix();
    }
    if (type.equals("Forest Two")) {
      accel = new PVector(0.2, 0);
      pushMatrix();
      translate(-c.pos.x+tileSize+c.dim.x/2+pos.x, -c.pos.y+tileSize+c.dim.y/2+pos.y);
      dim = new PVector(35, 53);
      image(forestEnemy1, 0, 0);
      popMatrix();
    }
  }
}