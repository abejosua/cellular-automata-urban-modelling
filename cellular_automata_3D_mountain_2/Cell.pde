class Cell {
  PVector location;
  int size;
  color c;
  boolean life;
  
  public Cell() {
  }
  public Cell(int size, PVector location) {
    this.size = size;
    this.location = location;
    life = false;
  }
  
  void update() {
    
  }
  
  void render() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    if (life) {
      //fill(200, 0, 0, 100);
      fill(0, 200, 200, 100);
      noStroke();
      box(CELL_SIZE);
      //rect(0, 0, CELL_SIZE, CELL_SIZE);
      //sphere(CELL_SIZE);
    } else {
      fill(0, 0, 0, 0);
      
      stroke(255);
      //rect(0, 0, CELL_SIZE, CELL_SIZE);
      //box(CELL_SIZE);
      //noStroke();
    }
    
    //rect(0, 0, CELL_SIZE, CELL_SIZE);
    popMatrix();
  }
}