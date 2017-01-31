class Bullet {
  PImage shootImg;
  int x = 0;
  int y = 0;

  Bullet(int x, int y) {
    this.x = x;
    this.y = y;
    shootImg = loadImage("img/shoot.png");
  }

  void move() {
    x-= 7;
  }
  
  void draw() {
    image(shootImg, x, y);
  }
}