class Land {
  PImage island;

  void displayIsland() {
    island = loadImage("island.png");
    imageMode(CENTER);
    float islandRise = 600;
    image(island, width/2, islandRise, 1100, 400);
  }
}