class Vehicle {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  String letter;
  String possible [] = {"d", "a", "t", "a", ".", "m", "a", "t", "r", "i", "x"};

    Vehicle(PVector l, float ms, float mf) {
    position = l.copy();
    r = 3.0;
    maxspeed = ms;
    maxforce = mf;
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    letter = possible[int(random(possible.length))];
  }

  public void run() {
    update();
    borders();
    display();
  }

  void follow(FlowField flow) {
    PVector desired = flow.lookup(position);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    float theta = velocity.heading() + radians(90);
//fill(0);
    noStroke();
    pushMatrix();
    translate(position.x,position.y);
    rotate(theta);
    textAlign(CENTER, CENTER);
    textSize(15);
    fill(0);
    text(letter, 0, 0);
    /*
    beginShape(TRIANGLES);
    vertex(0, -r*1.5);
    vertex(-r, r);
    vertex(r, r);
    endShape();
    */
    popMatrix();
  }

  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }
}
