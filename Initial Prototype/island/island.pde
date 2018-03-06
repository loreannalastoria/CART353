Land island; //<>//
Tree tree;
Building building;
Life life;
Cloud cloud;


PFont light;
PFont bold;

boolean startScreen = false;

boolean isThereTrees = false;
boolean isThereLife = false;

int treeCount = 0;
int buildCount = 0;

int pointerX = 617;
int pointerY = 0;

void setup() {
  //size(500, 500);
  fullScreen();
  background(0);
  
  light = createFont("mlight.ttf", 16);
  bold = createFont("mbold.ttf", 16);

  island = new Land();
  tree = new Tree();
  building = new Building();
  life = new Life();
  cloud = new Cloud();
}

void draw() {
  //----------------------Perlin Noise background-------------------------//
  float scale = 0.01;

  loadPixels();
  for (int x = 0; x<width; x++) {
    for (int y = 0; y<height; y++) {
      float col = 300*noise(scale*x, scale*y, 10*scale*frameCount);
      pixels[x + width*y] = color(col, 255, 255);
    }
  }
  updatePixels();
  smooth();
  //--------------------------------------------------------------//

  //if (startScreen == true){
  //  background(255);
  //  textSize(14);
  //  fill(0);
  //  textAlign(CENTER);
  //  text("To play press the spacebar", width/2, height/2);

  //  if (key == 32) {
  //     startScreen = false;
  // }

  if (startScreen == false) {
    //background(255);
    textSize(14);
    fill(0);
    textAlign(LEFT);
    text("Trees:" + treeCount, 15, 20);
    text("Buildings:" + buildCount, 15, 40);

    meter(pointerX, 150);

    cloud.showClouds();
    cloud.animate();

    island.displayIsland();

    tree.displaytree();
    tree.treeDrop();

    building.displayBuild();
    building.buildDrop();

    life.displayLife();
    life.lifeDrop();

    instructions();
  }
}


void mouseClicked() {

  if (key == 't') {
    treeCount++;
    pointerX = pointerX+2;
    println("trees:" + treeCount);
  }

  if (key == 'b') {
    buildCount++;
    pointerX = pointerX-2;
    println("buildings:" + buildCount);
  }

  //checking if life was used
  //if (key == 'l') {
  //  isThereLife = true;
  //}
}

void meter(int pointerX, int pointerY) {
  //White part
  strokeCap(ROUND);
  stroke(255);
  strokeWeight(13);
  line(395, 100, 905, 100);

  //Red and Green
  strokeCap(SQUARE);
  stroke(255, 0, 0);
  strokeWeight(3);
  line(400, 100, 635, 100);
  stroke(0, 255, 0);
  line(635, 100, 900, 100);
  //Triangle
  fill(255);
  noStroke();
  triangle(pointerX, pointerY, pointerX+20, pointerY-40, pointerX+40, pointerY);
}

void instructions() {
  int xText = width/2;
  int boxWidth = width/2-150;

  fill(255);
  rect(xText-150, -50, 300, 75, 10);
  textFont(bold);
  fill(0);
  text("?", width-xText, 17);

  if (mouseX> boxWidth && mouseX< boxWidth+300 && mouseY <25 && mouseY > 0) {
    fill(255);
    rect(xText-150, -50, 300, 300, 10);

    textSize(20);
    fill(0);
    textAlign(CENTER);
    textFont(bold);
    text("INSTRUCTIONS", width-xText, 50);
    textSize(14);
    textFont(light);
    text("This is your island.", width-xText, 80);
    text("Play as you wish.", width-xText, 95);
    textFont(bold);
    text("T key places trees", width-xText, 115);
    text("L key places life", width-xText, 130);
    text("B key places buildings", width-xText, 145);
    textFont(light);
    text("You have seven days.", width-xText, 165);
    text("Think logically.", width-xText, 180);
  }
}