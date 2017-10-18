
import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import processing.serial.*; 

KinectTracker tracker;
Kinect kinect;
Serial puerto;
boolean ini;

void setup() {
    size(640, 520);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  ini = false;
  String COM = Serial.list()[2];
  puerto = new Serial(this, "/dev/ttyUSB0", 9600);
  //comunicacion serial a 9600bps

}

void draw() {
  
  tracker.track();
  tracker.display();
  PVector v1 = tracker.getLerpedPos();
  fill(50, 100, 250, 200);
  noStroke();
  ellipse(v1.x, v1.y, 20, 20);
  
  int trackerX = (int)v1.x;
  int trackerY = (int)v1.y;
 
   
  // iniciar tracking
  if (!ini){
    if (trackerX > 100 && trackerY < 350){
      
      ini=true;
    }
  }
  else{
    elevacion(v1);
  }
}
void elevacion(PVector v){
  int trackerX = (int)v.x;
  int trackerY = (int)v.y;
  // ajuste con la fuente trackerX
  
  if (trackerX > 0 && trackerX < 200){
    puerto.write("x0");
    println("% 0 en x");
    println(trackerX);
  }
  
  if (trackerX > 200 && trackerX < 500){
    puerto.write("x450");
    println("% 0 en x");
    println(trackerX);
  }

  if (trackerX > 500 && trackerX < 1000){
    puerto.write("x500");
    println("% 100 en x");
    println(trackerX);
  }
  
    // ajuste con la fuente trackerY
  if (trackerY > 0 && trackerY < 200){
    puerto.write("y500");
    println("% 0 en y");
    println(trackerY);
  }
  
  
  if (trackerY > 200 && trackerY < 500){
    puerto.write("y450");
    println("% 0 en y");
    println(trackerY);
  }
  
  if (trackerY > 500 && trackerY < 1000){
    puerto.write("y0");
    println("% 100");
    println(trackerY);
  }
}
// Adjust the threshold with key presses
void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  }
}