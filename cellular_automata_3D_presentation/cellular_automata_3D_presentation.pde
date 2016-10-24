int CELL_SIZE = 50;
int DEPTH = CELL_SIZE*30;
Cell [][][] cells;
boolean [][][] nextState;
int difficulty = 12;
int maxHeight = 0;
int centerX;
int centerY;
int delay = 80;
float horizontalModifier = 0.95;
float verticalModifier = 0.95;

Grid [][] grid;

void setup() {
  size(1200, 800, P3D);
  background(0);
  //cells = new Cell[width/CELL_SIZE][height/CELL_SIZE][DEPTH/CELL_SIZE];
  
  int col = height/CELL_SIZE;
  int row = width/CELL_SIZE;
  int depth = DEPTH/CELL_SIZE;
  centerX = row/2;
  centerY = col/2;
  //println(centerX + " " + centerY);
  
  cells = new Cell[row][col][depth];
  nextState = new boolean[row][col][depth];
  
  grid = new Grid[row][col];
  
  for (int i = 0, x = 0 ; x < width-0; x += CELL_SIZE, i++) {
    for (int j = 0, y = 0; y < height-0; y += CELL_SIZE, j++) {
      grid[i][j] = new Grid(CELL_SIZE, new PVector(x,y,0));
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
  background(102);
  lights();
  
  generateNextState();
  updateCurrentState();
  
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
  
  String text = "rapidly tap a, s, z, x to alter the structure";
  fill(255);
  pushMatrix();
  rotateX(-PI/2);
  translate(0, -450);
  textSize(50);
  text(text, 50, 30);
  
  popMatrix();
  
  
   camera(mouseX, height*1.5, 1200.0, // eyeX, eyeY, eyeZ
         width/2, height/2, 100, // centerX, centerY, centerZ
         0.0, 1.0, 0.0);
   delay(delay);
   println(maxHeight);
  
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
        if ((livingNeighbors >= 2 && livingNeighbors <= difficulty-((k*verticalModifier)+abs(i-centerX)*horizontalModifier+abs(j-centerY)*horizontalModifier))) {
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

void incrementHeight() {
  if(verticalModifier > 0.25) {
    verticalModifier -= .025;
  }
}

void decrementHeight() {
  if (verticalModifier < 0.95) {
    verticalModifier += .025;
  }
}

void incrementArea() {
  if (horizontalModifier > 0.25) {
    horizontalModifier -= .025;
  }
  
}

void decrementArea() {
  if (horizontalModifier < 0.95) {
    horizontalModifier += .025;
  }
}

void keyPressed() {
  println(key);
  if (key == 'a') {
    incrementHeight();
  } else if (key == 's') {
    decrementHeight();
  }
  if (key == 'z') {
    incrementArea();
  } else if (key == 'x') {
    decrementArea();
  }
  
}