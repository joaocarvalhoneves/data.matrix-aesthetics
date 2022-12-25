import processing.sound.*;
import processing.pdf.*;

Amplitude amp;
SoundFile dm;
boolean record;
float vol = 0;
int counter = 0;
int num = 0;
ArrayList<Line> l = new ArrayList<Line>();
float maxamp = 0;

void setup() {
  size(553, 645);
  background(255);
  amp = new Amplitude(this);
  dm = new SoundFile(this, "dm.mp3");
  dm.play();
  amp.input(dm);
}

void draw() {
  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }
  background(255);
  counter++;

  vol+=amp.analyze();
  if (counter > 221) {
    if (maxamp < vol) maxamp = vol;
    println(maxamp);
    l.add(new Line(num*4, map(vol, 0, 77.26288, 0.5, 4)));
    num++;
    counter = 0;
    vol = 0;
  }

  for (int i = 0; i < l.size(); i++) {
    l.get(i).draw();
  }


  if (record) {
    endRecord();
    record = false;
    l.clear();
  }

  if (num*4 > height)
    record = true;
}

void mousePressed() {
  record = true;
}
