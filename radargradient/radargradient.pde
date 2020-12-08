color c1, c2, c3, c4;
PVector center;
String imageName = "jeff-brown-xOj6_Ha1_R8-unsplash - Copy";
PImage image;
int imageScale = 2;
int circleType = 0; //0 for reg, 1 for treaded
int spaceBtwn = 10;
int tCircleAmt = 2;
int diameter = 69;
int vertices = diameter * 25 / imageScale;
color c;
float inter;
void setup() {
  image = loadImage(imageName + ".jpg");
  int w = image.width;
  int h = image.height;
  int roundedW = (w + diameter - 1 - (w - 1) % diameter)-diameter*2;
  int roundedH = (h + diameter - 1 - (h - 1) % diameter)-diameter;
  surface.setSize(roundedW*imageScale, roundedH*imageScale);
  image.resize(roundedW*imageScale, roundedH*imageScale);
}
void draw() {
  noFill();
  for (int i = 0; i <= height; i++) {
    float inter = map(i, 0, height, 0, 1);
    c = lerpColor(image.get(0,0), image.get(0, height-1), inter);
    stroke(c);
    line(0, i, width, i);
  }
  for (int x = diameter; x <= width; x+=diameter*2) {  
    for (int y = diameter; y <= height; y +=diameter*2) {
      center = new PVector(x, y);
      c4 = image.get(x+diameter/2, y-diameter/2);
      c3 = image.get(x-diameter/2, y-diameter/2);
      c2 = image.get(x-diameter/2, y+diameter/2);
      c1 = image.get(x+diameter/2, y+diameter/2);
      beginShape();
      for (float a=0; a<TWO_PI; a+=TWO_PI/vertices) {
        if (a <= PI/2) {
          inter = map(a, 0, PI/2, 0, 1);
          c = lerpColor(c1, c2, inter);
        } else if (a > PI/2 && a <= PI) {
          inter = map(a, PI/2, PI, 0, 1);
          c = lerpColor(c2, c3, inter);
        } else if (a > PI && a <= 3*PI/2) {
          inter = map(a, PI, 3*PI/2, 0, 1);
          c = lerpColor(c3, c4, inter);
        } else {
          inter = map(a, 3*PI/2, TWO_PI, 0, 1);
          c = lerpColor(c4, c1, inter);
        }
        stroke(c);
        if (circleType == 1) {
          for (int i = 0; i < diameter; i+= diameter/tCircleAmt) {
            if (i == 0) {
              line(center.x, center.y, center.x+diameter/tCircleAmt*cos(a), center.y+diameter/tCircleAmt*sin(a));
            } else {
              line(center.x+(i+spaceBtwn)*cos(a), center.y+(i+spaceBtwn)*sin(a), center.x+(i+diameter/tCircleAmt)*cos(a), center.y+(i+diameter/tCircleAmt)*sin(a));
            }
          }
        } else {
          line(center.x, center.y, center.x+diameter*cos(a), center.y+diameter*sin(a));
        }
      }
      endShape();
    }
  }
  noLoop();
  saveFrame("finished/" + imageName + ".jpg");
  exit();
}
