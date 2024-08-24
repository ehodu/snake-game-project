import processing.sound.*; // Importa a biblioteca de som

SoundFile foodSound; // Declara o objeto SoundFile para a comida
SoundFile gameOverSound; // Declara o objeto SoundFile para o game over
int grid = 20; // Tamanho de cada quadrado da grade
PVector food;
int speed = 10; // Velocidade inicial (valor maior significa menor frequência de atualização)
boolean dead = true;
int highscore = 0;
PImage backgroundImage; // Declara o objeto PImage para a imagem de fundo

Snake snake;

void setup() {
  fullScreen();
  snake = new Snake();
  food = new PVector();
  newFood();
  frameRate(30); // Definindo a taxa de quadros
  backgroundImage = loadImage("wall.png"); // Carrega a imagem de fundo

  foodSound = new SoundFile(this, "food.mp3"); // Inicializa o objeto SoundFile para comida
  gameOverSound = new SoundFile(this, "gameover.mp3"); // Inicializa o objeto SoundFile para game over
  backgroundImage.resize(width, height);
}

void draw() {
  if (!dead) {
    background(backgroundImage); // Desenha a imagem de fundo somente se a cobrinha estiver viva
    if (frameCount % speed == 0) {
      snake.update();
    }
    snake.show();
    snake.eat();
    fill(0, 0, 255); // Comida azul
    rect(food.x, food.y, grid, grid);
    textAlign(LEFT);
    textSize(15);
    fill(255);
    text("Pontuação: " + snake.len, 10, 20);
  } else {
    background(0);
    textSize(25);
    textAlign(CENTER, CENTER);
    text("JOGO DA COBRINHA\nClique na tela para começar" + "\nRecorde: " + highscore, width / 2, height / 2);
  }
}

void newFood() {
  food.x = floor(random(width / grid)) * grid;
  food.y = floor(random(height / grid)) * grid;
}

void mousePressed() {
  if (dead) {
    snake = new Snake();
    newFood();
    speed = 5; // Velocidade inicial
    dead = false;
  }
}
