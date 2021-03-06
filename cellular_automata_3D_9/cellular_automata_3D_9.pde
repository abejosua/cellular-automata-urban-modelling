int CELL_SIZE = 20;
int DEPTH = CELL_SIZE*20;
Cell [][][] cells;
//Cell [][] cells;
boolean [][][] nextState;
int difficulty = 12;
int maxHeight = 0;
int centerX;
int centerY;
int delay = 100;

Cell [][] grid;

void setup() {
  size(1200, 800, P3D);
  background(0);
  //cells = new Cell[width/CELL_SIZE][height/CELL_SIZE][DEPTH/CELL_SIZE];
  
  int col = height/CELL_SIZE;
  int row = width/CELL_SIZE;
  int depth = DEPTH/CELL_SIZE;
  centerX = row/2;
  centerY = col/2;
  println(centerX + " " + centerY);
  
  cells = new Cell[row][col][depth];
  nextState = new boolean[row][col][depth];
  
  grid = new Cell[row][col];
  
  for (int i = 0, x = 0 ; x < width-0; x += CELL_SIZE, i++) {
    for (int j = 0, y = 0; y < height-0; y += CELL_SIZE, j++) {
      grid[i][j] = new Cell(CELL_SIZE, new PVector(x,y,0));
      grid[i][j].life = false;
  //    for (int k = 0, z = 0; k < depth; z += CELL_SIZE, k++) {
  //      cells[i][j][k] = new Cell(CELL_SIZE, new PVector(x,y,z));
  //    }
    }
  }
  
  populateBox(row/2, col/2, 0);
  
}

void populateBox(int row, int col, int depth) {
  generateCell(row-1, col-1, depth);
  generateCell(row, col-1, depth);
  generateCell(row+1, col-1, depth);
  generateCell(row-1, col, depth);
  //generateCell(row, col, depth);
  //cells[row+1][col][depth].life = true;
  //cells[row-1][col+1][depth].life = true;
  //cells[row][col+1][depth].life = true;
  //cells[row+1][col+1][depth].life = true;
}

void draw() {
  background(0);
  lights();
  
  generateNextState();
  updateCurrentState();
  
  for (int i = 0; i < width/CELL_SIZE; i++) {
    for (int j = 0; j < height/CELL_SIZE; j++) { 
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
  
  
   camera(mouseX*3, mouseY*3, 700.0, // eyeX, eyeY, eyeZ
         width/2, height/2, 100, // centerX, centerY, centerZ
         0.0, 1.0, 0.0);
   delay(delay);
   //println(maxHeight);
  
}
void generateNextState() {
  for (int i = 0; i < width/CELL_SIZE; i++) {
    for (int j = 0; j < height/CELL_SIZE; j++) {
      for (int k = 0; k < DEPTH/CELL_SIZE; k++) {
        // neighbor check
        int livingNeighbors = 0;
        for (int nx = -1; nx < 2; nx++) {
          for (int ny = -1; ny < 2; ny++) {
            for (int nz = -1; nz < 2; nz++) {
              int neighborX = i + nx;
              int neighborY = j + ny;
              int neighborZ = k + nz;
              if ((neighborX >= 0 && neighborY >= 0 && neighborZ >= 0) && (neighborX < width/CELL_SIZE && neighborY < height/CELL_SIZE && neighborZ < DEPTH/CELL_SIZE)) {
                if(cells[neighborX][neighborY][neighborZ] != null && cells[neighborX][neighborY][neighborZ].life) {
                  livingNeighbors++;
                }
              }
            }
            
            
          }
        }
        if ((livingNeighbors >= 2 && livingNeighbors <= difficulty-((k*.35)+abs(i-centerX)*.8+abs(j-centerY)*.8))) {
          nextState[i][j][k] = true;
        } else {
          nextState[i][j][k] = false;
        }
      }
      
    }
  }  
}

void updateCurrentState() {
  for (int i = 0; i < width/CELL_SIZE; i++) {
    for (int j = 0; j < height/CELL_SIZE; j++) {
      for (int k = 0; k < DEPTH/CELL_SIZE; k++) {
        if(nextState[i][j][k])
          generateCell(i, j, k);
        else
          killCell(i, j, k);
      }
      
    }
  }
}

void generateCell(int i, int j, int k) {
  if (cells[i][j][k] == null) {
    cells[i][j][k] = new Cell(CELL_SIZE, new PVector(i*CELL_SIZE, j*CELL_SIZE, k*CELL_SIZE));  
  }
  cells[i][j][k].life = true;
}

void killCell(int i, int j, int k) {
  if (cells[i][j][k] != null) {
    cells[i][j][k].life = false;
  }
}