// teste
int grid = 20; // Tamanho de cada quadrado da grade
PVector food;
int speed = 10; // Velocidade inicial (valor maior significa menor frequência de atualização)
boolean dead = true;
int highscore = 0;
Snake snake;

void setup() {
 size(300,400);
  snake = new Snake();
  food = new PVector();
  newFood();
  frameRate(30); // Definindo a taxa de quadros
}

void draw() {
  background(0);
  fill(255);
  if (!dead) {
    if (frameCount % speed == 0) {
      snake.update();
    }
    snake.show();
    snake.eat();
    fill(255, 0, 0);
    rect(food.x, food.y, grid, grid);
    textAlign(LEFT);
    textSize(15);
    fill(255);
    text("Pontuação: " + snake.len, 10, 20);
  } else {
    
    textSize(25);
    textAlign(CENTER, CENTER);
    text("JOGO DA COBRINHA\nClique na tela para começar" + "\nRecorde: " + highscore, width / 2, height / 2);
  }
}

void newFood() {
  food.x = floor(random(width));
  food.y = floor(random(height));
  food.x = floor(food.x / grid) * grid;
  food.y = floor(food.y / grid) * grid;
}

void mousePressed() {
  if (dead) {
    snake = new Snake();
    newFood();
    speed = 5; // Velocidade inicial
    dead = false;
  }
}
