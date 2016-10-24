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
    if (life) {
      c = 200;
    } else {
      c = 50;
    }
  }
  
  void render() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    fill(c);
    stroke(255);
    //box(CELL_SIZE);
    rect(0, 0, CELL_SIZE, CELL_SIZE);
    popMatrix();
  }
}