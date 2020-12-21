//Reference Source: Bryn Mawr College, Department of Computer Science(https://cs.brynmawr.edu/gxk2013/examples/transformations/starfield/)

class Stars{
  float x, y, z, px, py;
  float a, pa;
  
  Stars(){
    x = random(-5000, 5000);
    y = random(-5000, 5000);
    z = random(-5000, 5000);
    a = random(2000);
    pa=a;
  }
  
  void update(){
    a = a - speed;
   
    if (a < 1) {
      x = random(-5000, 5000);
      y = random(-5000, 5000);
      z = random(-5000, 5000);
      a = 2000;
      pa=a;
    }
    
  }
  
  void display(){
    float rmsScaled = sum * (55)*5;
    noStroke();
    // Project star only viewport
    float offsetX = 100.0*(x/a);
    float offsetY = 100.0*(y/a);
    float offsetZ = 100.0*(z/a);
    float scaleZ = 0.0001*(1200-a);
    //float d = map(z, 0, width, 16, 0);
    fill(255,255,255, 255*scaleZ*10);
    // Draw this star
    
    pushMatrix();
    translate(offsetX, offsetY,offsetZ);
    scale(scaleZ);
    sphere(rmsScaled*0.8);
    popMatrix();
    
    px = offsetX*pa/100.0;
    py = offsetY*pa/100.0;

    pa=a;
    stroke(175);
    line(px, py, x, y);
  }
  
}
