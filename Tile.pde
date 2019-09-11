class Tile {
   //fields
   PVector pos, diff, absDiff;
   PImage img;
   boolean wall;
   
   //constructor
   Tile (String path, PVector pos, boolean wall) {
     img = loadImage(path);
     this.pos = pos;
     this.wall = wall;
   }
   
   //checking for collision with the wall blocks
   void collision (Character c, float velChange, float posChange) {
     diff = PVector.sub(c.pos, pos);
     absDiff = new PVector(abs(diff.x), abs(diff.y));
     if(wall && absDiff.x<c.dim.x/2+img.width/2 && absDiff.y<c.dim.y/2+img.height/2) {
       c.pos.x += diff.x*posChange;
       c.pos.y += diff.y*posChange;
       c.vel.mult(velChange);
     }
   }
   
   //checking for collision with any projectiles
   boolean projCollision (Projectile p) {
     diff = PVector.sub(p.pos, pos);
     absDiff = new PVector(abs(diff.x), abs(diff.y));
     if(wall && absDiff.x<p.dim.x/2+img.width/2 && absDiff.y<p.dim.y/2+img.height/2) return true;
     return false;
   }
   
   //method to check if tiles are in window and should be rendered
   boolean inWindow () {
     if(absDiff.x<width && absDiff.y<height) {
       return true;  
     } else {
       return false;  
     }
   }
   
   //method for drawing tiles to screen
   void render (Character c) {
     pushMatrix();
     translate(-c.pos.x+tileSize+c.dim.x/2+pos.x, -c.pos.y+tileSize+c.dim.y/2+pos.y);
     scale(1.04, 1.04);
     imageMode(CORNER);
     image(img, -img.width/2, -img.height/2);
     popMatrix();
   }
}