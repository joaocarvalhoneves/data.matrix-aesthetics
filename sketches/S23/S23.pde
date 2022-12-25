import processing.pdf.*;
import processing.sound.*;

final int N = 300;
final int iter = 1;
final int SCALE = 1;

boolean record = false;
float vol;

Fluid fluid;
Amplitude amp;
SoundFile dm;

void settings() {
  size(N*SCALE, N*SCALE);
}

void setup() {
  fluid = new Fluid(0.1, 0, 0.0000001);
  amp = new Amplitude(this);
  dm = new SoundFile(this, "dm.mp3");
  dm.play();
  amp.input(dm);
}

void draw() {
  if(vol < amp.analyze()){
    vol = amp.analyze();
    println(vol);
  }
  if (record)
    beginRecord(PDF, "frame-####.pdf");
  background(255);
  int cx = int(0.5*width/SCALE);
  int cy = int(0.5*height/SCALE);
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      fluid.addDensity(cx+i, cy+j, map(amp.analyze(),0,1, 100, 250));
    }
  }
  if(dm.position() > 0){
  for (int i = 0; i < 2; i++) {
    float angle = map(dm.position(), 0, 601, -PI/2, (3*PI)/2);
      PVector v = PVector.fromAngle(angle);
    v.mult(0.1);
    fluid.addVelocity(cx, cy, v.x, v.y);
  }


  fluid.step();
  fluid.renderD();
  //fluid.renderV();
  //fluid.fadeD();

  if (record) {
    endRecord();
    record = false;
  }
}

void mousePressed() {
  record = true;
}
