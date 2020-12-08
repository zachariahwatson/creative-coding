

int tileCount = 75;

int tileSize = 3000 / tileCount;

float noiseScale = .005;
Tile[] tiles = new Tile[tileCount*tileCount];


void setup() {
  size(3000, 3000);
  int index = 0;
  for (int x = 0; x < width; x+= tileSize) {
    for (int y = 0; y < height; y+= tileSize) {
      tiles[index++] = new Tile(x, y, tileSize);
    }
  }
}
void draw() {
  frameRate(4);
  background(22, 46, 43);
  stroke(88, 168, 123);
  noFill();
  for (Tile tile : tiles) {
    float n = noise(tile.x * noiseScale, tile.y * noiseScale /**- frameCount**/);
    strokeWeight(n * 3);
    if (n < .5) {
      tile.createTileA();
    } else {
      tile.createTileB();
    }
  }
  save("done/done.jpg");
}

class Tile {
  int x, y, size;
  Tile(int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }
  void createTileA() {
    pushMatrix();
    translate(x, y);
    arc(0, 0, size, size, 0, HALF_PI);
    arc(size, size, size, size, PI, PI+HALF_PI);    
    popMatrix();
  }
  void createTileB() {
    pushMatrix();
    translate(x, y);
    arc(size, 0, size, size, HALF_PI, PI);
    arc(0, size, size, size, PI+HALF_PI, 2 * PI);    
    popMatrix();
  }
}
