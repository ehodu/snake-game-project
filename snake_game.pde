import processing.sound.*; // Importa a biblioteca de som

SoundFile foodSound; // Declara o objeto SoundFile para a comida
SoundFile gameOverSound; // Declara o objeto SoundFile para o game over
float grid = 20; // Tamanho de cada quadrado da grade
ArrayList<PVector> foods; // Lista das posições das comidas
int speed = 10; // Velocidade inicial (valor maior significa menor frequência de atualização)
boolean dead = true;
int highscore = 0;
int minSpeed = 1;
PImage backgroundImage; // Declara o objeto PImage para a imagem de fundo
PImage foodImage;
PImage imgHead;
int numFoods = 5; // Número de comidas

Snake snake;

void setup() {
  fullScreen();
  snake = new Snake();
  frameRate(30); // Definindo a taxa de quadros
  backgroundImage = loadImage("wall.png"); // Carrega a imagem de fundo
  foods = new ArrayList<PVector>(); // Inicializa a lista de comidas
  newFood(); // Gera comidas iniciais
  foodSound = new SoundFile(this, "food.mp3"); // Inicializa o objeto SoundFile para comida
  gameOverSound = new SoundFile(this, "gameover.mp3"); // Inicializa o objeto SoundFile para game over
  backgroundImage.resize(width, height);
  foodImage = loadImage("maca.png");
  imgHead = loadImage("cobra.png");
}

void draw() {
  if (!dead) {
    background(backgroundImage); // Desenha a imagem de fundo somente se a cobrinha estiver viva
    if (frameCount % speed == 0) {
      snake.update();
    }
    snake.show();
    snake.eat();

    // Desenha todas as comidas
    fill(0, 0, 255); // Comida azul
    for (PVector food : foods) {
      image(foodImage, food.x, food.y, grid * 1.2, grid * 1.2);
    }

    // Exibe a pontuação
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
  foods.clear(); // Limpa a lista existente de comidas
  for (int i = 0; i < numFoods; i++) {
    PVector foodPos;
    boolean overlap;
    do {
      overlap = false;
      foodPos = new PVector(floor(random(width / grid)) * grid, floor(random(height / grid)) * grid);
      // Verifica se a comida não sobrepõe a cabeça ou o corpo da cobrinha
      if (foodPos.equals(snake.pos)) { // Certifique-se de que `snake.pos` é a posição da cabeça da cobrinha
        overlap = true;
      } else {
        for (PVector p : snake.hist) { // Certifique-se de que `snake.hist` é a lista de posições do corpo
          if (foodPos.equals(p)) {
            overlap = true;
            break;
          }
        }
      }
    } while (overlap); // Continue tentando até encontrar uma posição não sobreposta
    foods.add(foodPos); // Adiciona a comida à lista
  }
}

void mousePressed() {
  if (dead) {
    snake = new Snake();
    newFood();
    speed = 5; // Velocidade inicial
    dead = false;
  }
}
