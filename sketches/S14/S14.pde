import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.pdf.*;

Minim minim;
AudioPlayer dm;
FFT fft;

int values [] = {250, 500, 1000};
float band [] = new float [4];
float maxvalues [] = new float [4];
float mediumvalues [] = new float [4];
String loadMax [];
String loadMedium [];
int num = 0;
int howmany [] = new int [4];
float mediums [] = new float [4];
float total = 0;
boolean record = false;

void setup() {
  size(553, 645);
  minim = new Minim(this);
  dm = minim.loadFile("dm.mp3", 1024);
  dm.play();
  fft = new FFT(dm.bufferSize(), dm.sampleRate());
  loadMax = loadStrings("max4.txt");
  loadMedium = loadStrings("output.txt");

  for (int i = 0; i < band.length; i++) {
    band[i] = 0;
    maxvalues[i] = int(loadMax[i]);
    mediumvalues[i] = 0;
    howmany[i] = 0;
    mediums[i] = float(loadMedium[i]);
    total+= mediums[i];
  }

  for (int i = 0; i < band.length; i++) {
    mediums[i] = map(map(mediums[i], 0, total, 0, 100), 0, 100, 0, height);
    println(mediums[i]);
  }
}

void draw() {
  background(255);

  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }
  float gap = 12;
  stroke(0);
  for (int i = 0; i < width; i++) {
    line(int(i*gap* cos(-PI/2)), int(height - 2 + i * gap * sin(-PI/2)), int(i * gap * cos(0)), int(height - 2 + i * gap * sin(0)));
  }

  noStroke();
  fill(255);
  rect(0, 0, width, int(mediums[0] + mediums[1] + mediums[2]));

  stroke(0);
  for (int i = 0; i < width; i++) {
    line(int(width + i * gap * cos(PI)), int(height - 2 + i * gap * sin(PI)), int(width + i * gap * cos(-PI/2)), int(height - 2 + i * gap * sin(-PI/2)));
  }

  noStroke();
  fill(255);
  rect(0, 0, width, int(mediums[1] + mediums[0] +3));


  stroke(0);
  for (int i = height; i > 0; i--) {
    line(0, i * 6, width, i*6);
  }
  for (int i = 0; i < width; i++) {
    line(i * 6, mediums[0]+3, i* 6, height);
  }

  /*
  fft.forward(dm.mix);
   
   // GET MAX FOR EACH SPEC SIZE
   for (int i = 0; i < fft.specSize(); i++) {
   if (fft.indexToFreq(i) < values[0]) {
   band[0]+= map(fft.getBand(i), 0, maxvalues[0], 0, 1);
   howmany[0]++;
   } else  if (fft.indexToFreq(i) < values[1]) {
   band[1]+= map(fft.getBand(i), 0, maxvalues[1], 0, 1);
   howmany[1]++;
   } else  if (fft.indexToFreq(i) < values[2]) {
   band[2]+= map(fft.getBand(i), 0, maxvalues[2], 0, 1);
   howmany[2]++;
   } else {
   band[3]+= map(fft.getBand(i), 0, maxvalues[3], 0, 1);
   howmany[3]++;
   }
   }
   num++;
   for (int i = 0; i < band.length; i++) {
   mediumvalues[i] = band[i]/(num*howmany[i]);
   howmany[i] = 0;
   }
   saveStrings("output.txt", str(mediumvalues));
   */

  if (record) {
    endRecord();
    record = false;
  }
}

void mousePressed() {
  record = true;
}
