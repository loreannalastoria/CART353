// Attributes: Sabine at the Comp Lab and Rilla Khaled

class Building {
  PImage[] buildings = new PImage[25];
  //initilizing all my variables at the begining
  //boolean for did the buildings start growing?
  boolean beginGrow;
  //the max i want the buildings to grow
  int growMax;
  //growing height is the varible that grows the building until the grow max
  int growingHeight;
  //y location of building
  int buildingYloc;
  //image of the buildings
  PImage buildingImage;
  //how fast the buildings grow
  int buildingSpeed;
  //x location of building
  int buildingXloc;
  //when the buildings start to grow
  int startInterval;

  //constructor
  Building(String bImg, int buildingX, int buildingSpeed, int buildingMax, int buildingInterval) {
    growingHeight = 2;
    growMax = buildingMax;
    buildingXloc = buildingX;
    buildingYloc = height/2 + 20;
    buildingImage = loadImage(bImg);
    //begin grow is off for now
    beginGrow = false;
    this.buildingSpeed = buildingSpeed;
    startInterval = buildingInterval;
  }

  void buildDrop() {
    //After a certain amount of seconds, buildings will begind to grow
    if (millis() > startInterval && !beginGrow) {
      //turn begin gro won
      beginGrow = true;
      //set the growing height to 0 as thats where the building starts. 
      //This will increment untill it reaches the grow max
      growingHeight = 0;
    }

    if (beginGrow) {
      //if begin grow is on, draw a building from the array
      image(buildingImage, buildingXloc, buildingYloc, 300, growingHeight);
      //if the growing height is less that the grow max, increment it at the speed set
      if (growingHeight < growMax) {
        growingHeight+=this.buildingSpeed;
      }
    }
  }
}