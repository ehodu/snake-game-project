// Classe que representa a cobrinha
class Cobrinha {
  PVector posicao; // Posição atual da cobrinha
  PVector velocidade; // Velocidade da cobrinha
  ArrayList<PVector> historico; // Histórico de posições da cobrinha
  int comprimento; // Comprimento da cobrinha
  int movimentoX = 0; // Movimento no eixo x
  int movimentoY = 0; // Movimento no eixo y

  // Construtor da classe Cobrinha
  Cobrinha() {
    posicao = new PVector(0, 0); // Define a posição inicial da cobrinha
    velocidade = new PVector(); // Inicializa a velocidade da cobrinha
    historico = new ArrayList<PVector>(); // Inicializa o histórico de posições da cobrinha
    comprimento = 0; // Define o comprimento inicial da cobrinha
  }

  // Método para atualizar a posição da cobrinha
  void atualizar() {
    historico.add(posicao.copy()); // Adiciona a posição atual ao histórico
    posicao.x += velocidade.x * grid; // Atualiza a posição x da cobrinha
    posicao.y += velocidade.y * grid; // Atualiza a posição y da cobrinha
    movimentoX = int(velocidade.x); // Atualiza o movimento no eixo x
    movimentoY = int(velocidade.y); // Atualiza o movimento no eixo y

    // Verificação de colisão com as bordas
    if (posicao.x < 0 || posicao.x >= witdth || posicao.y < 0 || posicao.y >= height) {
      morto = true; // A cobrinha morre se tocar nas bordas
      somGameOver.play(); // Toca o som de game over
      if (comprimento > recorde) recorde = comprimento; // Atualiza o recorde se necessário
    }

    if (historico.size() > comprimento) {
      historico.remove(0); // Remove a posição mais antiga do histórico para manter o comprimento da cobrinha
    }

    // Verificação de colisão com o próprio corpo
    for (PVector p : historico) {
      if (p.equals(posicao)) { // Verifica se a posição atual da cobrinha está no corpo
        morto = true; // A cobrinha morre se colidir com seu próprio corpo
        somGameOver.play(); // Toca o som de game over
        if (comprimento > recorde) recorde = comprimento; // Atualiza o recorde se necessário
      }
    }
  }

  // Método para comer comida
  void comer() {
    // Verifica se a cobrinha está dentro de uma área ao redor da comida
    ArrayList<PVector> toRemove = new ArrayList<PVector>();
    for (PVector comida : comidas) {
      if (abs(posicao.x - comida.x) < grid && abs(posicao.y - comida.y) < grid) {
        comprimento += 5; // Aumenta o comprimento da cobrinha
        if (comprimento % 20 == 0 && velocidade > velocidadeMinima) { // A cada 5 pontos, a velocidade aumenta, se não estiver no limite mínimo
          velocidade--; // Aumenta a velocidade
        }
        toRemove.add(comida); // Marca a comida para remoção
        somComida.play(); // Toca o som quando a comida é consumida
      }
    }
    // Remove as comidas que foram comidas
    for (PVector comida : toRemove) {
      comidas.remove(comida);
    }
    // Se todas as comidas foram comidas, gere novas
    if (comidas.isEmpty()) {
      novaComida(); // Gera novas comidas
    }
  }

  // Método para desenhar a cobrinha
  void mostrar() {
    noStroke();
    fill(0, 200, 200, 200);
    rect(posicao.x, posicao.y, grid, grid); // Desenha a cabeça da cobrinha
    for (PVector p : historico) {
      rect(p.x, p.y, grid, grid); // Desenha o corpo da cobrinha
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
 
