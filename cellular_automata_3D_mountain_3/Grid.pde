class Grid extends Cell {
  Grid() {
  }
  Grid(int size, PVector location) {
    super(size, location);
  }
  
  void render() {
    
    pushMatrix();
    translate(location.x, location.y, location.z);
    if (life) {
      fill(255, 255, 255, 255);
      noStroke();
      box(CELL_SIZE);
    } else {
      fill(0, 0, 0, 0); 
      stroke(255);
      rect(0, 0, CELL_SIZE, CELL_SIZE);
      //box(CELL_SIZE);
      //noStroke();
    }
    
    //rect(0, 0, CELL_SIZE, CELL_SIZE);
    popMatrix();
  }
}