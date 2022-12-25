class Vehicle {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  String letter;
  PVector previousPos;

  Vehicle(PVector l, float ms, float mf) {
    position = l.copy();
    r = 3.0;
    maxspeed = ms;
    maxforce = mf;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    previousPos = position.copy();
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
     stroke(0, 5);
    strokeWeight(1);
    line(position.x, position.y, previousPos.x, previousPos.y);
    //point(pos.x, pos.y);
    updatePreviousPos();
  }

 void borders() {
    if (position.x > width) {
      position.x = 0;
      updatePreviousPos();
    }
    if (position.x < 0) {
      position.x = width;    
      updatePreviousPos();
    }
    if (position.y > height) {
      position.y = 0;
      updatePreviousPos();
    }
    if (position.y < 0) {
      position.y = height;
      updatePreviousPos();
    }
  }
  
    void updatePreviousPos() {
    this.previousPos.x = position.x;
    this.previousPos.y = position.y;
  }
}
