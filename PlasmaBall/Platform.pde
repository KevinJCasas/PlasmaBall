class Platform {

  float x, y;
  float w, h;

  Platform() {
    x = width / 2;
    y = 28 * height / 30 - h / 2;
    w = 100;
    h = 20;
  }

  //Draws the platform
  void render() {
    pushStyle();
    noFill();
    stroke(#ff00aa);
    strokeWeight(4);
    rect(x, y, w, h);
    popStyle();
  }

  //Moves the platform left
  void moveleft() {
    x -= 10;
    if (x < 70) {
      x = 70;
    }
  }

  //Moves the platform right
  void moveright() {
    x += 10;
    if (x > width - w  - 70) {
      x = width - w - 70;
    }
  }

  //Resets the platform to its original spot
  void reset() {
    x = width / 2 - w / 2;
    y = 28 * height / 30 - 20 / 2;
  }
}