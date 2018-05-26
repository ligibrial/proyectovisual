class Cat{
PShape shape;
Node node;

Cat(){
    //shape = cubo.getShape();
    shape=loadShape("cat/cat.obj");
    node = new Node(scene) {
      // Note that within visit() geometry is defined at the
      // node local coordinate system.
      @Override
      public void visit() {
        render();
      }
    };
    node.setPosition(new Vector(catx, caty, catz));
  }
  
  
  PShape getShape(){
     System.out.println("entrando");
     return shape;
  }

  void render(){
    pushStyle();
    int kind = TRIANGLES;
    strokeWeight(2);
    stroke(color(0, 255, 0));
    fill(color(255, 0, 0, 125));
    
    scale(50);

    shape(shape,0,0);

    popStyle();
    hint(ENABLE_DEPTH_TEST);
  }
  
  
}