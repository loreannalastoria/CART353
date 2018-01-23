class Image2 {
  PImage img;
  PImage destination;
  
  
  void display(){
    img = loadImage("girl2.jpg");
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
        //mouse right = brighter
        //mouse left = darker
        
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
    //using map function so i can be able to use the mouseX 
    //location for the size of the circles
    float pointillize = map(mouseX, 0, width, 0, height);
    //start off by chosing random points from the image
    //these variables will be used to locate the color/pixel in the image later on
    int x = int(random(img.width));
    int y = int(random(img.height));
    
    //getting the color of pixel at the specific location
    color pixColor = img.get(x, y);
    //filling the ellipses with that pixel color
    fill(pixColor, 200);
    noStroke();
    
    //drawing multiple ellipses so there are more than 1 on the screen.
    //pointillize effect kept getting erased because of the looping
    ellipse(x, y, pointillize, pointillize);
    ellipse(x/(random(3)), y/(random(3)), pointillize, pointillize);
    ellipse(x*(random(5)), y*(random(5)), pointillize, pointillize);
    //slowing down the frame rate to see the animation
    frameRate(8);
  }
  
    //This void is what allows the images to be merged together
    void blending(){
      //loading in other image just for this void
      PImage img2 = loadImage("girl.jpg");
      //set the left side as the class image
      set(0, 0, img);
      //set the right side as the newly loaded image
      set(width/2, 0, img2);
      //set allows us to set an area with either a color, image or specific pixels
      //first two paramaters of the set is for the x and y 
  }
}