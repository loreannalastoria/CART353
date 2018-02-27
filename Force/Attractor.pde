//calling in the image
PImage img;
//allthought we are using vectors, we still need and x and y to link to from time to time
float x;
float y;

class Attractor {
  /*variables for the forces, the mass represnets the size of the gravitational force, 
  the gravity pull is the gravitational constant, 
  location represents the location of this vector
  and the follow offset records the space between the previous position and new position is when the icon is being dragged around.
  */ 
  float mass; 
  float gravityPull; 
  PVector location; 
  PVector followOffset; 

  Attractor() {
    /*Here i am making the location of the gravitional pull start at the center of the screen. 
    The mass/size of this pull is set to 10 because i wanted something small
    the gravitational pull is set to 5 because i wanted something kinda quick
    The offset is set to 0 to start*/
    location = new PVector(width/2,height/2);
    mass = 10;
    gravityPull = 5;
    followOffset = new PVector(0,0);
  }

  PVector attract(Fish m) {
    /*Attributes: Nature of code Vectors/Forces chapter.
    in order to have everything move toward the middle, 
    i used vector subtraction which is taking the difference between the two points.
    I used vector magnature to calculate the length of the force.
    I am then adding a constraint to the minumum and max pixels of the force size.
    Then normalizing the force to give it a standard direction
    Then using a calculation to determine the magnatute of the force.
    Using a multiply vector with the strenght
    returning the final force.
    */
    PVector force = PVector.sub(location,m.location);   
    float objectDistance = force.mag();                              
    objectDistance = constrain(objectDistance, 3, 15);       
    //force.limit(10);
    force.normalize();                                  
    float strength = (gravityPull * mass * m.mass) / (objectDistance * objectDistance);      
    force.mult(strength);                                 
    return force;
  }

  void display() {
    //This method is what displays my icon of the cat. 
    //it uses the location vector as parameters so it has the same force
    img = loadImage("cat.png");
    image(img, location.x, location.y);
    imageMode(CENTER);
}

//function which allows the icon to follow the mouse button while still having a gravitaional pull
  void follow() {
      location.x = mouseX + followOffset.x;
      location.y = mouseY + followOffset.y;
    }
  }