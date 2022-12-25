import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.pdf.*;

Minim minim;
AudioPlayer dm;
FFT fft;

int values [] = {125, 250, 500, 1000, 2000};
float band [] = new float [6];
float maxvalues [] = new float [6];
float mediumvalues [] = new float [6];
String loadMax [];
String loadMedium [];
int num = 0;
int howmany [] = new int [6];
float mediums [] = new float [6];
float total = 0;
boolean record = false;

void setup() {
  size(553, 645);
  minim = new Minim(this);
  dm = minim.loadFile("dm.mp3", 1024);
  dm.play();
  fft = new FFT(dm.bufferSize(), dm.sampleRate());
  loadMax = loadStrings("max6.txt");
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
  }
  println(mediums);
}

void draw() {
  background(255);

  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }


  stroke(0);
  for (int i = 0; i < width/5; i++) {
    line(width+3 + i*8* cos(PI), height + i * 8 * sin(PI), width+3 + i * 8 * cos(-PI/2), height + i * 8 * sin(-PI/2));
  }

  noStroke();
  fill(255);
  rect(0, 0, width, height-mediums[mediums.length-1]);

  stroke(0);
  for (int i = 0; i < width/5; i++) {
    line(i*8 * cos(-PI/2), height + i * 8 * sin(-PI/2), i * 8 * cos(0), height + i * 8 * sin(0));
  }

  noStroke();
  fill(255);
  rect(0, 0, width, height-mediums[mediums.length-1] - mediums[mediums.length-2]+1);


  // [0]
  stroke(0);
  for (int i = 0; i < height/8; i++) {
    line(i*8, 0, i*8, height);
  }

  for (int i = 0; i < height; i++) {
    if(height - i * 8 > mediums[0])
    line(0, height - i * 8, width, height - i * 8);
  }

  for (int i = 0; i < height/8; i++) {
  line(i*8 + 4, int(mediums[0] + mediums[1]) + 1, i*8 + 4, height);
  }
  
  for (int i = 0; i < height; i++) {
    if(height - i * 8 > mediums[0] + mediums[1] + mediums[2])
    line(0, height - i * 8 -4, width, height - i * 8 - 4);
  }
 
  fft.forward(dm.mix);
  /*
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
   } else if (fft.indexToFreq(i) < values[3]) {
   band[3]+= map(fft.getBand(i), 0, maxvalues[3], 0, 1);
   howmany[3]++;
   } else if (fft.indexToFreq(i) < values[4]) {
   band[4]+= map(fft.getBand(i), 0, maxvalues[4], 0, 1);
   howmany[4]++;
   } else {
   band[5]+= map(fft.getBand(i), 0, maxvalues[5], 0, 1);
   howmany[5]++;
   }
   }
   
   num++;
   for (int i = 0; i < band.length; i++) {
   mediumvalues[i] = band[i]/(num*howmany[i]);
   howmany[i] = 0;
   }
   saveStrings("output.txt", str(mediumvalues));
   
   println(mediumvalues[1]);
   */
  if (record) {
    endRecord();
    record = false;
  }
}

void mousePressed() {
  record = true;
}
