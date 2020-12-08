PImage image;
PImage sorted;
int i = 0;

void setup() {
  image = loadImage("chris-barbalis-xOiyY3vpaf8-unsplash.jpg");
  sorted = createImage(image.height, image.width,  RGB);
  
  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      int pixel = image.pixels[x + (y*image.width)];
      if (sorted.pixels[x + (y*image.width)] < image.pixels.length) {
        sorted.pixels[x + (y*image.width)] = pixel;
      }
    }
  }
  sorted.updatePixels();
}


void draw() {
  int increment = 20;
  int frames = 400;
  
  
  final float aspectratio = float(sorted.width) / float(sorted.height);
  int newHeight = sorted.height-i;
  image(sorted, 0,0, newHeight, (newHeight / aspectratio));
  surface.setSize(newHeight - (increment), int((newHeight / aspectratio)) - (increment));
  /*background(0);
  translate(image.width/2,image.height/2); 
  rotate(PI/3);
  image(image,-image.width/2,-image.height/2);
  save("pxlsort.jpg");*/
  
  /*for (int i = image.height; i > 1; i--) {
    delay(5);
    sorted.resize(image.height+1 - i, image.height+1 - i);
    surface.setSize(sorted.height, sorted.width);
  }*/
  //save("sort.jpg");
  i += increment;
  if (i != increment) {
    saveFrame("frames/####.jpg");
  }
  if (i == increment * frames) {
    noLoop();
  }
}
