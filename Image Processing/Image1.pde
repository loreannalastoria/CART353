class Image1 {
  PImage img;
  PImage[] segments = new PImage[2];
  PImage destination;

  
  void display(){
    img = loadImage("girl.jpg");
    image(img, 0, 0);
    loadPixels();
    img.loadPixels();
    
    //for the threshold - create a blank image 
    //use orignial image as a source
    destination = createImage(img.width, img.height, RGB);
  }
  
  void brightEffect(){
    //loops to layout the pixels along the x and y axis
    for (int x = 0; x < img.width; x++){
      for (int y = 0; y < img.height; y++){
        
        //determining the pixel location
        int loc = x + y * img.width;
        
        //getting the r, g and b values
        float r = red(img.pixels[loc]);
        float g = green(img.pixels[loc]);
        float b = blue(img.pixels[loc]);
        
        //adjusting the brightness
        /*the multiplyer is demetermined using the map based on the 
        X position of the mouse and that is what changes the RBG
        value of each pixel. */
        float adjustBright = map(mouseX, 0, width, 0, 8);  
        r *= adjustBright;
        g *= adjustBright;
        b *= adjustBright;
        //mouse right goes brighter
        //mouse left goes darker
        
        //setting to 0-255 before being given a new color
        r = constrain(r, 0, 255);
        g = constrain(g, 0, 255);
        b = constrain(b, 0, 255);
        
        //make a new color
        color c = color(r, g, b);
        //set the display pixel
        pixels[loc] = c;
      }
    }
   updatePixels();
  }
  
  void thresholdEffect(){
    float threshold = 127;
    
    //pixels need to be loaded just durring this void
    destination.loadPixels();
    
    for (int x = 0; x < img.width; x++){
      for (int y = 0; y <img.height; y++){
        int loc = x + y * img.width;
        
        if (brightness(img.pixels[loc]) > threshold){
          destination.pixels[loc] = color(255);
        } else {
          destination.pixels[loc] = color(0);
        }
      }
    }
    //update and display the created image
    destination.updatePixels();
    image(destination, 0, 0);
  }
  
  void dotEffect(){
    int pointillize = 16;
    //start off by chosing random points 
    int x = int(random(img.width));
    int y = int(random(img.height));
    int loc = x + y * img.width;
    
    //load the colors
    img.loadPixels();
    float r = red(img.pixels[loc]);
    float g = green(img.pixels[loc]);
    float b = blue(img.pixels[loc]);
    
    //making the shapes 
    noStroke();
    fill(r,g,b,100);
    ellipse(x, y, pointillize, pointillize);
  } 
}