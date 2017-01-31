// 2017 02 01 // //<>//
//            //
//            //
// fanyuting  //
//            //
// 2017 02 01 //

int gameState;
  final int GAME_START = 0;
  final int GAME_RUN = 1;
  final int GAME_END = 2;

int x=0; //for bg

class Direction
{
  static final int LEFT = 0;
  static final int RIGHT = 1;
  static final int UP = 2;
  static final int DOWN = 3;
}
class EnemysShowingType
{
  static final int STRAIGHT = 0;
  static final int SLOPE = 1;
  static final int DIAMOND = 2;
  static final int STRONGLINE = 3;
}
class FlightType
{
  static final int FIGHTER = 0;
  static final int ENEMY = 1;
  static final int ENEMYSTRONG = 2;
}

PImage start1,start2;
PImage end1, end2;
PImage bg1, bg2;
PImage shoot,bullet;

int currentType = EnemysShowingType.STRAIGHT;
int enemyCount = 8;
Enemy[] enemys = new Enemy[enemyCount];
int[] bossCount = {0, 0, 0, 0, 0};
Fighter fighter;

FlameMgr flameMgr;
Treasure treasure;
HPBar hpDisplay;
Bullet[] bullets = new Bullet[5];

boolean isMovingUp;
boolean isMovingDown;
boolean isMovingLeft;
boolean isMovingRight;

int time;
int wait = 6000;
int shottime;
int shotwait = 50;



PFont scoreBoard;
int scoreNum=0;


void setup () {
  size(640, 480);
  
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");

  shoot=loadImage("img/shoot.png");
  
  
  flameMgr = new FlameMgr();
  treasure = new Treasure();
  hpDisplay = new HPBar();
  fighter = new Fighter(20);
  //frameRate(100);
}

void draw()
{
  switch ( gameState ){
    
    case GAME_START:
      image(start2,0,0);
        if(mouseX > 210 && mouseX < 440 && mouseY > 380 && mouseY < 410){
          if(mousePressed){
            treasure.x=floor(random(30, 610));
            treasure.y=floor(random(30, 450));
            fighter.x=550;
            fighter.y=height/2-20;
            gameState = GAME_RUN; 
          }else{
            image(start1,0,0);
          }
        }
    break;
    
    case GAME_RUN:
    //background
    x++;x%=1280;
    image(bg1,x,0);
    image(bg2,-640+x,0);
    image(bg1,-1280+x,0);
    
    treasure.draw();
    flameMgr.draw();
    fighter.draw();

    //shots
    for (int i=0; i<5; i++) {
      if (bullets[i]!=null) {
        bullets[i].draw();
        bullets[i].move();
        for (int j=0; j<enemyCount; j++) {
          if (enemys[j]!=null) {
            if (isHit(enemys[j].x, enemys[j].y, 60, 60, bullets[i].x, bullets[i].y, 30, 27)) {
              scoreChange(20);
              if (enemys[j].type==FlightType.ENEMYSTRONG) {
                bossCount[j]++;
                if (bossCount[j]>=5) {
                  flameMgr.addFlame(enemys[j].x, enemys[j].y);
                  enemys[j]=null;
                }
              } else {
                flameMgr.addFlame(enemys[j].x, enemys[j].y);
                enemys[j]=null;
              }
              bullets[i] = null;
              break;
            }
          }
        }
      }
      if (bullets[i]!=null) {
        if (bullets[i].x<0-31)
          bullets[i] = null;
      }
    }

    //enemys
    if (millis() - time >= wait) {
      addEnemy(currentType++);
      currentType = currentType%4;
    }

    for (int i = 0; i < enemyCount; ++i) {
      if (enemys[i]!= null) {
        enemys[i].move();
        enemys[i].draw();
        if (enemys[i].isCollideWithFighter()) {
          if (enemys[i].type==FlightType.ENEMYSTRONG) 
            fighter.hpValueChange(-50);
          else
            fighter.hpValueChange(-20);
          flameMgr.addFlame(enemys[i].x, enemys[i].y);
          enemys[i]=null;
        } else if (enemys[i].isOutOfBorder()) {
          enemys[i]=null;
        }
      }
    }
    hpDisplay.updateWithFighterHP(fighter.hp);
    
    
    fill(255);
    text("Score:" + scoreNum, 10,470);
  break;
  
  case GAME_END:    
    if (mouseX > width/2-120 
      && mouseX <width/2+120 
      && mouseY >height/2+60 
      && mouseY<height/2+110) {
        
        currentType = EnemysShowingType.STRAIGHT;
        fighter= new Fighter(20);
        treasure = new Treasure();
        enemys = new Enemy[enemyCount];
        flameMgr =  new FlameMgr();
        bullets = new Bullet[5];
        scoreNum=0;
        image(end1, 0, 0);
        
        if (mousePressed) {
          gameState=GAME_START;
        }      
     }
     else image(end2, 0, 0);
    
  break;
  } //switch gameState //

}

boolean isHit(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh)
{
  // Collision x-axis?
  boolean collisionX = (ax + aw >= bx) && (bx + bw >= ax);
  // Collision y-axis?
  boolean collisionY = (ay + ah >= by) && (by + bh >= ay);
  return collisionX && collisionY;
}

void keyPressed() {
  switch(keyCode) {
  case UP : 
    isMovingUp = true ;
    break ;
  case DOWN : 
    isMovingDown = true ; 
    break ;
  case LEFT : 
    isMovingLeft = true ; 
    break ;
  case RIGHT : 
    isMovingRight = true ; 
    break ;
  default :
    break ;
  }
}
void keyReleased() {
  switch(keyCode) {
  case UP : 
    isMovingUp = false ;
    break ;
  case DOWN : 
    isMovingDown = false ; 
    break ;
  case LEFT : 
    isMovingLeft = false ; 
    break ;
  case RIGHT : 
    isMovingRight = false ; 
    break ;
  default :
    break ;
  }
  if (key == ' ') {
    if (gameState == GAME_RUN) {
      if (millis() - shottime >= shotwait)
        fighter.shoot();
    }
  }
}

void scoreChange(int value){
  scoreNum +=value;
}