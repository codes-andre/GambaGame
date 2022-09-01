float startTime = 0;

Ball ball = new Ball(100,700);
Platform main = new Platform(0, 748, 900,60);
Platform p1 = new Platform(600, 550, 300, 20);
Platform p2 = new Platform(200, 550, 300, 20);

ArrayList<GameObject> gameObjects = new ArrayList<>();
ArrayList<Platform> platforms = new ArrayList<>();

void setup() {
  size(1024, 768);
  startTime = millis();

  gameObjects.add(main);
  gameObjects.add(ball);
  gameObjects.add(p1);
  gameObjects.add(p2);

  platforms.add(main);
  platforms.add(p1);
  platforms.add(p2);
}

void draw() {
  float elapsedTime = ((millis() - startTime) / 1000.0f);
  startTime = millis();

  clear();
  update(elapsedTime);
  render();
}

void update(float elapsedTime) {
  for(GameObject go: gameObjects) {
    go.update(elapsedTime);
  }

  for(Platform go: platforms) {
    if (ball.collided(go)) { break; }
  }
}

void render() {
  for(GameObject go: gameObjects) {
    go.render();
  }
}

void mousePressed() {
  ball.mousePressed();
}

void keyPressed() {
  ball.keyPressed();
}
