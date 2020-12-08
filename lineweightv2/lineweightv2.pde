//SETTINGS/////////////////////////////////
String imageName = "northwest csis.jpg";
float lineFreq = 120;
int lineAngle = 0;
int imageScale = 1;
color lineColor = color(255,255,255);
color backgroundColor = color(0,0,0,0);
boolean saveFrames = true;
int frames = 1;
int shapeType = 0; //0 for line, 1 for circle
boolean animatedInput = false;
int inputFrames = 0;

boolean gradient = false;
color c1 = color(255,255,255);
color c2 = color(0,0,0, 0);

boolean shapePulse = true;
int weightPulseAmt = 0; //0 for none
int lengthPulseAmt = 0; //0 for none

boolean customLength = true;
int lineLength = 30;

int zoomMotionType = 0; //0 for none, 1 for perlin noise, 2 for breathing effect, 3 for wave effect
// breathing goes from a line freq of 10 to your specified line freq
float breathingSpeed = lineFreq/35;
///////////////////////////////////////////



PImage image;
ArrayList<Shape> lines;
PImage img[] = new PImage[frames];

void setup() {
  background(backgroundColor);
  if (animatedInput) {
    for (int i = 0; i < inputFrames; i++) {
      img[i] = loadImage("gun " + i + ".png");
      surface.setSize(img[i].width*imageScale, img[i].height*imageScale);
      img[i].resize(width,height);
    }
  } else {
    image = loadImage(imageName);
    surface.setSize(image.width*imageScale, image.height*imageScale);
    image.resize(width,height);
  }
  frameRate(60);
}

int i = 10;
float lF = lineFreq;
float t = 0;
boolean forwards;
int pCount = 0;
int k = 0;
float j = 0;
int f = 0;

void draw() {
  background(backgroundColor);
  lines = new ArrayList<Shape>();
  if (zoomMotionType == 1) {
    //perlin noise line freq.
    t = t + 0.10;
    float r = noise(t);
    r = map(r,0,1,50,150);
  }
  if (zoomMotionType == 2) {
    //increment / decrement linefreq
    lineFreq = i;
    print(lineFreq);
    if (i < lF && forwards) {
      i+=breathingSpeed;
      forwards = true;
    } else if (i <= 10 && !forwards) {
      forwards = true;
      pCount++;
    } else {
      i-=breathingSpeed;
      forwards = false;
    }
  }
  for (int x = 0; x < width; x+=width/lineFreq) {
    for (int y = 0; y < height; y += height/lineFreq) {
      Shape line = new Shape(x,y);
      lines.add(line);
    }
    if (zoomMotionType == 3) {
      lineFreq = (lF/1.5 * sin(3*j)) + lF;
      j+=.106;
    }
  }
  color c = lineColor;
  for (Shape line : lines) {
    if (customLength) {
      line.setLength(lineLength);
    } else {
      line.setLength(width/(lineFreq));
    }
    if (shapePulse) {
      line.weightPulse(weightPulseAmt);
      line.lengthPulse(lengthPulseAmt);
    }
    if (gradient) {
      if (k == 0) {
        c = c1;
      } else if (k == lines.size()) {
        c = c2;
      } else {
        c = lerpColor(c1,c2,map(k,0,lines.size(),0,1));
      }
    }
    //c = color(int(random(0,255)),255,int(random(0,255)));
    if (shapeType == 1) {
      line.drawCircle(c);
    } else {
      PVector v = PVector.fromAngle(noise(line.y) * TWO_PI);
      //line.drawRect(c, v.heading() * 5);
      line.drawRect(c,lineAngle);
    }
    k++;
  }
  save("done/" + imageName);
  exit();
  if (!shapePulse && zoomMotionType == 0) {
    noLoop();
  }
  if (pCount == 2 && saveFrames) {
    noLoop();
  } else {
    saveFrame("frames/####.jpg");
  }
  if (zoomMotionType != 2 && saveFrames) {
    if (frameCount == frames) {
      noLoop();
    } else {
      saveFrame("frames/####.jpg");
    }
  }
  if (f == inputFrames-1) {
    f = 0;
  }
  f++;
  println(f);
}


float quantize(int stepVar, float input) {
  return stepVar * floor((input / stepVar) + .5);
}
float getWeight(int x, int y) {
  color c;
  if (animatedInput) {
    c = img[f].get(x,y);
  } else {
    c = image.get(x,y);
  }
  return map(quantize(17, brightness(c)),0,255,0,int(width/(lineFreq)/2));
}


class Shape {
  int x, y, weight, iWeight;
  float l, iL;
  float a;
  color c;
  Shape(int x, int y) {
    this.x = x;
    this.y = y;
    this.weight = int(getWeight(x,y));
    this.iWeight = weight;
    
  }
  void drawRect(color c, float a) {
    pushMatrix();
    rectMode(CENTER);
    translate(x,y);
    rotate(radians(a));
    fill(c);
    noStroke();
    rect(0,0,l,weight);
    popMatrix();
  }
  void drawCircle(color c) {
    pushMatrix();
    ellipseMode(CENTER);
    translate(x,y);
    fill(c);
    noStroke();
    ellipse(0,0,weight,weight);
    popMatrix();
  }
  void setLength(float l) {
    this.l = l;
    this.iL = l;
  }
  void lengthPulse(int r) {
    setLength(int(random(iL,iL + r)));
  }
  void setWeight(int weight) {
    this.weight = weight;
  }
  void weightPulse(int r) {
    if (iWeight != 0) {
      setWeight(int(random(iWeight, iWeight+r)));
    }
  }
}
