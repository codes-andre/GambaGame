float startTime = 0;

GameState state = GameState.RUNNING;
Ball ball = new Ball(100,700);
Platform main = new Platform(0, 748, 900,60);
Platform p1 = new Platform(600, 550, 300, 20);
Platform p2 = new Platform(200, 550, 300, 20);
BarEnemyObject e1 = new BarEnemyObject(300, 470, 30, 80);
BarMovimentEnemyObject em1 = new BarMovimentEnemyObject(700, 470, 30, 80, MovimentDirection.HORIZONTAL);

ArrayList<GameObject> gameObjects = new ArrayList<>();
ArrayList<Platform> platforms = new ArrayList<>();
ArrayList<BaseEnemyObject> enemies = new ArrayList<>();

void setup() {
  size(1024, 768);
  startTime = millis();

  gameObjects.add(main);
  gameObjects.add(p1);
  gameObjects.add(p2);
  gameObjects.add(e1);
  gameObjects.add(em1);

  platforms.add(main);
  platforms.add(p1);
  platforms.add(p2);
  
  enemies.add(e1);
  enemies.add(em1);

  gameObjects.add(ball);
}

void draw() {
  float elapsedTime = ((millis() - startTime) / 1000.0f);
  startTime = millis();

  clear();
  updateEnemies();
  update(elapsedTime);
  render();
}

void update(float elapsedTime) {
  if (state == GameState.FINISH) { return; }
  
  for(GameObject go: gameObjects) {
    go.update(elapsedTime);
  }

  for(Platform plat: platforms) {
    if (ball.collided(plat)) { break; }
  }

  for(BaseEnemyObject enemy: enemies) {
    if (ball.collided(enemy)) {
      state = GameState.FINISH;
    }
  }
}

void render() {
  for(GameObject go: gameObjects) {
    go.render();
  }
}

void updateEnemies() {
  ArrayList<BaseEnemyObject> toRemove = new ArrayList<>();
  ArrayList<BaseEnemyObject> toInsert = new ArrayList<>();
  
  for(BaseEnemyObject enemy: enemies) {
    ArrayList<BaseEnemyObject> children = enemy.getChildren();
    
    for(BaseEnemyObject child: children) {
      if (child.isAlive) {
        if (!enemies.contains(child)) {
          toInsert.add(child);
        }
      } else {
        toRemove.add(child);
      }
    }
  }
  
  for(BaseEnemyObject enemy: toRemove) {
    enemies.remove(enemy);
    gameObjects.remove(enemy);
  }
 
   for(BaseEnemyObject enemy: toInsert) {
    enemies.add(enemy);
    gameObjects.add(enemy);
  }
}

void mousePressed() {
  ball.mousePressed();
}

void keyPressed() {
  ball.keyPressed();
}
