import processing.sound.*;
import processing.pdf.*;

Amplitude amp;
SoundFile dm;
FlowField f;
boolean record;
float vol = 0;
int counter = 0;
int num = 0;
float maxamp = 0;
ArrayList <PVector> matrix = new ArrayList<PVector>();
ArrayList <PVector> coords = new ArrayList<PVector>();
FloatList ang = new FloatList();
String saveValues [];
String loadString [];
ArrayList<Vehicle> ve;
boolean debug = true;

void setup() {
  size(553, 645, P2D);
  pixelDensity(2);
  /*
  amp = new Amplitude(this);
   dm = new SoundFile(this, "dm.mp3");
   dm.play();
   amp.input(dm);
   
   
   for (int j = 0; j < 25; j++) {
   for (int i = 0; i < 21; i++) {
   matrix.add(new PVector(14+i*26, 10+j*26));
   }
   }
   
   saveValues = new String [matrix.size()];
   */

  loadString = loadStrings("output.txt");

  for (int i = 0; i < loadString.length; i++) {
    coords.add(new PVector(float(split(loadString[i], ',')[0]), float(split(loadString[i], ',')[1])));
    ang.append(float(split(loadString[i], ',')[2]));
  }
  f = new FlowField();
  ve = new ArrayList<Vehicle>();
    for (int i = 0; i < 8000; i++) {
    PVector start = new PVector(random(width), random(height));
    ve.add(new Vehicle(start, 3, 0.3));
  }
    background(255);
}

void draw() {

  //if (debug) f.display();
  for (Vehicle v : ve) {
    v.follow(f);
    v.run();
  }


  counter++;
  /*
   vol+=amp.analyze();
   if (counter > 64) {
   if (maxamp < vol) maxamp = vol;
   float ang = map(vol, 0, 4*7.865969, 0, TWO_PI);
   c.add(new Cross(matrix.get(num).x, matrix.get(num).y, ang));
   saveValues[num] = "" + matrix.get(num).x + "," + matrix.get(num).y + "," + ang;
   
   if (num+1 < matrix.size())
   num++;
   counter = 0;
   vol = 0;
   saveStrings("ouput.txt", saveValues);
   }
   */


}

void keyPressed() {
 save("OUTPUT.TIFF");
}
