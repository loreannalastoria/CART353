class Tree {
  PImage tree;


  void displaytree() {
    tree = loadImage("tree.png");
    imageMode(CENTER);
  }

  void treeDrop() {
    if (key == 't') {
      int h = int(random(300, 900)); 
      int w = int(random(550, 700));
      image(tree, mouseX, mouseY, w, h);
      if (mousePressed) {

        //int xPos = mouseX;
        //int yPos = mouseY;
        //image(tree, xPos, yPos, 600, 500);
      }
    }
  }
}