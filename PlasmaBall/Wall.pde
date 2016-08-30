class Wall {

  float x1, y1, x2, y2;
  float w1, h1, w2, h2;
  float targetX1, targetY1;
  float targetX2, targetY2;
  float easing;

  boolean needsUpdate;

  Wall(float xpos, float ypos) {
    x1 = xpos;
    y1 = ypos;
    x2 = xpos;
    y2 = y1 + 3080;
    w1 = 80;
    h1 = 3000;
    w2 = 80;
    h2 = 3000;
    targetX1 = x1;
    targetY1 = y1;
    targetX2 = x2;
    targetY2 = y1 + 3080;
    easing = 0.3;
    needsUpdate = true;
  }

  //Draws the walls
  void render() {
    pushStyle();
    noFill();
    stroke(#84fafc);
    strokeWeight(4);
    rect(x1, y1, w1, h1);
    rect(x2, y2, w2, h2);
    popStyle();
  }

  //Moves the walls
  void move() {
    if (needsUpdate) {
      // Check if position update is necessary for next frame
      float dx1 = targetX1 - x1;
      float dy1 = targetY1 - y1;
      float dx2 = targetX2 - x2;
      float dy2 = targetY2 - y2;

      // Increase coordinates only a fraction (easing) of their remaining distances
      x1 += dx1 * easing;
      y1 += dy1 * easing;
      x2 += dx2 * easing;
      y2 += dy2 * easing;

      if ((abs(dx1) < 1.0 && abs(dy1) < 1.0) && (abs(dx2) < 1.0 && abs(dy2) < 1.0) ) {
        // Snap coordinates to target
        x1 = targetX1;
        y1 = targetY1;
        x2 = targetX2;
        y2 = targetY2;
        needsUpdate = false;
      }
    }
  }

  //Sets a new random target for the walls to move towards
  void setRandomTarget() {
    targetX1 = x1;
    targetY1 = random(-2900, -2400);
    targetX2 = x2;
    targetY2 = targetY1 + 3080;
    needsUpdate = true;
  }

  //Checks if the ball has collided with a wall
  /*
   Unfortunately, however many times I tried, I just couldn't figure out how to 
   create the outer perimeter for the velocity that we talked about. 
   Instead, I worked around the problem, and, after multiple tests, I believe 
   that the player should be unable to get the ball to go through the walls.
   */
  void collidesWith(Ball b) {
    // Check if in last b
    //collides with Bottom of top wall
    if  ((b.x + b.radius / 2 > x1 
      &&  b.x - b.radius / 2 < x1 + w1)
      && (b.y - b.radius < y1 + h1
      &&  b.y - b.radius > y1)) {
      b.velY = abs(b.velY);
    }

    //collides with Top of top wall
    else if  ((b.x + b.radius / 2 > x1 
           &&  b.x - b.radius / 2 < x1 + w1)
           && (b.y + b.radius < y1 + h1 
           &&  b.y + b.radius > y1)) {
           b.velY = -abs(b.velY);
    }

    //collides with Left side of top wall
    else if  ((b.y + b.radius / 2> y1 
           &&  b.y - b.radius / 2 < y1 + h1)
           && (b.x + b.radius> x1 
           &&  b.x + b.radius < x1 + w1)) {
           b.velX = -abs(b.velX);
    }

    //collides with Right side of top wall
    else if  ((b.y + b.radius / 2 > y1 
           &&  b.y - b.radius / 2 < y1 + h1)
           && (b.x - b.radius < x1 + w1 
           &&  b.x - b.radius > x1)) {
           b.velX = abs(b.velX);
    }

    //collides with Bottom of bottom wall
    else if  ((b.x + b.radius / 2 > x2 
           &&  b.x - b.radius / 2 < x2 + w2)
           && (b.y - b.radius < (y2 + h2) 
           &&  b.y - b.radius > y2)) {
           b.velY = abs(b.velY);
    }

    //collides with Top of bottom wall
    else if  ((b.x + b.radius / 2 > x2 
           &&  b.x - b.radius / 2 < x2 + w2)
           && (b.y + b.radius < y2 + h2 
           &&  b.y + b.radius > y2)) {
           b.velY = -abs(b.velY);
    }

    //collides with Left side of bottom wall
    else if  ((b.y + b.radius / 2 > y2 
           &&  b.y - b.radius / 2 < y2 + h2)
           && (b.x + b.radius > x2 
           &&  b.x + b.radius < x2 + w2)) {
           b.velX=-abs(b.velX);
    }

    //collides with Right side of  bottom wall
    else if  ((b.y + b.radius / 2 > y2 
           &&  b.y - b.radius / 2 < y2 + h2)
           && (b.x - b.radius < x2 + w2 
           &&  b.x - b.radius > x2)) {
           b.velX=abs(b.velX);
    }
  }
}