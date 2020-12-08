//################################
//################################
//##########SETTINGS##############
int size = 478; //layer count of star
boolean showPoints = false; //displaying the hexagonal grid (recommended off for bigger grids)
//################################
//################################
//################################

int nodesPerLine = (size*2)+1;
int count = 0;
boolean counted = false;
boolean done = false;
int center = int(nodesPerLine/2+1);
Line photon = new Line(center,center,color(0, 120));
ArrayList<ArrayList<PVector>> grid = new ArrayList<ArrayList<PVector>>();

void setup() {
  
  //################################
  size(1000,1000); //change this to alter display size
  //################################
  
  shapeMode(CENTER);
  background(255,255,255);
  
  //initializing hexagonal grid using repeated drawRow
  for (int x = 0; x <= height/(height/nodesPerLine); x++) {
    grid.add(drawRow(0, height, x*height/(nodesPerLine+size/3*sqrt(2))+height/10, nodesPerLine, x));
  }
  
  //finding center
  ellipse(grid.get(nodesPerLine/2).get(nodesPerLine/2).x, (grid.get(nodesPerLine/2).get(nodesPerLine/2)).y, 3, 3);
  
  //creating "star"
  makeHexagon(size);
}

void draw() {
  count += 1;
  
  //if the photon intersects a line in the hexagon, stop the program
  if (intersect(grid.get(center-1).get(center+size-1), grid.get(center-size-1).get(center+size/2-1), photon.getPos(), photon.getPrevPos()) ||
  intersect(grid.get(center-size-1).get(center+size/2-1), grid.get(center-size-1).get(center-size/2-size%2-1), photon.getPos(), photon.getPrevPos()) ||
  intersect(grid.get(center-size-1).get(center-size/2-size%2-1), grid.get(center-1).get(center-size-1), photon.getPos(), photon.getPrevPos()) ||
  intersect(grid.get(center-1).get(center-size-1), grid.get(center+size-1).get(center-size/2-size%2-1), photon.getPos(), photon.getPrevPos()) ||
  intersect(grid.get(center+size-1).get(center-size/2-size%2-1), grid.get(center+size-1).get(center+size/2-1), photon.getPos(), photon.getPrevPos()) ||
  intersect(grid.get(center+size-1).get(center+size/2-1), grid.get(center-1).get(center+size-1), photon.getPos(), photon.getPrevPos())) {
    textSize(25);
    fill(255);
    rect(0, height-40, width, 40);
    fill(0);
    text("exited " + size + " layer star at count " + count + ", time elapsed: " + nf(count / 60.0, 0, 2) + " seconds", 10, height-10);
    noLoop();
    saveFrame("finished/####.jpg");
    done = true;
  }
  
  //if not, move the photon a random direction
  if (!done) {
    strokeWeight(1);
    photon.escape();
  }
}

//"photon" class
class Line {
  int posX, posY, prevPosX, prevPosY;
  color c;
  Line (int posX, int posY, color c) {
    this.posX = posX-1;
    this.posY = posY-1;
    this.c = c;
    this.prevPosX = posX-1;
    this.prevPosY = posY-1;
  }
  
  //photon moves a random direction
  void escape() {
    int r = int(random(1, 7));
    switch (r) {
      case 1:
        upLeft();
        break;
      case 2:
        upRight();
        break;
      case 3:
        right();
        break;
      case 4:
        downRight();
        break;
      case 5:
        downLeft();
        break;
      case 6:
        left();
        break;
    }
  }
  
  //getting positions for intersection detection
  PVector getPos() {
    return new PVector(grid.get(posY).get(posX).x, (grid.get(posY).get(posX)).y);
  }
  PVector getPrevPos() {
    return new PVector(grid.get(prevPosY).get(prevPosX).x, (grid.get(prevPosY).get(prevPosX)).y);
  }
  
  //movement commands
  void left() {
    stroke(c);
    line((grid.get(posY).get(posX).x), (grid.get(posY).get(posX)).y, (grid.get(posY).get(posX-1)).x, (grid.get(posY).get(posX-1)).y);
    prevPosX = posX;
    posX -= 1;
  }
  void right() {
    stroke(c);
    line((grid.get(posY).get(posX).x), (grid.get(posY).get(posX)).y, (grid.get(posY).get(posX+1)).x, (grid.get(posY).get(posX+1)).y);
    prevPosX = posX;
    posX += 1;
  }
  void upLeft() {
    stroke(c);
    if (posY % 2 == 0) {
      line((grid.get(posY).get(posX).x), (grid.get(posY).get(posX)).y, (grid.get(posY-1).get(posX)).x, (grid.get(posY-1).get(posX)).y);
    } else {
      line((grid.get(posY).get(posX).x), (grid.get(posY).get(posX)).y, (grid.get(posY-1).get(posX-1)).x, (grid.get(posY-1).get(posX-1)).y);
      prevPosX = posX;
      posX -= 1;
    }
    prevPosY = posY;
    posY -= 1;
  }
  void downLeft() {
    stroke(c);
    if (posY % 2 == 0) {
      line((grid.get(posY).get(posX).x), (grid.get(posY).get(posX)).y, (grid.get(posY+1).get(posX)).x, (grid.get(posY+1).get(posX)).y);
    } else {
      line((grid.get(posY).get(posX).x), (grid.get(posY).get(posX)).y, (grid.get(posY+1).get(posX-1)).x, (grid.get(posY+1).get(posX-1)).y);
      prevPosX = posX;
      posX -= 1;
    }
    prevPosY = posY;
    posY += 1;
  }
  void upRight() {
    stroke(c);
    if (posY % 2 == 0) {
      line((grid.get(posY).get(posX).x), (grid.get(posY).get(posX)).y, (grid.get(posY-1).get(posX+1)).x, (grid.get(posY-1).get(posX+1)).y);
      prevPosX = posX;
      posX += 1;
    } else {
      line((grid.get(posY).get(posX).x), (grid.get(posY).get(posX)).y, (grid.get(posY-1).get(posX)).x, (grid.get(posY-1).get(posX)).y);
    }
    prevPosY = posY;
    posY -= 1;
  }
  void downRight() {
    stroke(c);
    if (posY % 2 == 0) {
      line((grid.get(posY).get(posX).x), (grid.get(posY).get(posX)).y, (grid.get(posY+1).get(posX+1)).x, (grid.get(posY+1).get(posX+1)).y);
      prevPosX = posX;
      posX += 1;
    } else {
      line((grid.get(posY).get(posX).x), (grid.get(posY).get(posX)).y, (grid.get(posY+1).get(posX)).x, (grid.get(posY+1).get(posX)).y);
    }
    prevPosY = posY;
    posY += 1;
  }
}

//drawing row of hexagonal grid, determines if row should be offset by half or not
//also returns all points in row as an array
ArrayList drawRow(float x1, float x2, float y, float nodes, float even) {
  ArrayList<PVector> points = new ArrayList<PVector>();
  float dist = x2 - x1;
  fill(0);
  if (even % 2 == 0) {
    for(float i = 0; i <= nodes-1; i++) {
      if (showPoints) {
        point(y, i*dist/nodesPerLine+(width/nodesPerLine/2));
      }
      points.add(new PVector(y, i*dist/nodesPerLine+(width/nodesPerLine/2)));
    }
  } else {
    for(float i = 0; i <= nodes; i++) {
      if (showPoints) {
        point(y, i*dist/nodesPerLine);
      }
      points.add(new PVector(y, i*dist/nodesPerLine));
    }
  }
  return points;
}

//finding orientation of 3 ordered points in order to find if two lines intersect
int orientation(PVector p1, PVector p2, PVector p3) {
  int val = int((p2.y - p1.y) * (p3.x - p2.x) - (p2.x - p1.x) * (p3.y - p2.y)); 
  if (val == 0) {
    return val;
  } else if (val > 0) {
    return 1;
  } else {
    return 2;
  }
}

//determining if two lines intersect
boolean intersect(PVector p1, PVector q1, PVector p2, PVector q2) {
  int o1 = orientation(p1, q1, p2); 
  int o2 = orientation(p1, q1, q2); 
  int o3 = orientation(p2, q2, p1); 
  int o4 = orientation(p2, q2, q1); 
  if (o1 != o2 && o3 != o4) {
     return true; 
  }
  return false;
}

//makes creating hexagon easier
void makeLine(int x1, int y1, int x2, int y2) {
  line(grid.get(y1-1).get(x1-1).x, grid.get(y1-1).get(x1-1).y, grid.get(y2-1).get(x2-1).x, grid.get(y2-1).get(x2-1).y);
}

//makes hexagon of any size using coordinates of hexagonal grid
void makeHexagon(int size) {
  int center = int(nodesPerLine/2+1);
  makeLine(center+size, center, center+size/2, center-size);
  makeLine(center+size/2, center-size, center-size/2-size%2, center-size);
  makeLine(center-size/2-size%2, center-size, center-size, center);
  makeLine(center-size, center, center-size/2-size%2, center+size);
  makeLine(center-size/2-size%2, center+size, center+size/2, center+size);
  makeLine(center+size/2, center+size, center+size, center);
}
