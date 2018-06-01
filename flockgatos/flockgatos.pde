/**
 * Flock of Boids
 * by Jean Pierre Charalambos.
 * 
 * This example displays the 2D famous artificial life program "Boids", developed by
 * Craig Reynolds in 1986 and then adapted to Processing in 3D by Matt Wetmore in
 * 2010 (https://www.openprocessing.org/sketch/6910#), in 'third person' eye mode.
 * Boids under the mouse will be colored blue. If you click on a boid it will be
 * selected as the scene avatar for the eye to follow it.
 *
 * Press ' ' to switch between the different eye modes.
 * Press 'a' to toggle (start/stop) animation.
 * Press 'p' to print the current frame rate.
 * Press 'm' to change the mesh visual mode.
 * Press 't' to shift timers: sequential and parallel.
 * Press 'v' to toggle boids' wall skipping.
 * Press 's' to call scene.fitBallInterpolation().
 */

import frames.input.*;
import frames.input.event.*;
import frames.primitives.*;
import frames.core.*;
import frames.processing.*;

Scene scene;
int flockWidth = 1280;
int flockHeight = 720;
int flockDepth = 600;
boolean avoidWalls = true;
int catx=100,caty=100,catz=100;
int catmovex=0,catmovey=0,catmovez=0;

// visual modes
// 0. Faces and edges
// 1. Wireframe (only edges)
// 2. Only faces
// 3. Only points
int mode;

int initBoidNum = 10; // amount of boids to start the program with
ArrayList<Boid> flock;
ArrayList<Boid> cat;

Node avatar;
boolean animate = true;

PShape s,ct,sh,cube;
Cube cubo;
Cat gato;

//nuevo
PShape can;
float angle;


float weight = 50;
PShader texlightShader;
PImage label;

void setup() {
  size(1000, 800, P3D);
  //1
  scene = new Scene(this);
  scene.setBoundingBox(new Vector(0, 0, 0), new Vector(flockWidth, flockHeight, flockDepth));
  scene.setAnchor(scene.center());
  Eye eye = new Eye(scene);
  scene.setEye(eye);
  scene.setFieldOfView(PI / 3);
  //interactivity defaults to the eye
  scene.setDefaultGrabber(eye);
  scene.fitBall();
  // create and fill the list of boids
  //nuevo 
  
  
 // hint(DISABLE_DEPTH_MASK);
  cubo = new Cube();
  gato =  new Cat();
  s = cubo.getShape();
  ct = gato.getShape();
   
  
  hint(DISABLE_DEPTH_MASK);
  label = loadImage("lachoy4.jpg");
  can = createCan(100, 200, 32, label);
  texlightShader = loadShader("texlightfrag.glsl", "texlightvert.glsl");
  

  flock = new ArrayList();
 
  //new Boid(new Vector(),0);
  for (int i = 0; i < initBoidNum; i++)
    flock.add(new Boid(new Vector(flockWidth / 2, flockHeight / 2, flockDepth / 2),0));
  
  //  cat.add(new Boid(new Vector(flockWidth/2 , flockHeight/2 , flockDepth/2 ),1));
  

}

void draw() {
  background(0);
  ambientLight(128, 128, 128);
  directionalLight(255, 255, 255, 0, 1, -100);
  //NUEVO
  
  walls();
  // Calls Node.visit() on all scene nodes.
   scene.traverse();
  //nuevo 
  
  shader(texlightShader);
  pointLight(300, 300, 300, width/2, height, 300);
  translate(600, height/2);
  rotateY(angle);
  shape(can);  
  angle += 0.01;
  
}

void walls() {
  pushStyle();
  noFill();
  stroke(255);

  line(0, 0, 0, 0, flockHeight, 0);
  line(0, 0, flockDepth, 0, flockHeight, flockDepth);
  line(0, 0, 0, flockWidth, 0, 0);
  line(0, 0, flockDepth, flockWidth, 0, flockDepth);

  line(flockWidth, 0, 0, flockWidth, flockHeight, 0);
  line(flockWidth, 0, flockDepth, flockWidth, flockHeight, flockDepth);
  line(0, flockHeight, 0, flockWidth, flockHeight, 0);
  line(0, flockHeight, flockDepth, flockWidth, flockHeight, flockDepth);

  line(0, 0, 0, 0, 0, flockDepth);
  line(0, flockHeight, 0, 0, flockHeight, flockDepth);
  line(flockWidth, 0, 0, flockWidth, 0, flockDepth);
  line(flockWidth, flockHeight, 0, flockWidth, flockHeight, flockDepth);
  popStyle();
}
///////////////nuevo
PShape createCan(float r, float h, int detail, PImage tex) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  sh.texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);    
  }
  sh.endShape(); 
  return sh;
}

void keyPressed() {
  switch (keyCode) {
  case 'a':
    animate = !animate;
    break;
  case 's':
    if (scene.eye().reference() == null)
      scene.fitBallInterpolation();
    break;
  case 't':
    scene.shiftTimers();
    break;
  case 'p':
    println("Frame rate: " + frameRate);
    break;
  case 'v':
    avoidWalls = !avoidWalls;
    break;
  case 'm':
    mode = mode < 3 ? mode+1 : 0;
    break;
  case ' ':
    if (scene.eye().reference() != null) {
      scene.lookAt(scene.center());
      scene.fitBallInterpolation();
      scene.eye().setReference(null);
    } else if (avatar != null) {
      scene.eye().setReference(avatar);
      scene.interpolateTo(avatar);
    }
    break;
  
  case RIGHT:
    catmovex = min(1,catmovex+1);
    System.out.println(catmovex);
    break;
  case LEFT:
    catmovex = max(-1,catmovex-1);
    System.out.println(catmovex);
    break;
  case UP:
    catmovey = min(1,catmovey+1);
    System.out.println(catmovey);
    
   case DOWN:
    catmovey = min(1,catmovey-1);
    System.out.println(catmovey);
    

  }
}