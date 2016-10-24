class Building {
  PVector center;
  int DEPTH = CELL_SIZE*30;
  Cell [][][] cells;
  boolean [][][] nextState;
  int difficulty = 12;
  float horizontalModifier = 0.85;
  float verticalModifier = 0.45;
  
  Building() {
    
  }
  Building(PVector center) {
    int col = height/CELL_SIZE;
    int row = width/CELL_SIZE;
    int depth = DEPTH/CELL_SIZE;
    this.center = center;
    cells = new Cell[row][col][depth];
    nextState = new boolean[row][col][depth];
  }
  
  void update() {
  }
  
  void render() {
    for (int i = 0; i < width/CELL_SIZE; i++) {
      for (int j = 0; j < height/CELL_SIZE; j++) { 
        grid[i][j].render();
        for(int k = 0; k < DEPTH/CELL_SIZE; k++) {
          if(cells[i][j][k] != null) {
            if (k > maxHeight) {
              maxHeight = k;
            }
            cells[i][j][k].render();
          }
        }
      }
    }
  }
  
}