
//#########################################
//chunk size (amount of pixels sorted at a time) (set to image.width to sort to the right)
//program increments the chunk size of each frame from 0 to the specified number
int chunkNum = 5442;
//number of frames created
int frames = 4;
//0 = brightness, 1 = hue, 2 = saturation
int sortingType = 0;
int gif = 0;
//#########################################

PImage image;
PImage img[] = new PImage[frames];
PImage sorted;
PImage srted[] = new PImage[frames];
int offset;
float b;
int increment = chunkNum / frames;
int incrementOrig = increment; 
int f = 0;

void setup() {
  if (gif == 0) {
    image = loadImage("northwest csis2-01.png");  
    surface.setSize(image.width, image.height);
    sorted = createImage(image.width, image.height, RGB);
    sorted = image.get();
    sorted.loadPixels();
  } else {
    for (int i = 0; i < frames; i++) {
      img[i] = loadImage("f1 " + i + ".png");
      surface.setSize(img[i].width, img[i].height);
      srted[i] = createImage(img[i].width, img[i].height, RGB);
      srted[i] = img[i].get();
      srted[i].loadPixels();
    } 
  }
}

void draw() {
  if (gif == 0) {
    if (f < frames) {
      for (int k = 0; k < image.pixels.length; k+=increment) {
        if (image.pixels.length - k < increment) {
          offset = image.pixels.length - k;
        }
        else {
          offset = increment;
        }
        for (int i = k; i < k + offset; i++) {
          //println("pixel " + i + "/" + image.pixels.length + ", frame " + (f+1) + ", increment: " + increment);
          float record = -1;
          int selectedPixel = i;
          //sorted.pixels[i] = image.pixels[i];
          for (int j = i + 1; j < k + offset; j++) {
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
          color temp = sorted.pixels[i];
          sorted.pixels[i] = sorted.pixels[selectedPixel];
          sorted.pixels[selectedPixel] = temp;
        }
      }
      background(0);
      sorted.updatePixels();
      image(sorted, 0, 0);
      saveFrame("frames/frame_####.jpg");
      f += 1;
      increment += incrementOrig;
    }
  //noLoop();
  } else {
    if (f < frames) {  
      for (int k = 0; k < img[f].pixels.length; k+=increment) {
        if (img[f].pixels.length - k < increment) {
          offset = img[f].pixels.length - k;
        }
        else {
          offset = increment;
        }
        for (int i = k; i < k + offset; i++) {
          //println("pixel " + i + "/" + img[f].pixels.length + ", frame " + (f+1) + ", increment: " + increment);
          float record = -1;
          int selectedPixel = i;
          //sorted.pixels[i] = image.pixels[i];
          for (int j = i + 1; j < k + offset; j++) {
            color pix = srted[f].pixels[j];
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
          color temp = srted[f].pixels[i];
          srted[f].pixels[i] = srted[f].pixels[selectedPixel];
          srted[f].pixels[selectedPixel] = temp;
        }
      }
      background(0);
      srted[f].updatePixels();
      image(srted[f], 0, 0);
      saveFrame("frames/####.jpg");
      f += 1;
      increment += incrementOrig;
    } else {
      noLoop();
    }
  }
}
