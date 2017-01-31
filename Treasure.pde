class Treasure{
  PImage treasureImg = loadImage("img/treasure.png");
  int x = 0;
  int y = 0;
  
  float ratio =1;
  float origWidth;
  float origHeight;
  
  float height(){
  return treasureImg.height;}
  
  float width(){
  return treasureImg.width;}
  
  Treasure () {
    origWidth = treasureImg.width;
    origHeight = treasureImg.height;
    relocateTreasure();
  }

  void relocateTreasure() {
    ratio = random (0,6) <3 ?1 : 1.4;     //隨便幫他決定是大顆的能量或小的能量，1.4倍大
    this.x = int(random(40,550));
    this.y = int(random(40,400));
  }

  void draw() {
    image(treasureImg, x, y, origWidth *ratio, origHeight * ratio);

    if (isHit(this.x, this.y, this.treasureImg.width, this.treasureImg.height, 
        fighter.x, fighter.y, fighter.fighterImg.width, fighter.fighterImg.height)) 
       {
        if(ratio ==1){fighter.hpValueChange(10);}
          else{fighter.hpValueChange(20);}
        this.relocateTreasure();
    }
  }
}