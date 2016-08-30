class ScoreBoard {

  String fontScore = "SFTransRoboticsCondensed-64.vlw";
  String fontLives = "SFTransRoboticsCondensed-36.vlw";
  String fontInfo = "SFTransRoboticsCondensed-24.vlw";
  int scoreValue;
  int lives;
  PFont font1;
  PFont font2;
  PFont font3;
  float x1, y1, x2, y2;


  ScoreBoard() {
    scoreValue = 0;
    lives = 3;
    font1 = loadFont(fontScore);
    font2 = loadFont(fontLives);
    font3 = loadFont(fontInfo);
    x1 = width / 2;
    y1 = height / 6;
    x2 = width / 2;
    y2 = height / 6 + 50;
  }

  //Draws the scoreboard
  void render() {
    pushStyle();
    textFont(font1);
    textAlign(CENTER);
    fill(255);
    text(scoreValue, x1, y1);
    popStyle();
  }

  void splashscreen(Ball b, Platform p, Wall lw, Wall rw) {
    pushStyle();
    textFont(font1);
    textAlign(CENTER);
    noStroke();
    fill(0);
    rect(0, 0, width, height);
    fill(#84fafc);
    text("Plasma Ball", x1, y1);
    textFont(font3);
    fill(255);
    text("Get the ball into one of the openings to score!", x1, y1 + 40);

    fill(#ff00aa);
    textFont(font2);
    text("How to play:", width / 2, height / 2 - 40);
    fill(#ff00aa);
    textFont(font3);
    text("Use the LEFT and RIGHT arrow keys", width / 2, height / 2 + 5);
    text("to move the platform", width / 2, height / 2 + 30);
    text("Press and hold the SPACE BAR", width / 2, height / 2 + 75);
    text("to bounce the ball higher", width / 2, height / 2 + 100);

    textFont(font2);
    fill(#aaff01);
    text("Press the Space Bar", width / 2, 4 * height / 5);
    text("to start the game!", width / 2, (4 * height / 5) + 40);
    popStyle();

    //Resets the game
    if (keyPressed) {
      if (key == ' ') {
        hasStart=false;
        lives = 3;
        scoreValue = 0;
        b.reset();
        p.reset();
        lw.setRandomTarget();
        rw.setRandomTarget();
      }
    }
  }


  //Draws the number of lives
  void mylives() {
    pushStyle();
    textFont(font2);
    textAlign(CENTER);
    fill(255);
    text("Lives: " + lives, x2, y2);
    popStyle();
  }

  //Draws the game over screen
  void renderGameOver(Ball b, Platform p, Wall lw, Wall rw) {
    pushStyle();
    textFont(font1);
    textAlign(CENTER);
    noStroke();
    fill(0, 127);
    rect(0, 0, width, height);
    fill(#ff00aa);
    text("GAME OVER", width / 2, height / 2 - 100);
    fill(#84fafc);
    text("Score: " + scoreValue, width / 2, height / 2);
    textFont(font2);
    fill(255);
    text("Press the Space Bar", width / 2, height / 2 + 100);
    text("to play again!", width / 2, height / 2 + 140);
    popStyle();

    //Resets the game
    if (keyPressed) {
      if (key == ' ') {
        hasLost=false;
        lives = 3;
        scoreValue = 0;
        b.reset();
        p.reset();
        lw.setRandomTarget();
        rw.setRandomTarget();
      }
    }
  }



  //Adds points to the score
  void addScore(int increment) {
    if (!hasLost&&!hasStart) {
      scoreValue += increment;
    }
  }


  //Updates the number of lives
  void sublife() {
    lives--;

    if (lives < 0 && hasStart == false) {
      hasLost=true;
    }
  }
}