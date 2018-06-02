int move = -1;
float boxX = width/2, boxY=height/2, boxZ;
int i = 1;
float rotZ, rotY, rotX;

void setup() {
  size(650, 650, P3D);
  noFill();
}

void draw() {
  background(0);
  pushMatrix();
  // some random rotation to make things interesting
  
  // start at the middle of the screen
  translate(boxX, boxY);
  
  if(move<0){
    
    move = int(random(1,25));
    i = 1;
    
    rotY = random(-180,180);
    rotZ = random(-180,180);
    rotX = random(-180,180);
    
    //rotateY(random(30));//rotateY(1.0); //yrot);
    //rotateZ(random(30));//rotateZ(2.0); //zrot);  
    // rotate in X a little more each frame
    //rotateX(frameCount/100.0);
    
    translate(0, i++, 0);
    
    System.out.println("entro");
    
     //for(;delay>0;delay--){
  }
  else {
    move--;
    //rotateX(rotX);
    //rotateY(rotY);
    rotateZ(rotZ);
    // offset from center
    translate(0, i++, 0);
    // draw a white box outline at (0, 0, 0)
    stroke(255);
    //box(50);
    //delay(1);
    // the box was drawn at (0, 0, 0), store that location
    boxX = modelX(0, 0, 0);
    boxY = modelY(0, 0, 0);
    boxZ = modelZ(0, 0, 0);
    // clear out all the transformations
    
    
    if(random(1)>0.5){
      if(boxX > width) boxX -= 20;
      if(boxX < 0) boxX += 20;
      if(boxY > height) boxY -=20;
      if(boxY < 0) boxY +=20;
    }
    else{
      if(boxX > width) boxX = 0;
      if(boxX < 0) boxX = width;
      if(boxY > height) boxY =0;
      if(boxY < 0) boxY =height;
    }
    
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
  System.out.println(boxX +" " + boxY + " " + boxZ + " " + i + " " + move);
  popMatrix();

  // draw another box at the same (x, y, z) coordinate as the other
  pushMatrix();
  translate(boxX, boxY, 0);
  stroke(255, 0, 0);
  box(50);
  popMatrix();
}

/* 
  
 //usaremos esta variable para hacer girar los cuadrados
float i = 0;
//y esta para el tono (hue) del color
float h = 0;
 
void setup(){
 size(300, 300);
 //cambiamos el modo para el rectángulo
 rectMode(CENTER);
 //y el de color
 colorMode(HSB, 100);
 //creamos un valor aleatorio para el tono
 h = random(100);
 //definimos el color de fondo
 background(h, 50, 50);
} 

void draw(){
  //tiramos un rectángulo del mismo color y tamaño del fondo a cada ciclo
  fill(h, 50, 50);
  rect(width/2, height/2, width, height);
  //borde y relleno del cuadrado
  stroke(#ffffff);
  fill(h*0.5, 50, 50);
  //trasladamos el punto 0,0 al centro de la ventana
  translate(i, i);
  //asignamos el valor de giro
  rotate(i);
  //y dibujamos el cuadrado
  rect(0, 0, 150, 150);
  //resereamos traslación y giro
  resetMatrix();
  //y repetimos con otro rectángulo
  stroke(0, 50);
  noFill();
  translate(i, i);
  rotate(-i/2);
  rect(0, 0, 156, 156);
  //esto hace que el valor del ángulo aumente a cada ciclo
  i = i + 0.01;
}*/