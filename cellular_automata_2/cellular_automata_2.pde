int CELL_SIZE = 10;
int DEPTH = 100;
//Cell [][][] cells;
Cell [][] cells;
boolean [][] nextState;

void setup() {
  size(1200, 800, P3D);
  //cells = new Cell[width/CELL_SIZE][height/CELL_SIZE][DEPTH/CELL_SIZE];
  
  int col = height/CELL_SIZE;
  int row = width/CELL_SIZE;
  
  cells = new Cell[row][col];
  nextState = new boolean[row][col];
  
  for (int i = 0, x = 0 ; x < width-0; x += CELL_SIZE, i++) {
    for (int j = 0, y = 0; y < height-0; y += CELL_SIZE, j++) {
      //for (int z = 0; z < 100; z += CELL_SIZE) {
      cells[i][j] = new Cell(CELL_SIZE, new PVector(x,y));
      //}
    }
  }
  
  populateBox(row/2, col/2);
  populateBox(row/2+10, col/2+10);
  
}

void populateBox(int row, int col) {
  cells[row-1][col-1].life = true;
  cells[row][col-1].life = true;
  cells[row+1][col-1].life = true;
  cells[row-1][col].life = true;
  cells[row][col].life = true;
  cells[row+1][col].life = true;
  cells[row-1][col+1].life = true;
  cells[row][col+1].life = true;
  cells[row+1][col+1].life = true;
}

void draw() {
  background(0);
  
  generateNextState();
  updateCurrentState();
  
  for (int i = 0; i < width/CELL_SIZE; i++) {
    for (int j = 0; j < height/CELL_SIZE; j++) {   
      cells[i][j].update();
      cells[i][j].render();
    }
  }
   camera(mouseX, mouseY, 700.0, // eyeX, eyeY, eyeZ
         width/2, height/2, 0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0);
  
}
void generateNextState() {
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
      if (livingNeighbors > 2 && livingNeighbors <= 4) {
        nextState[i][j] = true;
      } else {
        nextState[i][j] = false;
      }
    }
  }  
}

void updateCurrentState() {
  for (int i = 0; i < width/CELL_SIZE; i++) {
    for (int j = 0; j < height/CELL_SIZE; j++) {
      cells[i][j].life = nextState[i][j];
    }
  }
}