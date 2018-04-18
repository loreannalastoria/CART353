class Tree {
  PImage treeImage;
  float h;
  float w;
  float yPosition;
  float dropSpeed; 
  float xPosition;
  boolean treeActivated;

  Tree(float xPos, float yPos) {
    treeImage = loadImage("tree.png");
    h = 200; 
    w = 250;
    yPosition = yPos;
    xPosition = xPos;
    treeActivated = false;
  }

  void treeShow() {
    if (key == 't') {
      image(treeImage, mouseX, mouseY, w, h);
    }
  }

  void place() {
    image(treeImage, xPosition, yPosition, w, h);
  }
}