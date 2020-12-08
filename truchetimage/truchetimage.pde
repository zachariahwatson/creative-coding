PImage[] tiles = new PImage[10];
PImage none;
int tileSize;

int tileCount = 25;


void setup() {
  size(3000, 3000);
  background(37, 36, 41);
  none = loadImage("none-01.jpg");
  for (int i = 0; i < 10; i++) {
    tiles[i] = loadImage("web" + (i+1) + "-01.jpg");
  }
  tileSize = width/tileCount;
  for (int i = 0; i < 10; i++) {
    tiles[i].resize(tileSize, tileSize);
  }
  none.resize(tileSize, tileSize);
}
void draw() {
  frameRate(5);
  for (int x = tileSize; x < width-tileSize; x+=tileSize) {
    for (int y = tileSize; y < width-tileSize; y+=tileSize) {
      //float n = noise(x * .7, y * .7);
      float n = random(0, 1);
      println(n);
      if (n >= 0 && n < .1) {
        image(tiles[0],x,y);
      } else if (n >= .1 && n < .28) {
        image(tiles[1],x,y);
      } else if (n >= .28 && n < .38) {
        image(tiles[2],x,y);
      } else if (n >= .38 && n < .39) {
        image(tiles[3],x,y);
      } else if (n >= .39 && n < .4) {
        image(tiles[4],x,y);
      } else if (n >= .5 && n < .6) {
        image(tiles[5],x,y);
      } else if (n >= .6 && n < .7) {
        image(tiles[6],x,y);
      } else if (n >= .7 && n < .8) {
        image(tiles[7],x,y);
      } else if (n >= .8 && n < .9) {
        image(tiles[8],x,y);
      } else if (n >= .9 && n < 1) {
        image(none,x,y);
      }
    }
  }
  save("done/" + frameCount + ".jpg");
}
