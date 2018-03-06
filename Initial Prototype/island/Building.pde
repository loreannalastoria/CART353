class Building {
  PImage[] buildings = new PImage[3];

  void displayBuild() {
    for ( int i = 0; i< buildings.length; i++ ) {
      buildings[i] = loadImage( "building" + i + ".png" );
    }
  }

  void buildDrop() {
    if (key == 'b') {
      //int i = int(random(0, buildings.length));
      //for (int i = 0; i< buildings.length; i++ ){
      int i = int(random(0, 3));
      image(buildings[i], mouseX, mouseY, 600, 500);
      //}

      //  if (mousePressed){
      //  int xPos = mouseX;
      //  int yPos = mouseY;
      //  image(buildings[i], xPos, yPos, 600, 500);
      //}
    }
  }
}