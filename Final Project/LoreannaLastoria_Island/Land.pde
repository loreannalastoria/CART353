//This class hold the land object, as well as the background animations and changing environments
class Land {
  PImage island;
  float islandRise;
  float w;
  float h;
  
  //constructor
  Land(){
    islandRise = 600;
     w = 800;
     h = 500;
  }
  
  void displayIsland() {
    //loading in the image and drawing the island
    island = loadImage("islandOld.png");
    imageMode(CENTER);
    image(island, width/2, islandRise, w, h);
  }

  //this is where i use the map function to affect every color in the sky color found on the main code
  //build count affects when these changes happen
  void environmentChange() {
   //statement for if the buildcount is in between this range, start to change the background to dark blue
    if (buildCount > 3500 && buildCount < 4000){
      bR = map(buildCount, 3500, 4000, 117, 50); 
      bG = map(buildCount, 3500, 4000, 238, 100); 
      bB = map(buildCount, 3500, 4000, 255, 150); 
      //adding the rain sound here so it plays before the particles appear
      //before i play the sound, i make sure to rewind it incase it is not at the begining
      rainSound.rewind();
      //then we play the sound
      rainSound.play();
    } 
    //statement for if the buildcount is in between this range, start to change the background to brown/green
    if (buildCount > 7000 && buildCount < 7400){
      bR = map(buildCount, 7000, 7400, 50, 67); 
      bG = map(buildCount, 7000, 7400, 100, 71); 
      bB = map(buildCount, 7000, 7400, 150, 52); 
      //adding the wind sound here so it plays before the particles appear
      windSound.rewind();
      windSound.play();
    } 
  }
}