int lineCount = 100;
int segmentNum = 50;
int borderY = 100;
int border = 100;
float scrollY = 0;
float scrollX = 0;



void setup() {
  size(2000,2000);
}
void draw() {
  background(71, 40, 54);
  scrollY += map(noise(frameCount * .05), 0, 1, -.005,.005);
  float yoff = scrollY;
  for (int y = borderY; y <= height-borderY; y+= (height-borderY*2)/lineCount) {
    /**println("control point 1: " + n2 + ", " + (y - n1));
    bezier(0,y,n2,y - n1,width*4/4 - n2,y + n1,width*4/4,y);
    //bezier(width*1/4,y,width*1/4 + n2,y + n1,width*2/4 - n2,y + n1,width*2/4,y);
    //bezier(width*2/4,y,width*2/4 + n2,y - n1,width*3/4 - n2,y - n1,width*3/4,y);
    //bezier(width*3/4,y,width*3/4 + n2,y + n1,width*4/4 - n2,y + n1,width*4/4,y);
    //bezier(width/2 - n1,y,n2,y - n1,width - n2,y - n1,width*2,y);**/
    beginShape();
    stroke(249, 219, 109);
    strokeWeight(5);
    strokeCap(SQUARE);
    noFill();
    scrollX += map(noise(frameCount * .05), 0, 1, .0001,.00035);
    float xoff = scrollX;
    //curveVertex(border,y);
    for (int x = border; x <= width-border; x += (width-border*2)/segmentNum) {
      /**float n1 = noise(x, y) * .7;
      float n2 = noise(x * .02, y + frameCount * .005);
      println(frameCount);
      n1 = map(n1,0,1,0,20);
      n2 = map(n2,0,1,-10,10);**/
      float n2 = map(noise(xoff, yoff), 0, 1, -60,60);
      vertex(x + n2, y + n2);
      xoff += 0.05; 
      //xoff += frameCount * .0005;
    }
    //curveVertex(width - border,y);
    yoff += 0.1;
    //yoff += frameCount * .0005;
    endShape();
  }
  for (int y = borderY; y <= height-borderY; y+= (height-borderY*2)/lineCount) {
    //stroke(255, 174, 0);
    stroke(54, 130, 127);
    strokeWeight(10);
    line(borderY, y-50, width-borderY, y+50);
  }
  /**fill(255);
  noStroke();
  rect(0, 0, border+100, height);
  rect(width-border-100, 0, border+100, height);**/
  //noLoop();
  saveFrame("frames/" + lineCount + segmentNum + border + frameCount + ".jpg");
  if (frameCount == 600) {
    exit();
  }
}
