/*
This particle class is what makes up the acid rain. Althought the sketch is 2D, the rain looks 3D given the traits i included.
 Each rain particle is mapped a different speed, lenght and thickness. By doing this, i making the illusion that some rain 
 is further away and some is closer to the screen. I am also mapping the rain speed which makes the thinner, further rain slower 
 and the closer, thicker rain faster; again giving the illusion of dept and also gravity.
 Attributes: 
 - Daniel Shiffman Puple Rain Challenge(youtube video)
 - Sabine at the Comp Lab
 */

class Rain {
  float xRain;
  float yRain;
  float rainSpeed;
  float rainFade;
  float lenght;
  float z;

  //constructor
  Rain() {
    //x loc of rain is randomized
    xRain = random(width);
    //y loc of rain, starts before the canvas
    yRain = random(-500, -50);
    //speed of rain, each particle is mapped to a different speed
    rainSpeed = map(z, 0, 20, 1, 20);
    //lenght of each rain, particles are mapped to a different lenght
    lenght = map(z, 0, 20, 10, 20);
    //z is what i used to map the other variables. Depending on what number is outputed affects the rain particles
    z = random(0, 20);
    //the opacity of the rain at the start
    rainFade = 100;
  }

  //statement to generate rain when build count is in betwee this range
  void rainSpeed() {
    //y rain added to the rain speed is what makes it move
    yRain = yRain + rainSpeed;
    //mapping some gravity using Z so that rain falls at different rates - giving the illusion of gravity
    float gravity = map(z, 0, 20, 0, 0.2);
    //adding gravity to rain speed
    rainSpeed = rainSpeed + gravity;

    if (yRain > height) {
      //if the rain passes the screen height, bring it back to the top to restart the loop
      yRain = random (-200, -100);
      rainSpeed = map(z, 0, 20, 2, 50);
    }
  }

  void rainTrigger() {
    //here making the rain particle using the lines and alternating the weight of the strokes
    float sizeChange = map(z, 0, 20, 1, 3);
    strokeCap(ROUND);
    strokeWeight(sizeChange);
    stroke(255, rainFade);
    line(xRain, yRain, xRain, yRain + lenght);  
  }

  void rainStop() {
    //this function fades out the rain and is called when buildcount reaches a certain amount
    rainFade = map(buildCount, 6800, 7000, 100, 0);
  }
}