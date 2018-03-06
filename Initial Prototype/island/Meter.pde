class Meter {
  int xPos;
  void showMeter(){
    stroke(255);
    strokeWeight(5);
    strokeCap(ROUND);
    line(400, 100, 900, 100);
    pointer(width/2 , 150);
  }
  
  void pointer(int xPos, int yPos){
    stroke(255);
    strokeWeight(5);
    strokeCap(ROUND);
    line(400, 100, 900, 100);
    pointer(width/2 , 150);
    
    fill(255);
    noStroke();
    triangle(xPos, yPos, xPos+20, yPos-40, xPos+40, yPos);
    
  }
  
}