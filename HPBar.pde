class HPBar {
  PImage hpUI;

  HPBar () {
    this.hpUI = loadImage("img/hp.png");
  }
  void updateWithFighterHP(int hp)
  {
    fill (255,0,0) ;
    rect(15,10, hp * 2 , 20 ) ;
    image(hpUI,10,10);
  }

}