float startTime = 0;
// 1 == (1024, 768)
float scale = 1.7;
int s_w = int(603 * scale);
int s_h = int(400 * scale);
GameState state = GameState.RUNNING;
Ball ball = new Ball(100,700);

Platform main = new Platform(0, 355, 603,45);
Platform p1 = new Platform(0, 152, 176, 20);
Platform p2 = new Platform(400, 93, 146, 20);

BarEnemyObject e1 = new BarEnemyObject(107, 106, 54, 48);
BarMovimentEnemyObject em1 = new BarMovimentEnemyObject(200, 310, 50, 60, MovimentDirection.HORIZONTAL);

SpecialItem keey = new SpecialItem(8, 66, 61, 78, ItemType.KEY);
SpecialItem door = new SpecialItem(476, 14, 53, 78, ItemType.DOOR);

ArrayList<GameObject> gameObjects = new ArrayList<>();
ArrayList<Platform> platforms = new ArrayList<>();
ArrayList<BaseEnemyObject> enemies = new ArrayList<>();
ArrayList<SpecialItem> special_items = new ArrayList<>();

void setup() {
  size(s_w, s_h);
  startTime = millis();

  gameObjects.add(main);
  gameObjects.add(p1);
  gameObjects.add(p2);
  gameObjects.add(e1);
  gameObjects.add(em1);
  gameObjects.add(keey);
  gameObjects.add(door);

  platforms.add(main);
  platforms.add(p1);
  platforms.add(p2);
  
  enemies.add(e1);
  enemies.add(em1);
  
  special_items.add(keey);
  special_items.add(door);

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

//int scaleFrom(int s) {
  //return int(scale * s);
//}
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
