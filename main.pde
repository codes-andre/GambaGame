float startTime = 0;
// 1.7 == (1024, 768)
float scale = 1;
GameState state = GameState.RUNNING;
Ball ball = new Ball(scaleFrom(100),scaleFrom(290), scaleFrom(50));

Platform main = new Platform(0, scaleFrom(355), scaleFrom(603),scaleFrom(45));
Platform p1 = new Platform(0, scaleFrom(152), scaleFrom(176), scaleFrom(20));
Platform p2 = new Platform(scaleFrom(400), scaleFrom(93), scaleFrom(146), scaleFrom(20));

BarEnemyObject e1 = new BarEnemyObject(scaleFrom(107), scaleFrom(106), scaleFrom(54), scaleFrom(48));
BarMovimentEnemyObject em1 = new BarMovimentEnemyObject(scaleFrom(200), scaleFrom(310), scaleFrom(50), scaleFrom(60), MovimentDirection.HORIZONTAL);

SpecialItem keey = new SpecialItem(scaleFrom(8), scaleFrom(66), scaleFrom(61), scaleFrom(78), ItemType.KEY);
SpecialItem door = new SpecialItem(scaleFrom(476), scaleFrom(14), scaleFrom(53), scaleFrom(78), ItemType.DOOR);

ArrayList<Image> images = new ArrayList<>();

ArrayList<GameObject> gameObjects = new ArrayList<>();
ArrayList<Platform> platforms = new ArrayList<>();
ArrayList<BaseEnemyObject> enemies = new ArrayList<>();
ArrayList<SpecialItem> special_items = new ArrayList<>();

void settings() {
  size(scaleFrom(603), scaleFrom(400));
}

void setup() {
  startTime = millis();
  //img = loadImage("key.png");
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
  
  //for(GameObject go: gameObjects) {
  //  Image img = go.getImage();
  //  images.add(img);
  //}
}

void draw() {
  if (state == GameState.FINISH) { return; }
  
  float elapsedTime = ((millis() - startTime) / 1000.0f);
  startTime = millis();

  background(99,200,236);
  
  for(Image img: images) {
    image(img.image, img.x, img.y);
    img.image.resize(scaleFrom(img.w), scaleFrom(img.h));
  }
  
  updateEnemies();
  update(elapsedTime);
  render();
}

void update(float elapsedTime) {
  
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
  
  images = new ArrayList<>();
  for(GameObject go: gameObjects) {
    Image img = go.getImage();
    images.add(img);
  }
}

void render() {
  for(GameObject go: gameObjects) {
    go.render();
  }
}

int scaleFrom(int s) {
  return int(scale * s);
}

int scaleFrom(float s) {
  return int(scale * s);
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
