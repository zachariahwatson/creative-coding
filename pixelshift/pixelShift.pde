int shiftAmt = int(random(1, int(random(25000, 500000))));
int offset = 0;

PImage image;
PImage sorted;
void setup() {
  image = loadImage("jYpcc0a.jpg");
  surface.setSize(image.width, image.height);
  sorted = createImage(image.width, image.height, RGB);
  sorted = image.get();
  sorted.loadPixels();
  for (int i = 0; i < image.pixels.length; i+= (shiftAmt*2)) {
    shiftAmt = int(random(1, int(random(25000, 500000))));
    if ((i + (shiftAmt*2)) > image.pixels.length) {
      shiftAmt = (image.pixels.length - i)/2;
    }
    if (shiftAmt != 0) {
      for (int j  = 0; j < shiftAmt; j++) {
        color temp = sorted.pixels[j+offset];
        sorted.pixels[j + offset] = sorted.pixels[j + offset + shiftAmt];
        sorted.pixels[j + offset + shiftAmt] = temp;
        //println("pixel " + (j + offset) + "/" + image.pixels.length + ", " + shiftAmt + " shift amount");
      }
      offset += shiftAmt*2;
    } else {
      //println("pixel " + image.pixels.length + "/" + image.pixels.length);
      break;
    }
  }
  sorted.updatePixels();
}

void draw() {
  background(0);
  image(sorted, 0, 0);
  save("pxlsort.jpg");
}
