import processing.sound.*; // Importa a biblioteca de som

SoundFile somComida; // Declara o objeto SoundFile para a comida
SoundFile somGameOver; // Declara o objeto SoundFile para o game over
float grade = 20; // Tamanho de cada quadrado da grade
ArrayList<PVector> comidas; // Lista das posições das comidas
int velocidade = 10; // Velocidade inicial (valor maior significa menor frequência de atualização)
boolean morto = true;
int recorde = 0;
int velocidadeMinima = 1;
PImage imagemFundo; // Declara o objeto PImage para a imagem de fundo
PImage imagemComida;
PImage imgCabeca;
int numComidas = 5; // Número de comidas

Cobrinha cobrinha;

void setup() {
  fullScreen();
  cobrinha = new Cobrinha();
  frameRate(30); // Definindo a taxa de quadros
  imagemFundo = loadImage("wall.png"); // Carrega a imagem de fundo
  comidas = new ArrayList<PVector>(); // Inicializa a lista de comidas
  novaComida(); // Gera comidas iniciais
  somComida = new SoundFile(this, "food.mp3"); // Inicializa o objeto SoundFile para comida
  somGameOver = new SoundFile(this, "gameover.mp3"); // Inicializa o objeto SoundFile para game over
  imagemFundo.resize(width, height);
  imagemComida = loadImage("maca.png");
  imgCabeca = loadImage("cobra.png");
}

void draw() {
  if (!morto) {
    background(imagemFundo); // Desenha a imagem de fundo somente se a cobrinha estiver viva
    if (frameCount % velocidade == 0) {
      cobrinha.atualizar();
    }
    cobrinha.mostrar();
    cobrinha.comer();

    // Desenha todas as comidas
    fill(0, 0, 255); // Comida azul
    for (PVector comida : comidas) {
      image(imagemComida, comida.x, comida.y, grade * 1.2, grade * 1.2);
    }

    // Exibe a pontuação
    textAlign(LEFT);
    textSize(15);
    fill(255);
    text("Pontuação: " + cobrinha.tam, 10, 20);
  } else {
    background(0);
    textSize(25);
    textAlign(CENTER, CENTER);
    text("JOGO DA COBRINHA\nClique na tela para começar" + "\nRecorde: " + recorde, width / 2, height / 2);
  }
}

void novaComida() {
  comidas.clear(); // Limpa a lista existente de comidas
  for (int i = 0; i < numComidas; i++) {
    PVector posComida;
    boolean sobreposicao;
    do {
      sobreposicao = false;
      posComida = new PVector(floor(random(width / grade)) * grade, floor(random(height / grade)) * grade);
      // Verifica se a comida não sobrepõe a cabeça ou o corpo da cobrinha
      if (posComida.equals(cobrinha.pos)) { // Certifique-se de que `cobrinha.pos` é a posição da cabeça da cobrinha
        sobreposicao = true;
      } else {
        for (PVector p : cobrinha.hist) { // Certifique-se de que `cobrinha.hist` é a lista de posições do corpo
          if (posComida.equals(p)) {
            sobreposicao = true;
            break;
          }
        }
      }
    } while (sobreposicao); // Continue tentando até encontrar uma posição não sobreposta
    comidas.add(posComida); // Adiciona a comida à lista
  }
}

void mousePressed() {
  if (morto) {
    cobrinha = new Cobrinha();
    novaComida();
    velocidade = 5; // Velocidade inicial
    morto = false;
  }
}
