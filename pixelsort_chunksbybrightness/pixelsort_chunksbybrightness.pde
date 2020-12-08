
//0 = dark, 1 = light
int sortingType = 0;

//preview part of sorted image 0 = none, 1 = preview
int preview = 0;

int threshold = 50;

PImage image;
PImage sorted;
int chunkNum;
int offset = 0;
int loc;
float b;
boolean lastPixel = false;
void setup() {
  image = loadImage("woahdude.jpg");
  surface.setSize(image.width, image.height);
  sorted = createImage(image.width, image.height, RGB);
  sorted = image.get();
  sorted.loadPixels();
  while (offset < image.pixels.length) {
    for (int k = offset + 1; k < image.pixels.length; k++) {
      if (sortingType == 0) {
        if (brightness(sorted.pixels[k]) < threshold) {
          chunkNum = k - offset;
          break;
        }
      } else {
        if (brightness(sorted.pixels[k]) > threshold) {
          chunkNum = k - offset;
          break;
        }  
     }
    }
    for (int i = 0; i < chunkNum; i++) {
      loc = (offset + i);
      //println("pixel " + (loc + 1) + "/" + image.pixels.length);
      if (loc >= image.pixels.length) {
        break;
      }
      float record = -1;
      int selectedPixel = loc;
      //sorted.pixels[i] = image.pixels[i];
      for (int j = loc+1; j < offset + chunkNum; j++) {
        if (j >= image.pixels.length) {
          break;
        } else {
          color pix = sorted.pixels[j];
          switch (sortingType) {
          case 0:
            b = brightness(pix);
            break;
          case 1:
            b = hue(pix);
            break;
          case 2:
            b = saturation(pix);
            break;
          }
          if (b > record) {
            selectedPixel = j;
            record = b;
          }
        }
      }
      color temp = sorted.pixels[loc];
      sorted.pixels[loc] = sorted.pixels[selectedPixel];
      sorted.pixels[selectedPixel] = temp;
      //println(loc + "/" + image.pixels.length); debug
    }
    offset += chunkNum;
    
  }
  sorted.updatePixels();
}
void draw() {
  background(0);
  image(sorted, 0, 0);
  save("pxlsort.jpg");
}