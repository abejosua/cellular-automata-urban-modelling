int currentLevel = 0;
int maxLevel = 30;

int CELL_SIZE = 100;
int DEPTH = CELL_SIZE*maxLevel + CELL_SIZE;
int WIDTH = CELL_SIZE*5;
int HEIGHT = CELL_SIZE*5;
Cell [][][] cells;
boolean [][][] nextState;

int cameraZ = 700;

void setup() {
  size(1200, 800, P3D);
  background(0);
  //cells = new Cell[width/CELL_SIZE][height/CELL_SIZE][DEPTH/CELL_SIZE];
  
  int col = height/CELL_SIZE;
  int row = width/CELL_SIZE;
  int depth = DEPTH/CELL_SIZE;
  
  cells = new Cell[row][col][100000];
  
  populateBox(row/2, col/2, 0);
  //populateBox(row/3+10, col/3+10, 0);
  
}

void populateBox(int row, int col, int depth) {
  generateCell(row-1, col-1, depth);
  generateCell(row, col-1, depth);
  generateCell(row+1, col-1, depth);
  generateCell(row-1, col, depth);
  generateCell(row, col, depth);
  generateCell(row+1,col,depth);
  //generateCell(row-1,col+1,depth);
  //generateCell(row,col+1,depth);
  //generateCell(row+1,col+1,depth);
}

void draw() {
  background(255);
  lights();
  
  
  
  for (int i = 0; i < width/CELL_SIZE; i++) {
    for (int j = 0; j < height/CELL_SIZE; j++) { 
      for(int k = 0; k < DEPTH/CELL_SIZE; k++) {
        if(cells[i][j][k] != null) {
          cells[i][j][k].render();
        }
      }
    }
  }
  
  //if(currentLevel < 10) {
    generateNextLevel(currentLevel);
    currentLevel++;
  //}
  
  
   camera(mouseX*5, mouseY*5, cameraZ, // eyeX, eyeY, eyeZ
         width/2, height/2, 0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0);
   //cameraZ+= CELL_SIZE;
   delay(10);
  
}

void generateNextLevel(int level) {
  for (int i = 0; i < width/CELL_SIZE; i++) {
    for(int j = 0; j < height/CELL_SIZE; j++) {
      // neighbor check
        int livingNeighbors = 0;
        for (int nx = -1; nx < 2; nx++) {
          for (int ny = -1; ny < 2; ny++) {    
            for (int nz = -1; nz < 2; nz++) {
              int neighborX = i + nx;
              int neighborY = j + ny;
              int neighborZ = level + nz;
              if ((neighborX >= 0 && neighborY >= 0 && neighborZ >= 0) && (neighborX < width/CELL_SIZE && neighborY < height/CELL_SIZE && neighborZ < DEPTH/CELL_SIZE)) {
                if(cells[neighborX][neighborY][neighborZ] != null && cells[neighborX][neighborY][neighborZ].life) {
                  livingNeighbors++;
                }
              }
            }
          }
        }
        if ((livingNeighbors >= 3 && livingNeighbors <= 4)) {
          generateCell(i,j,level+1);
        } 
        else if(livingNeighbors > 4) {
          killCell(i, j, level);
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