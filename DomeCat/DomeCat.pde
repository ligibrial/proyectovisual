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

float r = random(50);
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
  
  pushMatrix();
  r = random(-width,width);
  box(100,100,350);
  translate(r,r);
  System.out.println(r);
  popMatrix();
  
  lights();
  noStroke();
  translate(mouseX, mouseY, 0);
  rotateX(90);
  //rotateX(frameCount * 0.01);
  //rotateY(frameCount * 0.01);  
  sphere(100);
  //box(200);
  
  //gato =  new Cat();
  //gato.getShape();
  //translate(-150,-150);
}