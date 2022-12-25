import processing.sound.*;
import processing.pdf.*;

Amplitude amp;
SoundFile dm;
boolean record;
float maxamp = 0;
ArrayList<Line> l = new ArrayList<Line>();
float x = 0;
float y = 6;
float ampConv = 0;
float counter = 3;
float vol = 0;

void setup() {
  size(553, 645);
  amp = new Amplitude(this);
  dm = new SoundFile(this, "dm.mp3");
  dm.play();
  amp.input(dm);
  rectMode(CENTER);
}

void draw() {
  counter++;
  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }

  background(255);
  vol+= amp.analyze();

  if (counter >= 4) {
    ampConv = map(vol, 0, 4*0.80888873, 8, 0);

    x+= ampConv;
    if (x > width) {
      x = 0;
      y+= 12;
    }
    l.add(new Line((x+ampConv), y));
    vol = 0;
    counter = 0;
  }

  for (int i = 0; i < l.size(); i++) {
    l.get(i).draw();
  }

  if (record) {
    endRecord();
    record = false;
    l.clear();
  }
}

void mousePressed() {
  record = true;
}
