/*
This particle class is what makes up the polluted air. I am using lines which follow the force of the PVector. 
The particles are also affected by a velocity and acceleration.
Attributes: 
  - Daniel Shiffman Perlin Noise Flow Feild Coding Challenge (youtube video)
  - Class notes on Perlin Noise 
*/

class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector prevPos;
  float maxSpeed;
  float fadeParticles = 0;
  
  //constructor
  Particle(){
    //position
    pos = new PVector(random(width - 1), random(height - 1));
    //velocity
    vel = new PVector(0, 0);
    //acceleration
    acc = new PVector(0, 0); 
    //previous particle position
    prevPos = pos.copy();
    //max speed that particles flow
    maxSpeed = 5;
    //opacity the particles start at
    //fadeParticles = 0;
  }
  
  void update() {
    //we need the previous position to link to the next position in order to create the lines
    prevPos.x = pos.x; 
    prevPos.y = pos.y; 
    
    // pply acceleration and velocity
    vel.add(acc); 
    //giving a limit to velocity
    vel.limit(maxSpeed); 
    pos.add(vel); 
    
    //if the lines go odd the canvas, locate them back onto the canvas
    if(pos.x >= width) {
      pos.x = prevPos.x = 0;
    }
    if(pos.x < 0) {
      pos.x = prevPos.x = width - 1;
    }
    if(pos.y >= height) {
      pos.y = prevPos.y = 0;
    }
    if(pos.y < 0) {
      pos.y = prevPos.y = height - 1;
    }
    
    //reset acceleration using multiple
    acc.mult(0); 
  }
  
  //apply a force to the PVector. This is what makes the lines flow organically
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  //function to made the particles appear. 
  //When build count reaches a certain number, the particles fade away by mapping the opacity of the lines
  void show() {
    stroke(0, fadeParticles);
    fadeParticles = map(buildCount, 7400, 7500, 0, 10);
    strokeWeight(2);
    line(pos.x, pos.y, prevPos.x, prevPos.y);
  }
  
  //function to make the lines follow the PVectors which we cant see
  void follow(PVector[] flowField) {
    // get the index in the flow field
    int x = floor(pos.x / scaleParticle);
    int y = floor(pos.y / scaleParticle);
    int index = x + y * particleCols;
    
    // get the force and apply it
    PVector force = flowField[index];
    applyForce(force);
  }
}