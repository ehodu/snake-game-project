import processing.sound.*; // Importa a biblioteca de som

SoundFile somComida; // Declara o objeto SoundFile para a comida
SoundFile somPerdeu; // Declara o objeto SoundFile para o game over
int grid = 20; // Tamanho de cada quadrado da grade
PVector comer;
int velocidade = 10; // Velocidade inicial (valor maior significa menor frequência de atualização)
boolean morte = true;
int maiorPontuacao = 0;
PImage imagemFundo; // Declara o objeto PImage para a imagem de fundo

Cobra cobra;

void setup() {
  fullScreen();
  cobra = new Cobra();
  comer = new PVector();
  newComer();
  frameRate(30); // Definindo a taxa de quadros
  imagemFundo = loadImage("wall.png"); // Carrega a imagem de fundo

  somComida = new SoundFile(this, "comida.mp3"); // Inicializa o objeto SoundFile para comida
  gameOverSound = new SoundFile(this, "gameover.mp3"); // Inicializa o objeto SoundFile para game over
  imagemFundo.resize(width, height);
}

void draw() {
  if (!morte) {
    background(imagemFundo); // Desenha a imagem de fundo somente se a cobrinha estiver viva
    if (frameCount % velocidade == 0) {
      cobra.update();
    }
    cobra.show();
    cobra.eat();
    fill(0, 0, 255); // Comida azul
    rect(comer.x, comer.y, grid, grid);
    textAlign(LEFT);
    textSize(15);
    fill(255);
    text("Pontuação: " + cobra.len, 10, 20);
  } else {
    background(0);
    textSize(25);
    textAlign(CENTER, CENTER);
    text("JOGO DA COBRINHA\nClique na tela para começar" + "\nRecorde: " + maiorPontuacao, width / 2, height / 2);
  }
}

void newComer() {
  comer.x = floor(random(width / grid)) * grid;
  comer.y = floor(random(height / grid)) * grid;
}

void mousePressed() {
  if (morte) {
    cobra = new Cobra();
    newComer();
    velocidade = 5; // Velocidade inicial
    morte = false;
  }
}
