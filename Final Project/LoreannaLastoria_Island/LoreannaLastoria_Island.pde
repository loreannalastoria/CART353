/* //<>//
Loreanna Lastoria - Final Assignment
Major attributes to Sabine at the Comp Lab
*/

//calling my object classes
Land island;
Tree tree;
//calling my object arrays 
Particle[] particles = new Particle[1000];
Building[] buildings = new Building[25];
Rain[] rain = new Rain[1000];
//this array list is what allows me to have multiple trees placed.
final static ArrayList<Tree> trees = new ArrayList();

//import the minim library
import ddf.minim.*;
Minim minim;
AudioPlayer backgroundPlayer;
AudioPlayer treeSound;
AudioPlayer rainSound;
AudioPlayer smogSound;
AudioPlayer windSound;

//calling and importing in my fonts
PFont light;
PFont bold;

//I created a boolean to know when the trees have been activated (when user presses T)
//If this is true, the trees can be placed
boolean treeActivated = false;

//I created two counters to help me follow whats happening
//the tree counter increments every time a tree is placed and then a tree is placed, it minuses a certain amount from the build count.
int treeCount = 0;
//the buildcount increments are the buildings grow, this value is really important as it determines when all the map functions are triggered
//this counter helped me program when every stage should begin and end
//when a tree is placed, it takes away from this counter and thats what slows down the pollution process
int buildCount = 0;

//These variables are for the land class to change the background color
//there need to be called globally so the map functions works properly
float bR = 117;
float bG = 238;
float bB = 255;

//these varibles are for the end of the game,
//i need to call these globally to make the map function work properly. 
float rectShow = 0;
float endTextShow = 0;

//Varibles for my particles system
float incParticle = 0.1;
float scaleParticle = 10;
int particleCols;
int particleRows;
float particleZ = 0;
PVector[] flowingParticles;

void setup() {
  //size(1100, 800);
  fullScreen();
  //calling the fonts i want to use
  light = createFont("mlight.ttf", 16);
  bold = createFont("mbold.ttf", 16);
  //calling the island class 
  island = new Land();
  //Calling the tree class just so i can have it follow the mouse button when T is pressed. I dont need to use the array for this.
  tree = new Tree(mouseX, mouseY);

  //MINUM
  //load files from the data directory
  minim = new Minim(this);
  backgroundPlayer = minim.loadFile("backgroundmusic.mp3");
  treeSound = minim.loadFile("treepop.mp3");
  rainSound = minim.loadFile("rain.mp3");
  smogSound = minim.loadFile("smog.mp3");
  windSound = minim.loadFile("wind.mp3");

  //Array for Buildings, using a loop to pass through every item in the array
  for (int i = 0; i < 25; i++) {
    //i coded in a and b to make it easier for me to use random while also limiting it to a certain area
    int a = width/2 - 280;
    int b = width/2 + 280;
    //every building has a random location between a and b, and every building sprouts every 3 seconds
    buildings[i] = new Building("building" + i + ".png", int(random(a, b)), 50, 400, 3000 * i);
  }

  //Array for rain, using a loop to pass through every item in the array
  for (int i = 0; i < 1000; i++) {
    rain[i] = new Rain();
  }
  smooth();

  //Setting up my particle system stuff
  //using floor to ensure i dont return a decimal number
  particleCols = floor(width / scaleParticle);
  particleRows = floor(height / scaleParticle);
  //loop to load in all the particles
  for (int i = 0; i < 1000; i++) {
    particles[i] = new Particle();
  }
  //creating a vector to control where the particles move
  flowingParticles = new PVector[particleCols * particleRows];
}

void draw() {
  //creating a sky color which i can then manupulate using the map function
  int skyColor = color(bR, bG, bB);
  background(skyColor);
  //play the jazz background music
  backgroundPlayer.play();

  /*YOU CAN USE THIS TEXT WHICH LETS YOU SEE HOW THE COUNTERS ARE AFFECTED 
   When trees are placed, it minuses an amount from the building counter 
   which is what slows down the pollution effects.*/
  textSize(14);
  fill(0);
  textAlign(LEFT);
  //text("Trees:" + treeCount, 15, 20);  //YOU CAN TURN THIS ON
  //text("Buildings:" + buildCount, 15, 40); //AND THIS ON TO SEE THE VALUES DURRING THE GAME

  //------------------------------------------BUILDING STUFF------------------------------------------//
  //the buildings will begin to sprout after 8 seconds, this is giving the user a head start
  if (millis() > 8000) {
    /*when the buildings begin to sprout, the buildcounter will also start to increment
     In order to have buildings sprouting throughout the experience, i had to make many building pngs. 
     If i would of restarted the array, the buildings on the canvas would dissapear which is not what i wanted.
     I wanted the scene to over time look very operpopulated since that is what causes pollution and that is also relatable to real life.*/
    for (int i = 0; i < 25; i++) {
      buildings[i].buildDrop();
      buildCount++;
      //sometimes you could see the buildings from under the island so i made a box to hide that 
      fill(skyColor);
      noStroke();
      rect(0, height/2+50, width, height/2);
    }
  }
  //calling in the island functions
  island.environmentChange();    
  island.displayIsland();
  //calling the instructions - i made this straight to the point as i find too much text 
  //took away from the scene and made it seem more like a game
  instructions();

  //--------------------------------------------RAIN STUFF--------------------------------------------// 
  if (buildCount > 3400 && buildCount < 7000) {
    //when the buildcount reaches this amount, the rain will begin to fall
    for (int i = 0; i < 1000; i++) {
      rain[i].rainSpeed();
      rain[i].rainTrigger();
      //at this point in the buildcount, the rain will fade using this function i made
      if (buildCount > 6800) {
        rain[i].rainStop();
        rainSound.pause();
      }
    }
  }
  
  //--------------------------------------------TREE STUFF--------------------------------------------//
  //i am calling this function so that the tree hovers the mouse when T is pressed
  tree.treeShow();
  //a for loop which places the trees by adding them to the array list every mouse click
  for (Tree t : trees)   t.place(); 

  //----------------------------------START OF PARTICLE SYSTEM STUFF----------------------------------//
  //at a certain point, the particle system will show
  if (buildCount > 7400 && buildCount < 10000) { 
    //these sounds end up playing after the particles fade out and its the sound of sizzling 
    //fire to show that the island is burning which i thought was super cool
    smogSound.play();
    smogSound.rewind();
    float particleY = 0;
    //using two for loops to have the particles go along the X and Y axis
    //the particles are using perlin noise and using PVectors to follow a path 
    for (int y = 0; y < particleRows; y++) {
      float particleX = 0;
      for (int x = 0; x < particleCols; x++) {
        // seting the vector in the flow field
        int index = x + y * particleCols; 
        //giving the particles a force with a curve
        float angleParticle = noise(particleX, particleY, particleZ) * TWO_PI * 2;
        PVector v = PVector.fromAngle(angleParticle);
        // seting the power of the field on the particle
        v.setMag(1); 
        flowingParticles[index] = v;

        particleX += incParticle;
      }
      particleY += incParticle;
      // rate the flowfield changes
      particleZ += 0.0003;
    }
    // update and draw the particles
    for (int i = 0; i < 1000; ++i) {
      particles[i].follow(flowingParticles);
      particles[i].update();
      particles[i].show();
    }
  }
  //Calling the game over function
  gameOver();
}

void mousePressed() {
  //if T is pressed, trees are activated and can now be placed on the canvas
  if (key == 't') {
    //play sound
    treeSound.play();
    //rewind so sound doesnt get stuck
    treeSound.rewind();
    treeActivated = true;
    //every time a tree is placed, it gets added to the counter
    treeCount++;
  }

  if (treeActivated) {
    int x1 = width/2 - 330;
    int x2 = width/2 + 330;
    int y1 = 410;
    int y2 = 420;
    //if the mouse is placed on the scene, the tree will place at that location but onto the island
    //if the mouse is clicked outside of the island boundaries, no tree will be placed
    if (mouseX > x1 && mouseX < x2) {
      //trees are being draw on mouse click since every click a tree is added to the array so it can be drawn
      //every time the mouse is clicked, it draws a tree at that location but lower where the island is
      trees.add(new Tree(mouseX, int(random(y1, y2))));
      //every time a tree is placed, take away from the build counter
      buildCount = buildCount-10;
      //by doing this, users are slowing down the effects of pollution
    }
  }
}

void gameOver() {  
  //if the build count reaches this amount, a black box will begin to over take the screen
  if (buildCount > 9750) {
    noStroke();
    fill(0, rectShow);
    rect(0, 0, width, height);
    rectShow = map(buildCount, 9750, 10000, 0, 255);
    //once the screen is black, it will show you how many trees you placed
    textSize(42);
    fill(255, endTextShow);
    endTextShow = map(buildCount, 10000, 10150, 0, 255);
    textAlign(CENTER);
    textFont(bold);
    text(treeCount + " Trees planted", width/2, height/2);
  }
}

//function for the simple instructions
void instructions() {
  int xText = width/2;
  int boxWidth = width/2-150;
  noStroke();
  fill(255, 150);
  rect(xText-150, -50, 300, 75, 10);
  textFont(bold);
  fill(255);
  text("V", width-xText, 17);
  if (mouseX> boxWidth && mouseX< boxWidth+300 && mouseY <25 && mouseY > 0) {
    fill(255, 150);
    rect(xText-150, -50, 300, 140, 10);
    textSize(20);
    fill(0);
    textAlign(CENTER);
    textSize(14);
    textFont(light);
    text("Keep the island alive", width-xText, 50);
    textFont(bold);
    text("Press T to begin placing trees", width-xText, 75);
  }
}