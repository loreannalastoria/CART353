class Fish {
  //uploading the Pimages  
  PImage img;
  PImage img2;
  float x;
  float y;
  //using the following vectors for my floating objects
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;

  Fish(float m, float x, float y) {
    //giving the icon a mass, location, velocity and acceleration vector to be adjusted later
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(1, 0);
    acceleration = new PVector(0, 0);
  }

//we are applying a force to the pVector and then dividing that from the mass with a divide vector
//the applying that force to the acceleration
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    //adding a high speed limit to the fish because i want the smaller objects to move around faster
    velocity.limit(10);
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    //updating the acceloration after adding the velocity
  }

//Method which displays the balls/skulls
  void display() {
    img = loadImage("fish.png");
    img2 = loadImage("deadfish.png");
    //I made it so when the mouse is pressed, the "dead" side shows
    if (mousePressed){
      image(img2, location.x, location.y);
    } else {
      image(img, location.x, location.y);
    }
  }
}