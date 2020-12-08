////SETTINGS////
PImage image;
String imageName = "49679776893_e056b8dc55_o";
int imageScale = 3;
int vertices = 1000;
int circleFreq = 20;
color lineColor = color(255, 170, 100);
color backgroundColor = color(255, 219, 161);
////////////////


void setup(){
  image = loadImage(imageName + ".jpg");
  surface.setSize(image.width*imageScale, image.height*imageScale);
  image.resize(width, height);
}
void draw(){
  PVector center =new PVector(image.width/2,image.height/2);
  noStroke();
  for (int i = image.width/circleFreq; i > 1; i-=1) {
    vertices -= vertices/circleFreq/i;
    shapeMode(CENTER);
    beginShape();
    for(float a=0;a<TWO_PI;a+=TWO_PI/vertices){
      if (i % 2 == 1) {
        fill(lineColor);
        curveVertex(center.x+(i*circleFreq-getWeight(center,i*circleFreq,a))*cos(a),center.y+(i*circleFreq-getWeight(center,i*circleFreq,a))*sin(a));
      } else {
        fill(backgroundColor);
        curveVertex(center.x+i*circleFreq*cos(a),center.y+i*circleFreq*sin(a));
      }
      
    }
    endShape(CLOSE);
  }
  noLoop();
  saveFrame("finished/" + imageName + "####.jpg");
  exit();
}
float getWeight(PVector v, int i, float a) {
  float x = v.x+i*cos(a);
  float y = v.y+i*sin(a);
  color c = image.get(int(x), int(y));
  return map(quantize(20, brightness(c)),0,255,0,circleFreq+(circleFreq/(vertices/circleFreq)));
}
float quantize(int stepVar, float input) {
  return stepVar * floor((input / stepVar) + .5);
}
