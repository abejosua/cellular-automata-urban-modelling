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
      fill(255, 255, 255, 100);
      noStroke();
    } else {
      fill(0, 0, 0, 0);
      //stroke(255);
      noStroke();
    }
    box(CELL_SIZE);
    //rect(0, 0, CELL_SIZE, CELL_SIZE);
    popMatrix();
  }
}