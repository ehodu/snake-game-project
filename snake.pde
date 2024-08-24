class Snake {
  PVector pos;
  PVector vel;
  ArrayList<PVector> hist;
  int len;
  int moveX = 0;
  int moveY = 0;

  Snake() {
    pos = new PVector(0, 0);
    vel = new PVector();
    hist = new ArrayList<PVector>();
    len = 0;
  }

  void update() {
    hist.add(pos.copy());
    pos.x += vel.x * grid;
    pos.y += vel.y * grid;
    moveX = int(vel.x);
    moveY = int(vel.y);

    // Alinha a posição da cobrinha com a grade
    pos.x = (pos.x + width) % width;
    pos.y = (pos.y + height) % height;

    if (hist.size() > len) {
      hist.remove(0);
    }

    for (PVector p : hist) {
      if (p.x == pos.x && p.y == pos.y) {
        dead = true;
        gameOverSound.play(); // Toca o som de game over quando o jogo acaba

        if (len > highscore) highscore = len;
      }
    }
  }

  void eat() {
    // Verifica se a cobrinha está dentro de uma área ao redor da comida
    if (abs(pos.x - food.x) < grid && abs(pos.y - food.y) < grid) {
      len++;
      if (len % 5 == 0) { // A cada 5 pontos
        speed++; // Aumenta a velocidade
      }
      newFood();
      foodSound.play(); // Toca o som quando a comida é comida
    }
  }

  void show() {
    noStroke();
    fill(255, 0, 0);
    rect(pos.x, pos.y, grid, grid);
    for (PVector p : hist) {
      rect(p.x, p.y, grid, grid);
    }
  }
}

void keyPressed() {
  if (keyCode == LEFT && snake.moveX != 1) {
    snake.vel.x = -1;
    snake.vel.y = 0;
  } else if (keyCode == RIGHT && snake.moveX != -1) {
    snake.vel.x = 1;
    snake.vel.y = 0;
  } else if (keyCode == UP && snake.moveY != 1) {
    snake.vel.y = -1;
    snake.vel.x = 0;
  } else if (keyCode == DOWN && snake.moveY != -1) {
    snake.vel.y = 1;
    snake.vel.x = 0;
  }
}
