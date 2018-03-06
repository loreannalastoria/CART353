class Life {
  PImage[] life = new PImage[5];


  int w = 50;
  int h = 50;

  void displayLife() {
    for ( int i = 0; i< life.length; i++ ) {
      life[i] = loadImage( i + "life.png" );
    }
  }

  void lifeDrop() {
    int index = int(random(0, 5));

    if (key == 'l') {
      image(life[index], mouseX, mouseY, w, h);
    }
  }
}