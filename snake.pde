import processing.sound.*; // Importa a biblioteca de som

SoundFile foodSound; // Declara o objeto SoundFile para a comida
SoundFile gameOverSound; // Declara o objeto SoundFile para o game over

int grid = 20; // Tamanho de cada quadrado da grade
PVector food;
int speed = 40; // Velocidade inicial (valor maior significa menor frequência de atualização)
int minSpeed = 3; // Define a velocidade mínima para evitar que o jogo feche por velocidade muito alta
boolean dead = true;
int highscore = 0;
PImage backgroundImage; // Declara o objeto PImage para a imagem de fundo

Snake snake;

void setup() {
  fullScreen();// Define tela cheia
  snake = new Snake();
  food = new PVector();
  newFood(); // Gera a primeira comida
  frameRate(30); // Define a taxa de quadros
  backgroundImage = loadImage("wall.png"); // Carrega a imagem de fundo

  foodSound = new SoundFile(this, "food.mp3"); // Inicializa o objeto SoundFile para comida
  gameOverSound = new SoundFile(this, "gameover.mp3"); // Inicializa o objeto SoundFile para game over
  
  backgroundImage.resize(width, height); // Redimensiona a imagem de fundo para cobrir toda a tela
}

void draw() {
  if (!dead) { // Verifica se o jogo está em andamento
    background(backgroundImage); // Desenha a imagem de fundo
    if (frameCount % speed == 0) {
      snake.update(); // Atualiza a posição da cobrinha
    }
    snake.show(); // Mostra a cobrinha na tela
    snake.eat(); // Verifica se a cobrinha comeu a comida
    fill(0, 0, 255); // Define a cor da comida (azul)
    rect(food.x, food.y, grid, grid); // Desenha a comida
    textAlign(LEFT);
    textSize(15);
    fill(255);
    text("Pontuação: " + snake.len, 10, 20); // Mostra a pontuação atual
  } else { // Se a cobrinha estiver morta
    background(0); // Fundo preto
    textSize(25);
    textAlign(CENTER, CENTER);
    text("JOGO DA COBRINHA\nClique na tela para começar" + "\nRecorde: " + highscore, width / 2, height / 2); // Mostra a mensagem de game over e o recorde
  }
}

void newFood() {
  food.x = floor(random(width / grid)) * grid; // Gera nova posição da comida no eixo x
  food.y = floor(random(height / grid)) * grid; // Gera nova posição da comida no eixo y
}

void mousePressed() {
  if (dead) { // Se o jogo estiver parado (cobrinha morta)
    snake = new Snake(); // Reinicia a cobrinha
    newFood(); // Gera nova comida
    speed = 3; // Velocidade inicial
    dead = false; // Reinicia o jogo
  }
}
