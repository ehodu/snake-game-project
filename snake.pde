class Snake {
  PVector pos;
  PVector vel;
  ArrayList<PVector> hist;
  int len;
  int moveX = 0;
  int moveY = 0;

  Snake() {
    pos = new PVector(0, 0); // Define a posição inicial da cobrinha
    vel = new PVector(); // Inicializa a velocidade da cobrinha
    hist = new ArrayList<PVector>(); // Inicializa o histórico de posições da cobrinha
    len = 0; // Define o tamanho inicial da cobrinha
  }

  void update() {
    hist.add(pos.copy()); // Adiciona a posição atual ao histórico
    pos.x += vel.x * grid; // Atualiza a posição x da cobrinha
    pos.y += vel.y * grid; // Atualiza a posição y da cobrinha
    moveX = int(vel.x); // Atualiza o movimento no eixo x
    moveY = int(vel.y); // Atualiza o movimento no eixo y

    // Verificação de colisão com as bordas
    if (pos.x < 0 || pos.x >= width || pos.y < 0 || pos.y >= height) {
      dead = true; // A cobrinha morre se tocar nas bordas
      gameOverSound.play(); // Toca o som de game over
      if (len > highscore) highscore = len; // Atualiza o recorde se necessário
    }

    if (hist.size() > len) {
      hist.remove(0); // Remove a posição mais antiga do histórico para manter o tamanho da cobrinha
    }

    // Verificação de colisão com o próprio corpo
    for (PVector p : hist) {
      if (p.equals(pos)) { // Verifica se a posição atual da cobrinha está no corpo
        dead = true; // A cobrinha morre se colidir com seu próprio corpo
        gameOverSound.play(); // Toca o som de game over
        if (len > highscore) highscore = len; // Atualiza o recorde se necessário
      }
    }
  }

  void eat() {
    // Verifica se a cobrinha está dentro de uma área ao redor da comida
    ArrayList<PVector> toRemove = new ArrayList<PVector>();
    for (PVector food : foods) {
      if (abs(pos.x - food.x) < grid && abs(pos.y - food.y) < grid) {
        len += 5; // Aumenta o tamanho da cobrinha
        if (len % 20 == 0 && speed > minSpeed) { // A cada 5 pontos, a velocidade aumenta, se não estiver no limite mínimo
          speed--; // Aumenta a velocidade
        }
        toRemove.add(food); // Marca a comida para remoção
        foodSound.play(); // Toca o som quando a comida é consumida
      }
    }
    // Remove as comidas que foram comidas
    for (PVector food : toRemove) {
      foods.remove(food);
    }
    // Se todas as comidas foram comidas, gere novas
    if (foods.isEmpty()) {
      newFood(); // Gera novas comidas
    }
  }

  void show() {
    noStroke();
    fill(0, 200, 200, 200);
    rect(pos.x, pos.y, grid, grid); // Desenha a cabeça da cobrinha
    for (PVector p : hist) {
      rect(p.x, p.y, grid, grid); // Desenha o corpo da cobrinha
    }
  }
}

// Função para controlar a direção da cobrinha com as teclas do teclado
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
