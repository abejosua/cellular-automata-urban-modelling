int CELL_SIZE = 10;
int DEPTH = 100;
//Cell [][][] cells;
Cell [][] cells;
void setup() {
  size(600,600, P3D);
  //cells = new Cell[width/CELL_SIZE][height/CELL_SIZE][DEPTH/CELL_SIZE];
  cells = new Cell[width/CELL_SIZE][height/CELL_SIZE];
  for (int i = 0, x = 0 ; x < width-0; x += CELL_SIZE, i++) {
    for (int j = 0, y = 0; y < height-0; y += CELL_SIZE, j++) {
      //for (int z = 0; z < 100; z += CELL_SIZE) {
      cells[i][j] = new Cell(CELL_SIZE, new PVector(x,y));
      //}
    }
  }
}

void draw() {
  background(0);
  
  for (int i = 0; i < width/CELL_SIZE; i++) {
    for (int j = 0; j < height/CELL_SIZE; j++) {
      // neighbor check
      int livingNeighbors = 0;
      for (int nx = -1; nx < 2; nx++) {
        for (int ny = -1; ny < 2; ny++) {
          int neighborX = i + nx;
          int neighborY = j + ny;
          if ((neighborX >= 0 && neighborY >= 0) && (neighborX < width/CELL_SIZE && neighborY < height/CELL_SIZE)) {
            if(cells[neighborX][neighborY].life) {
              livingNeighbors++;
            }
          }
          
        }
      }
      if (livingNeighbors > 2 && livingNeighbors < 4) {
        cells[i][j].life = true;
      } else {
        cells[i][j].life = false;
      }
      cells[i][j].update();
      cells[i][j].render();
    }
  }
   camera(mouseX, mouseY, 700.0, // eyeX, eyeY, eyeZ
         width/2, height/2, 0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0);
  
}