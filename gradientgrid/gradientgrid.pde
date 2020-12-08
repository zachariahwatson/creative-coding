String imageName = "northwestlogo2-01";
int gradientType = 0; //0 for linear, 1 for radial
boolean edgeSmoothing = true;
boolean randomShapeFreq = true;
int shapeFreq = 75;
int iShapeFreq = shapeFreq;
int imageScale = 1;
PImage image;
ArrayList<Gradient> gradients;
void setup() {
  image = loadImage(imageName + ".jpg");
  surface.setSize(image.width*imageScale, image.height*imageScale);
  image.resize(width, height);
  background(color(image.get(1, 1)));
}
void draw() {
  gradients = new ArrayList<Gradient>();
  for (int x = 0; x <= width; x+=width/shapeFreq) {
    for (int y = 0; y <= height; y += height/shapeFreq) {
      Gradient shape = new Gradient(x, y, width/shapeFreq*2, height/shapeFreq*2);
      gradients.add(shape);
      if (randomShapeFreq) {
        shapeFreq = int(random(25, iShapeFreq));
      }
    }
  }
  for (Gradient shape : gradients) {
    if (gradientType == 0) {
      if (edgeSmoothing) {
        if (brightness(shape.getColor1(shape.x, shape.y)) - brightness(shape.getColor2(shape.x, shape.y)) > 10) {
          shape.drawLinearGradient(shape.getColor2(shape.x - shape.w/10, shape.y - shape.h), shape.getColor1(shape.x, shape.y));
        } else {
          shape.drawLinearGradient(shape.getColor1(shape.x, shape.y), shape.getColor2(shape.x, shape.y));
        }
      } else {
        shape.drawLinearGradient(shape.getColor1(shape.x, shape.y), shape.getColor2(shape.x, shape.y));
      }
    } else {
      if (edgeSmoothing) {
        if (brightness(shape.getColor1(shape.x, shape.y)) - brightness(shape.getColor2(shape.x, shape.y)) > 10) {
          shape.drawRadialGradient(shape.getColor2(shape.x - shape.w/20, shape.y - shape.h), shape.getColor1(shape.x, shape.y));
        } else {
          shape.drawRadialGradient(shape.getColor1(shape.x, shape.y), shape.getColor2(shape.x, shape.y));
        }
      } else {
        shape.drawRadialGradient(shape.getColor1(shape.x, shape.y), shape.getColor2(shape.x, shape.y));
      }
    }
  }
  saveFrame("done/" + imageName + "####.jpg");
  exit();
}
class Gradient {
  int x, y, w, h;
  color c1;
  color c2;
  Gradient(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  void drawLinearGradient(color c1, color c2) {
    pushMatrix();
    noFill();
    //translate(x,y);
    float r = random(0, 8);
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter*r);
      stroke(c);
      line(i, y, i, y+h);
    }
    popMatrix();
  }
  void drawRadialGradient(color c1, color c2) {
    pushMatrix();
    noStroke();
    //translate(x,y);
    float r = random(0.1, 2);
    for (int i = w; i > 0; i--) {
      float inter = map(i, w, 0, 0, 1);
      color c = lerpColor(c1, c2, inter);
      fill(c);
      ellipse(x, y, i, i);
      //h = (h + 1) % 360;
    }
    popMatrix();
  }
  color getColor1(int x, int y) {
    color c = image.get(x, y);
    return c;
  }
  color getColor2(int x, int y) {
    color c = image.get(x+w, y+h);
    return c;
  }
}
