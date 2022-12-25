import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer dm;
FFT fft;

int values [] = {250, 500, 1000};
float band [] = new float [4];
float newband [] = new float [4];
float maxvalues [] = new float [4];
String saveMax [] = new String [4];
String loadMax [];
float larg = 0;
float smooth = 1;

void setup()
{
  size(553, 645);
  minim = new Minim(this);
  dm = minim.loadFile("dm.mp3", 1024);
  dm.play();
  fft = new FFT( dm.bufferSize(), dm.sampleRate() );
  rectMode(CORNER);
  stroke(0);
  loadMax = loadStrings("max4.txt");

  for (int i = 0; i < band.length; i++) {
    band[i] = 0;
    newband[i] = 0;
    maxvalues[i] = 0;
  }
  larg = width/band.length;
}

void draw() {
  background(255);
  fft.forward(dm.mix);


  // GET MAX FOR EACH SPEC SIZE
  for (int i = 0; i < fft.specSize(); i++) {
    if (fft.indexToFreq(i) < values[0]) {
      band[0] = max(band[0], fft.getBand(i)) * smooth;
    } else  if (fft.indexToFreq(i) < values[1]) {
      band[1] = max(band[1], fft.getBand(i)) * smooth;
    } else  if (fft.indexToFreq(i) < values[2]) {
      band[2] = max(band[2], fft.getBand(i)) * smooth;
    } else {
      band[3] = max(band[3], fft.getBand(i)) * smooth;
    }
  }
 

  // GET OVERALL MAX AND MIN
  for (int i = 0; i < band.length; i++) {
    newband[i] += (band[i] - newband[i]) * smooth;
    maxvalues[i] = max(maxvalues[i], newband[i]);
    saveMax[i] = "" + maxvalues[i];
  }
 //saveStrings("max4-smooth.txt", saveMax);

  for (int i = 0; i < band.length; i++) {
     rect((larg*i) + 2, height - map(newband[i], 0, float(loadMax[i]), 0, height), larg, map(newband[i], 0, float(loadMax[i]), 0, height));
  }

  for (int i = 0; i < band.length; i++) {
    band[i] = 0;
  }
}
