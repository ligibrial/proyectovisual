
PShape ct,shape;

void setup() {
  size(640, 640, P3D);
  shape=loadShape("cat/cat.obj");

  
  //gato =  new Cat();
  //ct = gato.getShape();
}

void draw() {
  background(0);
 


sphere(50);
strokeWeight(2);
    stroke(color(0, 255, 0));
    fill(color(255, 0, 0, 125));
    
    
scale(150);
shape(shape);

}