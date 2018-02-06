/*EXPLINATION:
For this assignment, I used the Monte Carlo algorithum with the Perlin Noise
The background is the live video which I have mirrored.
I have two layers of circles which duplicated the live video.
The back layer is smaller circles going horizontally across the screen and 
the front layer is larger circles going virtically across the sreen. 
I find having the two layers of circles makes it look like a gradient.
I wanted to have a mirrored effect with the live video which is why I
duplicated it.
*/

//LIBRARIES:
import processing.video.*;
Capture liveVideo;
//Importing the processing library for live video

//GLOBAL VARIABLES:
//declaring a color variable which i will use for the live video
color captureColor;
//variables for the x and y locations
float xLoc;
float yLoc;
//starting the time at 0 (for the perlin noise)
float time = 0;

void setup() {
  //making the canvaa size the size of user's window to grab the whole live video
  size(displayWidth, displayHeight);
  //seting up the webcame capture
  liveVideo = new Capture(this, displayWidth, displayHeight);
  liveVideo.start();
  //slowing down the frame rate so we can see the circles moving 
  frameRate(10);
}

void draw() {
  background(0);
  //Duplicating the live video int the back to give the mirrored effect  
  pushMatrix();
  //flipping the background video 
  scale(-1,1);
  image(liveVideo.get(),-width,0);
  popMatrix();
  //attributes: Processing Forum
   
//SMALL CIRCLES
//stating how many circles I want for this section (15000)
  for (int i = 0; i < 15000; i++) {
    //giving color to the captureColor which will then be passed into the circles
    captureColor = liveVideo.get(int(xLoc), int(yLoc));
    noStroke();
    //filling in the circles with the live video and a slight transparency
    fill(captureColor,200);
    ellipse(xLoc, yLoc, 10, 10);
    xLoc++; //inscrementing the x location which is what makes circles move horizontally
    //making the time move forward, this will be passed into noise
    time = time + .05; //small value for short jumps in time 
    xLoc = montecarloEffect(); //merging the Monte Carlo into the Perlin Noise.
    yLoc = noise(time); //noise is like random but always returns a value between 0 and 1.
    //Using map to scale the original number into a new number
    /*When the xLoc map had a start of 0, the circles would begin 1/4 into the screen
    If I put .5 as the start, the circles start before the screen which gives the 
    straight edge which is what I want*/
    xLoc = map(xLoc, .5, 1, 1, width);
    yLoc = map(yLoc, 0, 1, height, 2);
  }

//BIG CIRCLES
//loop for how many circles I want for this section (9000)
for (int i = 0; i < 9000; i++) {
    //giving color to the captureColor which will then be passed into the circles
    captureColor = liveVideo.get(int(xLoc), int(yLoc));
    noStroke();
    //filling in the circles with the live video and a slight transparency
    fill(captureColor,100);
    ellipse(xLoc, yLoc, 20, 20);
    yLoc++; //inscrementing the y location which is what makes circles move vertically
    //making the time move forward, this will be passed into noise
    time = time + .05; //small value for short jumps in time 
    yLoc = montecarloEffect(); //merging the Monte Carlo into the Perlin Noise.
    xLoc = noise(time); //noise is like random but always returns a value between 0 and 1   
    //Using map to scale the original number into a new number
    //Here starting the xLoc at 0 again cause there is no need to push it back
    xLoc = map(xLoc, 0, 1, 1, width);
    /*giving the yLoc a start of 1 because I want the circles to start at the 
    bottom of the screen*/
    yLoc = map(yLoc, 1, 0, height, 0);
  }
}
//Perlin Noise attributes: Nature of Code page 40

//MONTECARLO:
/*This is scalable probability, not fixed
2 random numbers were dealing with
Pick a random number (R1) then pick another random number (R2), 
if R2 is greater than R1, restart. If R2 is less than R1 its good.
Using a while loop so it continously loops
*/
float montecarloEffect() {
  while (true){
    float randomOne = random(1);
    float probability = randomOne;
    float randomTwo = random(1);
    if (randomTwo < probability){
      return randomOne;
    }
    //attributes from Nature of Code page 37
  }
}

//attributes: Processing.org
//the read method processes the frame
void captureEvent(Capture video) {
  video.read();
}