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

int movexgato=0;
int moveygato=0;
int posxgato=0;
int posygato=0;
int puntos=0;
PShape bread;
int pospanx=100;
int pospany=100;
PFont font;
int panx=int(random(100,105));
int pany=int(random(100,105));
PShader edges;
boolean enabled = true;


void setup() {
  size(640, 640, P3D);
//  bread = loadShape("bread/Bread.obj");
  initCubeMap();
  
  font = createFont("Arial Bold",48);
  colorMode(RGB, 1);
  //fill(0.4);
 
}

void draw() {
  background(0);
  drawCubeMap();
  fill(1);
  textFont(font,30); //texto de la fuente del FPS
  text("Días de Lluvia",-100,-height/2.3);
  text(puntos,0.05,0.05);  
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
  
  pushMatrix();
  translate(panx,pany,0);
  //scale(50);
  //shape(bread);
  box(40);
  
  popMatrix();
  
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
  //translate(mouseX, mouseY);
  //System.out.println(mouseX + " " + mouseY);
  //rotateX(frameCount * 0.01);
  //rotateY(frameCount * 0.01);  
  //sphere(100);

  
  System.out.println("panx"+panx);
  System.out.println("pany"+pany);
  
  movimientoGato();
  
  //gato =  new Cat();
  //gato.getShape
  
 // colorMode(RGB, 1);
  fill(0.4);
  
  lightSpecular(1, 1, 1);
  directionalLight(0.8, 0.8, 0.8, 0, 0, -1);
  float s = 1 - (sqrt((pow(panx-posxgato,2) + pow(pany-posygato,2))) / 400 );  //mouseX / float(width); sqrt(width*height)
  specular(s, s, s);
  System.out.println("sssssssssssv "+s);
  
  sphere(30);
  
  popMatrix();
  //translate(-150,-150);
}

void movimientoGato(){
  switch (keyCode) {
    case RIGHT:
      System.out.println("entrando a derecha");
      
      posxgato=movexgato+=1;//.3*frameCount;
      translate(posxgato, posygato,0);
      puntos();
      break;
    case LEFT:
      System.out.println("entrando a izquierda");
      posxgato=movexgato-=1;//.3*frameCount;
      translate(posxgato, posygato,0);
      puntos();
      break;
    case UP:
      System.out.println("entrado arriba");
      posygato=moveygato-=1;//.1*frameCount;
      translate(posxgato,posygato,0);
      puntos(); 
      break;
    case DOWN:
      System.out.println("entrando abajo");
      posygato=moveygato+=1;//.1*frameCount;
      translate(posxgato,posygato,0);
      puntos();
      break;
    }
    
    System.out.println("pospanx--------------------"+pospanx);
    System.out.println("pospany--------------------"+pospany);
    System.out.println("posxgato-------------------"+posxgato);
    System.out.println("moveygato------------------"+posygato);
}

int diferenciax = 60, diferenciay = 40;

void puntos(){
  if(posygato >= pany-diferenciay &&  posygato <= pany+diferenciay && posxgato >= panx-diferenciax &&  posxgato <= panx+diferenciax){
    puntos++;
    for (int i = 0; i < 10; i++) {
      panx=int(random(1, height));
      pany=int(random(1, width));
      println(panx + " " + pany);
    }
    System.out.println("puntos"+puntos);
  }
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
    
    //System.out.println("entro");
    
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
    
    delay(145);
    
    if(boxX > width) boxX = 0;
    if(boxX < 0) boxX = width;
    if(boxY > height) boxY =0;
    if(boxY < 0) boxY =height;
    
    
  }
  //System.out.println(boxX +"\t" + boxY  + "\t-\t" + boxi + " " + boxmove + " " + rotZ);
  // clear out all the transformations
  popMatrix();

  // draw another box at the same (x, y, z) coordinate as the other
  pushMatrix();
  translate(boxX, boxY, 0);
  stroke(255, 0, 0);
  box(25);
  //ellipse(56, 46, 55, 55);
   
  popMatrix();
}