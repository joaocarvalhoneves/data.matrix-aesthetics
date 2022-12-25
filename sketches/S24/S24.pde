import processing.sound.*;
import processing.pdf.*;

Amplitude amp;
SoundFile dm;
boolean record;
float counter = 0;
float vol = 0;
float ang = 0;
ArrayList <PVector> c = new ArrayList <PVector>();

void setup() {
  size(553, 645);

  amp = new Amplitude(this);
  dm = new SoundFile(this, "dm.mp3");
  dm.play();
  amp.input(dm);
   c.add(new PVector(width/2 + 150*cos(-PI/2 + ang), 
                     height/2 + 150*sin(-PI/2 + ang)));
}

void draw() {
  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }
  background(255);
  counter++;
  vol+= amp.analyze();
  if(counter > 200){
    c.add(new PVector(width/2 + map(vol, 0, 200, 150, 350)*cos(-PI/2 + ang), 
                     height/2 + map(vol, 0, 200, 150, 350)*sin(-PI/2 + ang)));
     ang+=radians(2);
     counter = 0;
     vol = 0;
  }
  noStroke();
  fill(0);
  beginShape();
  for(int i = 0; i < c.size(); i++){
    curveVertex(c.get(i).x, c.get(i).y);
  }
  endShape();
 

  if (record) {
    endRecord();
    record = false;
  }
}

void mousePressed() {
  record = true;
}
