// Boss image is "img/enemy2.png" 
class Boss extends Enemy {
  Boss(int x, int y, int type) {
     super(x, y, type, "img/boss.png");
      speed = 2;
      type = FlightType.ENEMYSTRONG;
    }
}