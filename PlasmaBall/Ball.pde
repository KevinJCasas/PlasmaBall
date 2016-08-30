class Ball {

  float x, y;
  float velX, velY;
  float velXUpdate, velYUpdate;
  float radius;
  float gravity;
  float friction;

  Ball() {
    x = width / 2;
    y = -40;
    velX = random(-8, 8);
    velY = 0;
    velXUpdate = 1.5;
    velYUpdate = 2;
    gravity = .4;
    friction = .99;
    radius = height / 50;
  }

  //Draws the ball
  void render() {
    pushStyle();
    fill(0);
    stroke(#aaff01);
    strokeWeight(4);
    ellipse(x, y, 2 * radius, 2 * radius);
    stroke(0);
    pushStyle();
  }

  //Resets the ball at the top of the screen
  void reset() {
    x = width / 2;
    y = 0;

    velX = random(-8, 8);
    velY = 0;
  }

  //Moves the ball
  void move(ScoreBoard score, Wall lw, Wall rw) {
    velY += gravity;

    //velX *= friction;
    velY *= friction;

    x += velX;
    if (velX > 8) {
      velX = 8;
    }
    y += velY;

    //Checks if the ball has passsed any conditions
    if (x > width || x < 0) {
      score.addScore(10);
      lw.setRandomTarget();
      rw.setRandomTarget();
      reset();
    } else if (y > height) {
      reset();
      score.sublife();
    }
  }

  //Reverses the balls direction
  void reverseYDirection() {
    velY *= -1;
  }

  //Checks if the ball has hit the platform
  void checkCollision(Platform p) {
    if (velY > 0) {
      if  ((x + radius > p.x && x - radius < p.x + p.w)
        && (y + radius < p.y + p.h && y + radius > p.y)) {
        //Bounces the ball on the platform
        reverseYDirection();

        if (keyPressed) {
          //Bounces the ball straight up
          if (key == ' ') {
            velY *= velYUpdate;
          } else if (key == CODED) {
            //Bounces the ball up and to the left
            if (keyCode == LEFT) {
              if (velX > -6) {
                velX -= velXUpdate;
              }
            } //Bounces the ball up and to the right
            else if (keyCode == RIGHT) {
              if (velX <= 6) {
                velX += velXUpdate;
              }
            }
          }
        }
      }
    }
  }
}