/* 
 Programming Basics
 Kevin Casas
 casas.k@husky.neu.edu
 assignment_08
 "Plasma Ball"
 
 References:
 http://www.openprocessing.org/sketch/104480
 */

// Video game parameters
boolean hasLost = false;
boolean hasStart = true;

Ball gameBall;

Platform platform;
ScoreBoard score;
Wall leftWall;
Wall rightWall;


void setup() {
  size(550, 790);

  gameBall = new Ball();
  platform = new Platform();
  score = new ScoreBoard();
  leftWall = new Wall(-10, -3250);
  rightWall = new Wall(480, -3250);
  leftWall.setRandomTarget();
  rightWall.setRandomTarget();
}


void draw() {
  background(3);
  platform.render();

  if (!hasLost&&!hasStart) {
    gameBall.render();
    leftWall.move();
    rightWall.move();
    score.render();
    score.mylives();
  }

  gameBall.move(score, leftWall, rightWall);
  gameBall.checkCollision(platform);

  leftWall.render();
  leftWall.collidesWith(gameBall);
  rightWall.render();
  rightWall.collidesWith(gameBall);

  if (hasStart == true) {
    score.splashscreen(gameBall, platform, leftWall, rightWall);
  }

  if (hasLost == true) {
    score.renderGameOver(gameBall, platform, leftWall, rightWall);
  }

  if (!hasLost&&!hasStart) {
    if (keyPressed) {
      if (key == CODED) {
        if (keyCode == LEFT) {
          platform.moveleft();
        } else if (keyCode == RIGHT) {
          platform.moveright();
        }
      }
    }
  }
}