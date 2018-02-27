class Ball {
  //importing my images
  PImage img;
  PImage img2;
  float x;
  float y;
  //using the following vectors for my floating objects
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;

  Ball(float m, float x, float y) {
    //giving the icon a mass, location, velocity and acceleration vector to be adjusted later
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(1, 0);
    acceleration = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    PVector aforce = PVector.div(force, mass);
    acceleration.add(aforce);
  }

  void update() {
    //adding a low speed limit to the balls because i want the bigger objects to move around slower
    velocity.limit(3);
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    //updating the acceloration after adding the velocity
  }

//Method which displays my fishies
  void display() {
    img = loadImage("ball.png");
    img2 = loadImage("skull.png");
    //I made it so when the mouse is pressed, the "dead" side shows 
    if (mousePressed){
      image(img2, location.x, location.y);
    } else {
      image(img, location.x, location.y);
    }
  }
}