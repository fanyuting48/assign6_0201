public class Flame{
  public int x = 0;
  public int y = 0;
  int startTime;
  int showingImg_num;
  public Flame (int x, int y) {
    this.x = x;
    this.y = y;
    this.showingImg_num = 0;
    this.startTime = millis();
  }

  public int getCurrentImg() {
    if (millis() - this.startTime > 100) {
      return this.showingImg_num++;
    }
    else
    {
      return this.showingImg_num;
    }
  }
}

public class FlameMgr{
  ArrayList<Flame> flames = new ArrayList<Flame>(0);
  PImage flame1;
  PImage flame2;
  PImage flame3;
  PImage flame4;
  PImage flame5;

  public FlameMgr() {
    flame1 = loadImage("img/flame1.png");
    flame2 = loadImage("img/flame2.png");
    flame3 = loadImage("img/flame3.png");
    flame4 = loadImage("img/flame4.png");
    flame5 = loadImage("img/flame5.png");
  }

  void addFlame(int x, int y)
  {
    flames.add(new Flame(x, y));
  }

  public void draw() {
    ArrayList<Flame> flamesToRemove = new ArrayList<Flame>(0);
    for (int i = 0; i < this.flames.size(); ++i) {
      Flame flame = this.flames.get(i);
      int num = flame.getCurrentImg();
      switch (num) {
        case 0:  
          image(this.flame1, flame.x, flame.y);
          break;
        case 1:  
          image(this.flame2, flame.x, flame.y);
          break;
        case 2:  
          image(this.flame3, flame.x, flame.y);
          break;
        case 3:  
          image(this.flame4, flame.x, flame.y);
          break;
        case 4:  
          image(this.flame5, flame.x, flame.y);
          break;
        case 5:
          flamesToRemove.add(flame);
          break;  

      }
    }

    for (int i = 0; i < flamesToRemove.size(); ++i) {
      flames.remove(flamesToRemove.get(i));
    }
  }

}