//Angela Wu
//Final Project
//Code references: TheCodingTrain https://thecodingtrain.com/CodingChallenges/001-starfield.html; 3D Mic Visualizer by FreddieRa https://www.openprocessing.org/sketch/748615

import peasy.*;
PeasyCam cam;
import processing.sound.*;
SoundFile sample;
Amplitude rms;
FFT fft;

// Declare a scaling factor
float scale = 5.0;
float r_width;
// Declare a smooth actor
float smoothFactor = 0.25;
float sum;
Stars[] stars=new Stars[200];
float speed;
//set up fft
int radius, number, s;
float angle, baseAngle, add;
int bands = 512;
float[] spectrum = new float[number];

//keypress and light values
int count=0;
int l1=180;
int l2=150;
int l3=80;


void setup(){
  //size(600,600, P3D);
  fullScreen(P3D);
  lights();
  smooth();
  cam = new PeasyCam(this,600);
  //cam.setMinimumDistance(200);
  cam.setMaximumDistance(4000);
  
  //generate stars
  for(int i=0; i<stars.length; i++){
    stars[i]=new Stars();
  }
  //load sound source
  sample=new SoundFile(this, "sample.mp3");
  sample.play();
  
  //setup disc
  radius = 250; // Radius of the circle made
  number = 80; // Number of points making up the circle
  s = 500 / number; // Change the thickness of the blocks based on number so there is always a gap
  baseAngle = HALF_PI;
  angle = baseAngle;
  add = TWO_PI / number;
  // Create and patch the rms tracker
  fft = new FFT(this, bands);
  fft.input(sample);
  rms = new Amplitude(this);
  rms.input(sample);
}


void draw(){
  background(0);
  sum += (rms.analyze() - sum) * smoothFactor;
  //println(sum);
  float sp = sum * (55)*25;
  speed = map(sp/2, 0, width, 0, 20);
  //translate(width/2, height/2);
  
  for(int i=0; i<stars.length; i++){    
    stars[i].update();
    stars[i].display();
  }
   
  //draw the disc with amps and freq
  angle = baseAngle;
  spectrum = fft.analyze();
  
  directionalLight(l1, l2, l3,0, 1.5, 0.2);
  directionalLight(58, 251, 255, 0, -1, 0.5);
  noStroke();
  
  for (int i = 0; i < number; i++) {
  push();
  float spec = spectrum[i * 2];
  println("l:"+spec);
  float tallness = map(spec, 0, 255, 0, 100);
  println("t:"+tallness);
  float level = rms.analyze();
  println("l:"+level);
  float x1 = sin(angle) * radius; // Get the inner coords of the point on the circle using trig
  float y1 = cos(angle) * radius;
  println("x:"+x1+" y:"+y1);
  float modifier = (1+tallness*100) * (0.5+level/2); // This basically calculates the length of each line, play around with the values!
    //float modifier = tallness * 100000; 
  println("m:"+modifier);
    translate(x1, y1, 3*modifier); // Move the box to its point on the circle and adjust the height so it appears to stay still
    rotateZ(-angle);
    box(s*2.1, s*3, 10*modifier);
    //sphere(10*modifier);
    angle += add;
   pop();
  }
  
}

void keyPressed() {
  if(keyCode == RIGHT){
    count++;
    if (count == 1) {
      sample.jump(101); 
      l1=253;
      l2=73;
      l3=113;
      } 
     else if(count ==2) {
      sample.jump(221);
      cam.setDistance(50); 
      l1=101;
      l2=100;
      l3=165;
      directionalLight(74, 186, 162, -1, 1.5, 0.5);
      }
      else if(count ==3) {
      sample.jump(0);
      count=0;
      l1=180;
      l2=150;
      l3=80;
      }
  }
  if (keyCode == UP) {
      sample.pause();}
  if (keyCode == DOWN) {
      sample.play();
    }
  if (keyCode == SHIFT) {
      cam.setDistance(50); 
    }
}
