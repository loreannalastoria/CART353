/* FUNCTIONS:
 To switch from one image to another: LEFT and RIGHT KEY
 To adjust brightness: MOVE MOUSE AROUND
 To turn on the pointillize effect: SHIFT KEY
 To turn on threshold effect: CLICK MOUSE
 To save: S KEY
 */
 
// * atributes: Processing forum and the readings *

//calling in my image classes
Image1 image1;
Image2 image2;

//boolean for knowing which image were viewing
boolean view1;

//boolean for turning on and off the split effect for the images
boolean split = false; 

//boolean for turning on and off the dot effect on the images
boolean dots = false;

void setup() {
  //declare a square the same size as my images so we can properly locate the pixels
  size(350, 350);
  //turning view1 on as we are on the first image
  view1 = true;
  //calling in our images one on top of the other
  image1 = new Image1();
  image2 = new Image2();
}

void draw() {
  background(0);

  if (view1) {
    //if we are in view1, we can play with the brightness of the first image
    image1.display();
    image1.brightEffect(); 
    //if mouse is clicked, the image changes to threshold
    if (mousePressed == true) {
      image1.thresholdEffect();
    }
  } else {
    //else if we are NOT in view1, we can play with the brightness of the second image
    image2.display();
    image2.brightEffect();
    //if mouse is clicked, the image changes to threshold
    if (mousePressed == true) {
      image2.thresholdEffect();
    }
  }
  //if the split boolean is on, we can switch through the images to make them colide
  if (split == true) {
    //if on view 1, images split with the blue art first
    if (view1) {
      image1.blending();
      //if on view 2, images split with the red art first
    } else {
      image2.blending();
    }
  }

  //if the dots boolean is on, draw the original image and showcase the pointillize effect
  if (dots == true) {
    if (view1) {
      //i redrew the original image so there is no brightness effect going on at the same time
      image1.display();
      image1.dotEffect();
    } else {
      //same as above for other image
      image2.display();
      image2.dotEffect();
    }
  }
}
//functions to know which key goes what effect
void keyPressed() {
  //if the left or right key is pressed, user can switch between images
  if (keyCode == RIGHT || keyCode == LEFT) {
    view1 = !view1;
  }
  //if the space is pressed, user can colide the images over one another
  if (key == 32) {
    split = !split;
  }
  //if the shift key is pressed, user can turn on and off the dots effect
  if (keyCode == SHIFT) {
    dots = !dots;
  }
  //if s key is pressed, will save the frame 
  if (key == 's') {
    saveFrame("myBlend.jpg");
  }
}