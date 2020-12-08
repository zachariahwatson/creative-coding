int total, total1, total2, total3, total4, r, g, b;




String imageName = "safak-atalay-9Z-SgyNBlhU-unsplash";  
int imageScale = 1;
int oWidth, oHeight;
float threshold = 1; //brightness threshold to determine if program recurs or not (smaller = more detail, less big squares)
int minWidth = 1; //smallest width program will go to
float biggestSquareSize = 1.0/32;
boolean stroke = false;
boolean gif = false;
boolean video = false;
int frames = 151;
PImage img[] = new PImage[frames];
int f = 0;
float thresholdTo = .001;



float i = threshold-thresholdTo;
void setup(){
  if (video == false) {
    img[0] = loadImage(imageName + ".jpg");
    surface.setSize(img[0].width*imageScale, img[0].height*imageScale);
    img[0].resize(width, height);
    oWidth = img[0].width;
    oHeight = img[0].height;
  } else {
    for(int i = 0; i < frames; i++) {
      img[i] = loadImage(imageName + " " + i + ".png");
      surface.setSize(img[i].width*imageScale, img[i].height*imageScale);
      img[i].resize(width, height);
    }
  }
}

void draw() {
  if (stroke) {
    strokeWeight(.25);
    stroke(color(img[0].get(0, 0)));
  } else { 
    noStroke();
  }
  if (gif) {
    drawSquares(0,0,img[0].width/2, img[0].height/2, i, minWidth);
    saveFrame("frames/####.jpg");
    i-=threshold/frames;
    if (i <= thresholdTo) {
      exit();
    }
  } else if (video) {
    if (f < frames) {
      drawSquares(0,0,img[f].width/2, img[f].height/2, threshold, minWidth);
      saveFrame("frames/" + imageName + "####.jpg");
      f += 1;
      println(f);
    }
  } else {
    drawSquares(0,0,img[0].width/2, img[0].height/2, i, minWidth);
    //img[0].resize(500, int(500 / (float(oWidth)/float(oHeight))));
    //drawSquares(0,0,500/2, int(500 / (float(oWidth)/float(oHeight)))/2, threshold, minWidth);
    /**surface.setSize(1000, int(1000 / (float(oWidth)/float(oHeight))));
    img[0].resize(width, height);
    if (keyPressed) {
      if (key == '1') {
        threshold -= .1;
        println(threshold);
        //surface.setSize(img[0].width*imageScale, img[0].height*imageScale);
        //redraw();
      }
      if (key == ENTER) {
        img[0].resize(oWidth, oHeight);
        drawSquares(0,0,oWidth/2, oHeight/2, threshold, minWidth);
        save("done/" + imageName + ".jpg");
        //delay(10000);
        exit();
      }
    }**/
    //saveFrame("frames/" + imageName + "####.jpg");
    /**surface.setSize(img[0].width*imageScale, img[0].height*imageScale);
    img[0].resize(width, height);**/
    save("done/" + imageName + ".jpg");
    exit();
  }
}
void drawSquares(int x, int y, int w, int l, float t, int minW) {
  //println("x: " + x +  ", y: " + y + ", w: " + w + ", l: " + l);
  fill(avgColor(x, y, w, l));
  rect(x, y, w, l);
  fill(avgColor(x+w, y, w, l));
  rect(x+w, y, w, l);
  fill(avgColor(x, y+l, w, l));
  rect(x, y+l, w, l);
  fill(avgColor(x+w, y+l, w, l));
  rect(x+w, y+l, w, l);
  if (w != 1 && w % 2 == 1) {
    w += 1;
    x -= 1;
  }
  if (l % 2 == 1) {
    l += 1;
    y -= 1;
  }
  if (w > minW) {
    if (checkBrightness(x, y, int(w/2), int(l/2), t) || w > img[0].width * (biggestSquareSize*2)) {
      drawSquares(x, y, int(w/2), int(l/2), t, minW);
    }
    if (checkBrightness(x+w, y, int(w/2), int(l/2), t) || w > img[0].width * (biggestSquareSize*2)) {
      drawSquares(x+w, y, int(w/2), int(l/2), t, minW);
    }
    if (checkBrightness(x, y+l, int(w/2), int(l/2), t) || w > img[0].width * (biggestSquareSize*2)) {
      drawSquares(x, y+l, int(w/2), int(l/2), t, minW);
    }
    if (checkBrightness(x+w, y+l, int(w/2), int(l/2), t) || w > img[0].width * (biggestSquareSize*2)) {
      drawSquares(x+w, y+l, int(w/2), int(l/2), t, minW);
    }
  }
}

boolean checkBrightness(int x, int y, int w, int l, float t) {
  //println(abs(brightness(image.get(int(x), int(y+l/2))) - brightness(image.get(int(x+w), int(y+l/2)))));
  //ellipse(x, y+l/2, 5, 5);
  //ellipse(x+w, y+l/2, 5, 5);
  
  
  /**if ((abs(brightness(image.get(int(x), int(y))) - brightness(image.get(int(x+w), int(y+l)))) >= t)
  || (abs(brightness(image.get(int(x), int(y+l))) - brightness(image.get(int(x+w), int(y)))) >= t)) {
    return true;
  }
  return false;**/
  
  total1 = 0;
  total2 = 0;
  total3 = 0;
  total4 = 0;
  total = 0;
  for (float i = y; i < y+l/2; i++) {
    for (float j = x; j < x+w/2; j++) {
      total1 += brightness(img[f].get(int(j), int(i)));
    }
  }
  for (float i = y+l/2; i < y+l; i++) {
    for (float j = x+w/2; j < x+w; j++) {
      total4 += brightness(img[f].get(int(j), int(i)));
    }
  }  
  
  for (float i = y; i < y+l/2; i++) {
    for (float j = x+w/2; j < x+w; j++) {
      total2 += brightness(img[f].get(int(j), int(i)));
    }
  }
  for (float i = y+l/2; i < y+l; i++) {
    for (float j = x; j < x+w/2; j++) {
      total3 += brightness(img[f].get(int(j), int(i)));
    }
  } 
  total1 /= w*l;
  total2 /= w*l;
  total3 /= w*l;
  total4 /= w*l;
  if ((abs(total1 - total4) >= t)
  || (abs(total2 - total3) >= t)) {
    return true;
  }
  return false;
  /**if (abs((total1 + total2 + total3 + total4)/4) >= t) {
    return true;
  }
  return false;**/
    
}

color avgColor(int x, int y, int w, int l) {
  r = 0;
  g = 0;
  b = 0;
  //println(int(w*l));
  if (w*l <= minWidth) {
    //println("ye");
    return color(img[f].get(int(x), int(y)));
  }
  for (float i = y; i < y+l; i++) {
    for (float j = x; j < x+w; j++) {
      r += red(img[f].get(int(j), int(i)));
      g += green(img[f].get(int(j), int(i)));
      b += blue(img[f].get(int(j), int(i)));
    }
  }
  //println(r/(w*l));
  return color(r/(w*l), g/(w*l), b/(w*l));
}
