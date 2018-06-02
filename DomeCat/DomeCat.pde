/**
 * DomeProjection
 * 
 * This sketch uses use environmental mapping to render the output 
 * on a full spherical dome.
 * 
 * Based on the FullDomeTemplate code from Christopher Warnow: 
 * https://github.com/mphasize/FullDome
 *
 * Note: This example needs desktop-class graphics to function.
 * 
 */
 
import java.nio.IntBuffer;
import frames.input.*;
import frames.input.event.*;
import frames.primitives.*;
import frames.core.*;
import frames.processing.*;

int catx=100,caty=100,catz=100;
int catmovex=0,catmovey=0,catmovez=0;
Scene scene;

boolean animate = true;

PShader cubemapShader;
PShape domeSphere;

IntBuffer fbo;
IntBuffer rbo;
IntBuffer envMapTextureID;

int envMapSize = 1024;   
Cat gato;
int x=0, y=0;

float r = random(100,300);

//--- caja
int boxmove=-1, boxi=1;;
int boxX=width/2, boxY=height/2, rotZ;


void setup() {
  size(640, 640, P3D);
  initCubeMap();
  //gato =  new Cat();
  //ct = gato.getShape();
}

void draw() {
  background(0);
  drawCubeMap();  
}

void drawScene() {  
  background(0);
  
  stroke(255, 0, 0);
  strokeWeight(2);
  for (int i = -width; i < 2 * width; i += 50) {
    line(i, -height, -100, i, 2 *height, -100);
  }
  for (int i = -height; i < 2 * height; i += 50) {
    line(-width, i, -100, 2 * width, i, -100);
  }
   
  
  /*
  for (int i=0; i<3; i++){
    box(100,100,350);
    translate(x++,y++);
  }
  */
  
  moveCaja();
  
  pushMatrix();
  lights();
  noStroke();
  translate(mouseX, mouseY);
  //System.out.println(mouseX + " " + mouseY);
  //rotateX(frameCount * 0.01);
  //rotateY(frameCount * 0.01);  
  sphere(100);
  //box(200);
  popMatrix();
  
  //gato =  new Cat();
  //gato.getShape();
  //translate(-150,-150);
  
  
  
}

void moveCaja(){
  pushMatrix();
  // some random rotation to make things interesting
  
  // start at the middle of the screen
  translate(boxX, boxY);
  
  if(boxmove<0){
    
    boxmove = int(random(1,25));
    boxi = 1;
    
    rotZ = int(random(-180,180));
    
    //rotateY(random(30));//rotateY(1.0); //yrot);
    //rotateZ(random(30));//rotateZ(2.0); //zrot);  
    // rotate in X a little more each frame
    //rotateX(frameCount/100.0);
    
    translate(0, boxi++, 0);
    
    System.out.println("entro");
    
     //for(;delay>0;delay--){
  }
  else {
    boxmove--;
    //rotateX(rotX);
    //rotateY(rotY);
    rotateZ(rotZ);
    // offset from center
    translate(0, boxi++, 0);
    // draw a white box outline at (0, 0, 0)
    stroke(255);
    //box(50);
    // the box was drawn at (0, 0, 0), store that location
    boxX = int(modelX(0, 0, 0));
    boxY = int(modelY(0, 0, 0));
    
    delay(45);
    
    if(boxX > width) boxX = 0;
    if(boxX < 0) boxX = width;
    if(boxY > height) boxY =0;
    if(boxY < 0) boxY =height;
    
    /*
    if(boxX > width || boxX < 0 || boxY > height || boxY < 0){
      if (i>0) i *= -1;
      translate(0, i, 0);
      //i = -1;
      //boxX = width/2;
      //boxY = height/2;
      //i--;
    }
    */
  }
  System.out.println(boxX +"\t" + boxY  + "\t-\t" + boxi + " " + boxmove + " " + rotZ);
  // clear out all the transformations
  popMatrix();

  // draw another box at the same (x, y, z) coordinate as the other
  pushMatrix();
  translate(boxX, boxY, 0);
  stroke(255, 0, 0);
  box(50);
  popMatrix();
}