import processing.sound.*;
import processing.pdf.*;

Amplitude amp;
SoundFile dm;
boolean record;
float maxamp = 0;
ArrayList<Rect> r = new ArrayList<Rect>();
float x = 0;
float y = 0;
float ampConv = 0;
float counter = 0;
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

  if (counter >= 16) {

    ampConv = map(vol, 0, 7.865969, 1, 27);
    
     r.add(new Rect(x, y, ampConv));
     
     y+= ampConv+2;
    
    if (y > height) {
      y = 0;
      x+=9;
    }
  
    vol = 0;
    counter = 0;
  }

  for (int i = 0; i < r.size(); i++) {
    r.get(i).draw();
  }

  if (record) {
    endRecord();
    record = false;
    r.clear();
  }
}

void mousePressed() {
  record = true;
}
