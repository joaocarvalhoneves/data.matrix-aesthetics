import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.pdf.*;
FFT fft;
Minim minim;
AudioPlayer dm;
Shape s [] = new Shape[7];
Shape averageShape;
int bands [] = {125, 250, 500, 1000, 2000};
boolean record;
float counter = 0;
String loadString [];
String loadAverage [][] = new String [7][];
float meds [][] = new float[7][6];
int num[] = new int[7];
float averageofAverage [] = new float [6];


void setup() {
  size(553, 645);
  minim = new Minim(this);
  dm = minim.loadFile("dm.mp3", 1024);
  dm.play();
  fft  = new FFT(dm.bufferSize(), dm.sampleRate());
  loadString = loadStrings("max6.txt");
  for (int i = 0; i < 7; i++) {
    loadAverage[i] = loadStrings("averages_for_music_section_" + i + ".txt");
    num[i] = 0;
    s[i] = new Shape(loadAverage[i]);
    for (int j = 0; j < 6; j++) {
      meds[i][j] = 0;
      averageofAverage[j] = 0;
    }
  }

  for (int i = 0; i < s.length; i++) {
    for (int j = 0; j < averageofAverage.length; j++) {
      averageofAverage[j]+= s[i].valuesInt[j];
    }
  }
  for (int i = 0; i < averageofAverage.length; i++) {
    averageofAverage[i]/= averageofAverage.length;
  }
  averageShape = new Shape(int(averageofAverage), 0);

  println(int(averageofAverage));
}

void draw() {
  background(255);
  fft.forward(dm.mix);
  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }

  if (dm.position() > 0 && dm.position() < 48000) {
    setMed(0);
    num[0]++;
  } else if (dm.position() < 144000) {
    setMed(1);
    num[1]++;
  } else if (dm.position() < 240000) {
    setMed(2);
    num[2]++;
  } else if (dm.position() < 336500) {
    setMed(3);
    num[3]++;
  } else if (dm.position() < 434000) {
    setMed(4);
    num[4]++;
  } else if (dm.position() < 508000) {
    setMed(5);
    num[5]++;
  } else if (dm.position() >= 508000) {
    setMed(6);
    num[6]++;
  }

  for (int i = 0; i < s.length; i++) {
    s[i].draw();
  }

  averageShape.draw();

  if (record) {
    endRecord();
    record = false;
  }
}

void mousePressed() {
  record = true;
}

void keyPressed() {
  for (int i = 0; i < 7; i++) {
    String saveString [] = new String[6];
    for (int j = 0; j < 6; j++) {
      float med = meds[i][j]/num[i];
      saveString[j] = "" + str(med);
    }
    // saveStrings("averages" + i + ".txt", saveString);
  }
}

void setMed(int a) {
  for (int i = 0; i < fft.specSize(); i++) {
    if (fft.indexToFreq(i) < bands[0])
      meds[a][0]+= fft.getBand(i);
    else if (fft.indexToFreq(i) < bands[1])
      meds[a][1]+= fft.getBand(i);
    else if (fft.indexToFreq(i) < bands[2])
      meds[a][2]+= fft.getBand(i);
    else if (fft.indexToFreq(i) < bands[3])
      meds[a][3]+= fft.getBand(i);
    else if (fft.indexToFreq(i) < bands[4])
      meds[a][4]+= fft.getBand(i);
    else meds[a][5]+= fft.getBand(i);
  }
}
