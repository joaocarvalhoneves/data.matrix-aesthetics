import processing.sound.*;
import processing.pdf.*;

Waveform waveform;
SoundFile dm;
boolean record;
int counter = 0;
float y = 0;
int num = 0;
int samples = 300;
float total = 0;
ArrayList <PVector> matrix = new ArrayList<PVector>();
ArrayList <Cross> c = new ArrayList<Cross>();

void setup() {
  size(553, 645);

  waveform = new Waveform(this, samples);
  dm = new SoundFile(this, "dm.mp3");
  dm.play();
  waveform.input(dm);

  for (int j = 0; j < 49; j++) {
    for (int i = 0; i < 42; i++) {
      matrix.add(new PVector(6+i*13.2, 6+j*13.2));
    }
  }
  rectMode(CENTER);
}

void draw() {
  waveform.analyze();
  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }
  background(255);
  counter++;

  if (counter > 16) {
    for (int i = 0; i < samples; i++) {
      total+= waveform.data[i];
    }
    total/=samples;
    c.add(new Cross(matrix.get(num).x, matrix.get(num).y, map(total, -1, 1, -PI/2, (3*PI)/2)));

    num++;
    counter = 0;
  }
  
    for (int i = 0; i < c.size(); i++) {
    c.get(i).draw();
  }


  if (record) {
    endRecord();
    record = false;
  }
}

void mousePressed() {
  record = true;
}
