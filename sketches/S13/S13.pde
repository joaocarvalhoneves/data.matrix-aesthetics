// 0 - 48000 (0:48)
// 48000 - 144000 (2.24)
// 144000 - 240000 (4:00)
// 240000 - 336500 (5:37.5)
// 336500 - 434000 (7:14)
// 434000 - 508000 (8:28)
// 508000 - 601000 (end)

import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.pdf.*;
import java.util.Arrays;
import java.io.*;
import java.lang.*;
import java.util.*;
BeatDetect beats;
Minim minim;
AudioPlayer dm;
Comparator<Rect> rectCompare = new RectCompare();

boolean record;
float counter = 0;
int num = 0;
float maxa;
ArrayList <Rect> r = new ArrayList <Rect>();

void setup() {
  size(553, 645);
  minim = new Minim(this);
  dm = minim.loadFile("dm.mp3", 1024);
  dm.play();
  beats  = new BeatDetect(dm.bufferSize(), dm.sampleRate());
  maxa = height/7;
  for (int i = 0; i < 7; i++) {
    r.add(new Rect(0, i*maxa, width, maxa));
  }
 // beats.setSensitivity(300);
}

void draw() {
  beats.detect(dm.mix);

  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }

  for (int i = 0; i < r.size(); i++) {
    r.get(i).draw();
  }

  if (record) {
    endRecord();
    record = false;
  }

  if (beats.isRange(1, 3, 3)) {
    Rect sortedR [] = new Rect [r.size()];
    for (int i = 0; i < r.size(); i++) {
      sortedR[i] = new Rect(r.get(i).x, r.get(i).y, r.get(i).l, r.get(i).a);
    }
    Arrays.sort(sortedR, rectCompare);

    int pos = 0;
    for (int i = sortedR.length-1; i >= 0; i--) {
      if (dm.position() < 48000) {
        if (sortedR[i].y + sortedR[i].a <= height/7)
          pos = i;
      } else  if (dm.position() < 144000) {
        if (sortedR[i].y + sortedR[i].a <= height/7*2 && sortedR[i].y + sortedR[i].a > height/7)
          pos = i;
      } else  if (dm.position() < 240000) {
        if (sortedR[i].y + sortedR[i].a <= height/7*3 && sortedR[i].y + sortedR[i].a > height/7 * 2)
          pos = i;
      } else  if (dm.position() < 336500) {
        if (sortedR[i].y + sortedR[i].a <= height/7*4 && sortedR[i].y + sortedR[i].a > height/7 * 3)
          pos = i;
      } else  if (dm.position() < 434000) {
        if (sortedR[i].y + sortedR[i].a <= height/7*5 && sortedR[i].y + sortedR[i].a > height/7 * 4)
          pos = i;
      } else  if (dm.position() < 508000) {
        if (sortedR[i].y + sortedR[i].a <= height/7*6 && sortedR[i].y + sortedR[i].a > height/7 * 5)
          pos = i;
      } else {
        if (sortedR[i].y + sortedR[i].a <= height/7*7 && sortedR[i].y + sortedR[i].a > height/7 * 6)
          pos = i;
      }
    }

    float l = sortedR[pos].l;
    float a = sortedR[pos].a;
    float x = sortedR[pos].x;
    float y = sortedR[pos].y;
    for (int i = 0; i < r.size(); i++) {
      if (r.get(i).l == l && r.get(i).a == a && r.get(i).x == x && r.get(i).y == y)
        r.remove(i);
    }

    r.add(new Rect(x, y, l, a/2));
    r.add(new Rect(x, y+a/2, l, a/2));
  }

  if (beats.isRange(17, 20, 4)) {
    Rect sortedR [] = new Rect [r.size()];
    for (int i = 0; i < r.size(); i++) {
      sortedR[i] = new Rect(r.get(i).x, r.get(i).y, r.get(i).l, r.get(i).a);
    }
    Arrays.sort(sortedR, rectCompare);

    int pos = 0;
    for (int i = sortedR.length-1; i >= 0; i--) {
      if (dm.position() < 48000) {
        if (sortedR[i].y + sortedR[i].a <= height/7)
          pos = i;
      } else  if (dm.position() < 144000) {
        if (sortedR[i].y + sortedR[i].a <= height/7*2 && sortedR[i].y + sortedR[i].a > height/7)
          pos = i;
      } else  if (dm.position() < 240000) {
        if (sortedR[i].y + sortedR[i].a <= height/7*3 && sortedR[i].y + sortedR[i].a > height/7 * 2)
          pos = i;
      } else  if (dm.position() < 336500) {
        if (sortedR[i].y + sortedR[i].a <= height/7*4 && sortedR[i].y + sortedR[i].a > height/7 * 3)
          pos = i;
      } else  if (dm.position() < 434000) {
        if (sortedR[i].y + sortedR[i].a <= height/7*5 && sortedR[i].y + sortedR[i].a > height/7 * 4)
          pos = i;
      } else  if (dm.position() < 508000) {
        if (sortedR[i].y + sortedR[i].a <= height/7*6 && sortedR[i].y + sortedR[i].a > height/7 * 5)
          pos = i;
      } else {
        if (sortedR[i].y + sortedR[i].a <= height/7*7 && sortedR[i].y + sortedR[i].a > height/7 * 6)
          pos = i;
      }
    }

    float l = sortedR[pos].l;
    float a = sortedR[pos].a;
    float x = sortedR[pos].x;
    float y = sortedR[pos].y;
    for (int i = 0; i < r.size(); i++) {
      if (r.get(i).l == l && r.get(i).a == a && r.get(i).x == x && r.get(i).y == y)
        r.remove(i);
    }
    r.add(new Rect(x, y, l/2, a));
    r.add(new Rect(x+l/2, y, l/2, a));
  }
}

void mousePressed() {
  record = true;
}
