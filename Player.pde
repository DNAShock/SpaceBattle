
/**
 * Class Player
 *
 * @attr: x, y, speedX, acc, maxSpeedX, life, <Bullet> bul, sprite.
 * @function: Player(float, float, String), update(), playerDamage(), setSprite(String), getLife(), show();
 */

class Player {
  float x, y;
  float speed;
  float maxSpeed;
  int life;
  ArrayList < Bullet > bul; 
  PImage sprite;
  
  Player(float x, float y, String path){
    this.x = x;
    this.y = y;
    sprite = loadImage(path);
    speed = 4.3;
    life = 3;
    bul = new ArrayList < Bullet > (maxBulletOnScreen);
  }
  void update(){
    
    // Right keys was pressed, and the player is above the screen.
    if(right && x + playerWidth < width){
      x += speed;
    }
    // Left keys was pressed, and the player is above the screen.
    if(left && x > 0){
      x -= speed;
    }
    // Fire keys was pressed.
    if((up || backspace) && fireOn){
      fireInProcess = true;
      fireOn = false;
      bul.add( new Bullet(x + playerWidth/2, y - playerHeight/2 - bulletHeight, bulletSpeed, "img/laserGreen.png") );
    }
    // The fire is in process, the bullets must be showed on the screen. 
    if(fireInProcess){
      for(int i = 0; i < bul.size(); i++){ 
        // Update and show bullet with a cicle for.
        if(!bul.get(i).isFinished() && !bul.get(i).collideWithEnemy()){
          bul.get(i).update();
          bul.get(i).show();
        }
        // If the cicle of i bullet is finished remove it!
        else bul.remove(i);
      }
      // The array of bullet is empty, fire isn't in process yet.
      if(bul.size() == 0){ 
        fireInProcess = false;
      }
    }
    // Shoot a bullet, one each 30 frames.
    if(timeOfFire == 45){
      timeOfFire = 0;
      fireOn = true;
    }
    // Bullet time of frame counter is incrased.
    timeOfFire++;
  }
  void playerDamage(){
    life--;
    setSprite("img/playerDamaged.png");
  }
  void setSprite(String path){
    sprite = loadImage(path);    
  }
  
  int getLife(){ return life; }
  void show(){
    pushMatrix();
    fill(0, 0, 255);
    noStroke();
    image(sprite, x, y, playerWidth, playerHeight);
    popMatrix();  
  }
  
  
}
