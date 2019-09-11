class Princess extends Character {
  //fields
  int powerUpTimer = -3;
  int hitTimer = 0;
  int shotTimer = 2;
  //fields for sequencing
  int currentFrame=0;
  float damp = 0.8; 
  PImage[] standing = new PImage[1];
  PImage[] standingSpeed = new PImage[1];
  PImage[] standingFreeze = new PImage[1];
  PImage[] walking = new PImage[4];  
  PImage[] speed = new PImage[4];
  PImage[] freeze = new PImage[4];
  PImage[] frames;
  int seqState = 0;
  
  //array list for projectiles
  ArrayList<Projectile> projs = new ArrayList<Projectile>();
  
  //constructor
  Princess(PVector pos) {
    super(pos);  
    dim = new PVector(32, 57);
    health = 10;
    fire = false;
    
    //all standing images
    standing[0] = loadImage("images/elcri/elcri_0.png");
    standingSpeed[0] = loadImage("images/elcri/elcriSpeed_0.png");
    standingFreeze[0] = loadImage("images/elcri/elcriFreeze_0.png");

    frames = standing;
    //initializing all walking arrays
    for (int i = 0; i < walking.length; i++) {
      walking[i] = loadImage("images/elcri/elcri_" + i + ".png");
      speed[i] = loadImage("images/elcri/elcriSpeed_" + i + ".png");
      freeze[i] = loadImage("images/elcri/elcriFreeze_" + i + ".png");
    }
  }
  
  void changeFrame(PImage[]list) {
    //the PImage reference for character is now
    //the frame in the list we want
    frames = list;
  }
  
  //updating movement method as well as rendering
  void update () {
    super.update(); 
    render();
    if (hitTimer > 0) hitTimer--;
    if(shotTimer <= 0) {
        shotTimer = 2;
     }
     shotTimer--;
     
     //projectiles for the boss battle rendering and updating
     if (state == BOSS) {
       for (int i = 0; i < projs.size(); i++) {
         Projectile p = projs.get(i);
         p.update();
         p.renderElcri();
         if (p.hit(tagon)) {
           if(tagon.hitTimer == 0) {
             tagon.health-=1;
             tagon.hitTimer = 10;
           }
         }
         if (p.pos.x > 1000-dim.x/2 || p.pos.x < 0+dim.x/2 || p.pos.y > 600-dim.y/2 || p.pos.y < 0+dim.y/2) p.isAlive = false;
         if (!p.isAlive) projs.remove(i); 
       }
     }
     
     //sequencing state switching depending on if power up is aquired or not
     if (frameCount % 5 == 0) {
      currentFrame++;
      switch (seqState) {
      case 1:
       if (currentFrame == walking.length) {
         currentFrame = 0;
       }
       changeFrame(walking);
       break;
      case 2:
       if (currentFrame == speed.length) {
         currentFrame = 0;
       }
       changeFrame(speed);
       break;
      case 3:
       if (currentFrame == freeze.length) {
         currentFrame = 0;
       }
       changeFrame(freeze);
       break;
      case 4:
       currentFrame = 0;
       changeFrame(standingSpeed);
       break;
      case 5:
       currentFrame = 0;
       changeFrame(standingFreeze);
       break;
      default:
       currentFrame = 0;
       changeFrame(standing);
       break;
      }
    }
   }
  
  //method to fire arrows when in boss battle
  void fire () {
    projs.add(new Projectile(new PVector(pos.x, pos.y), new PVector(6, 0)));  
  }
  
  //method to draw princess character
  void render () {
    imageMode(CENTER);
    PImage img = frames[currentFrame];
    //changing hats when powerups are being used
    //power up types: 0 = speed, 1 = freeze
    if (curPUType == 0 && powerUpUsed) {
      image(img, tileSize+dim.x/2, tileSize+dim.y/2, dim.x, dim.y);
    } else if (curPUType == 1 && powerUpUsed) {
      image(img, tileSize+dim.x/2, tileSize+dim.y/2, dim.x, dim.y);
    } else if (state == BOSS) {
      image(princessBoss, pos.x, pos.y, dim.x, dim.y);
    } else if (restart) {
      image(img, tileSize+dim.x/2, tileSize+dim.y/2, dim.x, dim.y);
    } else { 
      image(img, tileSize+dim.x/2, tileSize+dim.y/2, dim.x, dim.y);
    }
  }
}