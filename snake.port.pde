class Cobrinha {
  PVector pos;
  PVector vel;
  ArrayList<PVector> hist;
  int tam;
  int movX = 0;
  int movY = 0;

  Cobrinha() {
    pos = new PVector(0, 0); // Define a posição inicial da cobrinha
    vel = new PVector(); // Inicializa a velocidade da cobrinha
    hist = new ArrayList<PVector>(); // Inicializa o histórico de posições da cobrinha
    tam = 0; // Define o tamanho inicial da cobrinha
  }

  void atualizar() {
    hist.add(pos.copy()); // Adiciona a posição atual ao histórico
    pos.x += vel.x * grade; // Atualiza a posição x da cobrinha
    pos.y += vel.y * grade; // Atualiza a posição y da cobrinha
    movX = int(vel.x); // Atualiza o movimento no eixo x
    movY = int(vel.y); // Atualiza o movimento no eixo y

    // Verificação de colisão com as bordas
    if (pos.x < 0 || pos.x >= largura || pos.y < 0 || pos.y >= altura) {
      morto = true; // A cobrinha morre se tocar nas bordas
      somGameOver.play(); // Toca o som de game over
      if (tam > recorde) recorde = tam; // Atualiza o recorde se necessário
    }

    if (hist.size() > tam) {
      hist.remove(0); // Remove a posição mais antiga do histórico para manter o tamanho da cobrinha
    }

    // Verificação de colisão com o próprio corpo
    for (PVector p : hist) {
      if (p.equals(pos)) { // Verifica se a posição atual da cobrinha está no corpo
        morto = true; // A cobrinha morre se colidir com seu próprio corpo
        somGameOver.play(); // Toca o som de game over
        if (tam > recorde) recorde = tam; // Atualiza o recorde se necessário
      }
    }
  }

  void comer() {
    // Verifica se a cobrinha está dentro de uma área ao redor da comida
    ArrayList<PVector> paraRemover = new ArrayList<PVector>();
    for (PVector comida : comidas) {
      if (abs(pos.x - comida.x) < grade && abs(pos.y - comida.y) < grade) {
        tam += 5; // Aumenta o tamanho da cobrinha
        if (tam % 20 == 0 && velocidade > velocidadeMinima) { // A cada 5 pontos, a velocidade aumenta, se não estiver no limite mínimo
          velocidade--; // Aumenta a velocidade
        }
        paraRemover.add(comida); // Marca a comida para remoção
        somComida.play(); // Toca o som quando a comida é consumida
      }
    }
    // Remove as comidas que foram comidas
    for (PVector comida : paraRemover) {
      comidas.remove(comida);
    }
    // Se todas as comidas foram comidas, gere novas
    if (comidas.isEmpty()) {
      novaComida(); // Gera novas comidas
    }
  }

  void mostrar() {
    noStroke();
    fill(0, 200, 200, 200);
    rect(pos.x, pos.y, grade, grade); // Desenha a cabeça da cobrinha
    for (PVector p : hist) {
      rect(p.x, p.y, grade, grade); // Desenha o corpo da cobrinha
    }
  }
}

// Função para controlar a direção da cobrinha com as teclas do teclado
void teclaPressionada() {
  if (keyCode == LEFT && cobrinha.movX != 1) {
    cobrinha.vel.x = -1;
    cobrinha.vel.y = 0;
  } else if (keyCode == RIGHT && cobrinha.movX != -1) {
    cobrinha.vel.x = 1;
    cobrinha.vel.y = 0;
  } else if (keyCode == UP && cobrinha.movY != 1) {
    cobrinha.vel.y = -1;
    cobrinha.vel.x = 0;
  } else if (keyCode == DOWN && cobrinha.movY != -1) {
    cobrinha.vel.y = 1;
    cobrinha.vel.x = 0;
  }
}
