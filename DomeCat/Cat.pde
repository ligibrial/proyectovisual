class Cat{
Vector position;
PShape shape;
Node node;

Cat(){
    //shape = cubo.getShape();
    shape=loadShape("cat/cat.obj");
    
    position = new Vector();
    position.set(new Vector(catx, caty, catz));
    render();
  }
  
  
  PShape getShape(){
     //System.out.println("entrando--------");
     return shape;
  }

  void render(){
    pushStyle();
    
   // scene.drawAxes(100);

    strokeWeight(2);
    stroke(color(0, 255, 0));
    fill(color(255, 0, 0, 125));
    
    scale(150);

    shape(shape,0,0);

    popStyle();
    hint(ENABLE_DEPTH_TEST);
  }
  
  void move() {
    
    position.add(new Vector(catmovex, catmovey, catmovez)); // add velocity to position
    System.out.println( position.x() + " " + position.y() + " " + position.z() + " ");
    node.setPosition(position);
  }
  
}