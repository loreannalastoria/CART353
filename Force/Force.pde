/*
Loreanna Lastoria
Assignment 3 - Force Assignment
For this assignment, I used a gravitational pull effect which is surounding my cat icon. 
Fish and tennis balls are floating around my cat using various vectors which create a force.
When the mouse is pressed, these toys and treats turn "dead" which i thought was an interesting touch.

**Attributres granted to mainly the Nature of Code book and the processing reference page.**
*/

//calling in my classes
Ball[] ball = new Ball[10];
Fish[] fish = new Fish[10];
Attractor cat;

void setup() {
  //making my canvas fullscreen
  fullScreen();
  //for loop which is placing an icon with a random mass, random x, and random y on the canvas
  for (int i = 0; i < fish.length; i++) {
    fish[i] = new Fish(random(0.1, 2), random(width), random(height));
    ball[i] = new Ball(random(0.1, 2), random(width), random(height));
  }
  cat = new Attractor();
  }

void draw() {
  background(255);
  //adding in the cat
  cat.display();
  cat.follow();
//using a for loop to add in the numerous amounts of icons
  for (int i = 0; i < fish.length; i++) {
    PVector force = cat.attract(fish[i]);
    //adding in the fish
    fish[i].applyForce(force);
    fish[i].update();
    fish[i].display();
   //adding in the balls
    ball[i].applyForce(force);
    ball[i].update();
    ball[i].display();
  }
}