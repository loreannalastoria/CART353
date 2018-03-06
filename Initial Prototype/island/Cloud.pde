class Cloud {
  PImage[] clouds = new PImage[6];
  int xPos = 1;
  int speed = 10;
  int yPos = 0;
  float angle = 0;

  void showClouds() {
    for ( int i = 0; i< clouds.length; i++ ) {
      clouds[i] = loadImage( i + "cloud.png" );
    }
  }

  void animate() {
    //for ( int i = 0; i< clouds.length; i++ ) {
    //image(clouds[0], x1, y1, 200, 200);
    //image(clouds[1], x1-200, y1+200, 300, 300);
    //image(clouds[2], x1, y1+400, 300, 300);
    //x1 = x1 + speed;
    //smooth();
    //}
   
    
    image(clouds[0], xPos-100, height/2, 300, 300);
    image(clouds[1], xPos-200, 175, 400, 400);
    image(clouds[2], xPos+500, 600, 300, 300);
    image(clouds[3], xPos+200, 300, 100, 100);
    image(clouds[4], xPos-200, 700, 250, 250);
    
    xPos = xPos + speed;
    if (xPos > width + 100 || xPos < 0 - 100){
      xPos= -xPos;
    }
    
  }
    
   
  }