// Importa a biblioteca de som
import processing.sound.*;

// Declara os objetos SoundFile para a comida e game over
SoundFile somComida;
SoundFile somGameOver;

// Tamanho de cada quadrado da grade
float grid = 20;

// Lista das posições das comidas
ArrayList<PVector> comidas;

// Velocidade inicial (valor maior significa menor frequência de atualização)
int speed = 10;

// Flag para indicar se a cobrinha está morta
boolean morto = true;

// Recorde de pontuação
int recorde = 0;

// Velocidade mínima
int velocidadeMinima = 1;

// Declara os objetos PImage para a imagem de fundo, comida e cabeça da cobrinha
PImage imagemFundo;
PImage imagemComida;
PImage imagemCabeça;

// Número de comidas
int numComidas = 5;

// Instância da classe Cobrinha
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
  imagemCabeça = loadImage("cobra.png");
}

void draw() {
  if (!morto) {
    background(imagemFundo); // Desenha a imagem de fundo somente se a cobrinha estiver viva
    if (frameCount % speed == 0) {
      cobrinha.atualizar();
    }
    cobrinha.mostrar();
    cobrinha.comer();

    // Desenha todas as comidas
    fill(0, 0, 255); // Comida azul
    for (PVector comida : comidas) {
      image(imagemComida, comida.x, comida.y, grid * 1.2, grid * 1.2);
    }

    // Exibe a pontuação
    textAlign(LEFT);
    textSize(15);
    fill(255);
    text("Pontuação: " + cobrinha.comprimento, 10, 20);
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
      posComida = new PVector(floor(random(width / grid)) * grid, floor(random(height / grid)) * grid);
      // Verifica se a comida não sobrepõe a cabeça ou o corpo da cobrinha
      if (posComida.equals(cobrinha.posicao)) { // Certifique-se de que `cobrinha.posicao` é a posição da cabeça da cobrinha
        sobreposicao = true;
      } else {
        for (PVector p : cobrinha.historico) { // Certifique-se de que `cobrinha.historico` é a lista de posições do corpo
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
    speed = 5; // Velocidade inicial
    morto = false;
  }
}
