float startTime = 0;
// 1.7 == (1024, 768)
float scale = 1;
GameState state = GameState.START;

Ball ball = new Ball(scaleFrom(100),scaleFrom(290), scaleFrom(25));

Platform main = new Platform(0, scaleFrom(453), scaleFrom(600),scaleFrom(45));
Platform p1 = new Platform(1, scaleFrom(200), scaleFrom(176), scaleFrom(20));
Platform p2 = new Platform(scaleFrom(430), scaleFrom(93), scaleFrom(146), scaleFrom(20));
PlatMove p3 = new PlatMove(scaleFrom(245), scaleFrom(20), scaleFrom(146), scaleFrom(20), MovimentDirection.VERTICAL);
Platform p4 = new Platform(50, scaleFrom(200), scaleFrom(150), scaleFrom(20));

BarEnemyObject e1 = new BarEnemyObject(scaleFrom(130), scaleFrom(160), scaleFrom(54), scaleFrom(48));
BarMovimentEnemyObject em1 = new BarMovimentEnemyObject(scaleFrom(400), scaleFrom(415), scaleFrom(50), scaleFrom(50), MovimentDirection.HORIZONTAL);

SpecialItem keey = new SpecialItem(scaleFrom(30), scaleFrom(66), scaleFrom(61), scaleFrom(78), ItemType.KEY);
SpecialItem door = new SpecialItem(scaleFrom(480), scaleFrom(22), scaleFrom(53), scaleFrom(78), ItemType.DOOR);

ArrayList<Image> images = new ArrayList<>();

ArrayList<GameObject> gameObjects = new ArrayList<>();
ArrayList<Platform> platforms = new ArrayList<>();
ArrayList<PlatMove> platmoves = new ArrayList<>();
ArrayList<BaseEnemyObject> enemies = new ArrayList<>();
ArrayList<SpecialItem> special_items = new ArrayList<>();

void settings() {
  size(scaleFrom(600), scaleFrom(500));
}

void setup() {
  startTime = millis();
  
  gameObjects.add(main);
  gameObjects.add(p1);
  gameObjects.add(p2);
  gameObjects.add(p3);
  gameObjects.add(p4);
  gameObjects.add(e1);
  gameObjects.add(em1);
  gameObjects.add(keey);
  gameObjects.add(door);

  platforms.add(main);
  platforms.add(p2);
  platforms.add(p1);
  platforms.add(p4);
  
  platmoves.add(p3);
  
  enemies.add(e1);
  enemies.add(em1);
  
  special_items.add(keey);
  special_items.add(door);

  gameObjects.add(ball);
}

void draw() {  
  textSize(36);
  
  if (state != GameState.RUNNING) { 
    render();
    return; 
  }

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
  
  for(PlatMove platmove: platmoves) {
    if (ball.collided(platmove)) { break; }
  }

  for(Platform plat: platforms) {
    if (ball.collided(plat)) { break; }
  }

  for(BaseEnemyObject enemy: enemies) {
    if (ball.collided(enemy)) {
      state = GameState.LOSE;
    }
  }
  
  for(SpecialItem item: special_items) {
    if (ball.collided(item)) {
      
      if (item.type == ItemType.DOOR) {
        if (ball.hasKey()) {
          state = GameState.WIN;
        }
      } else {
        gameObjects.remove(item);
      }
    }
  }
  
  images = new ArrayList<>();
  for(GameObject go: gameObjects) {
    Image img = go.getImage();
    images.add(img);
  }
}

void render() {
  
  switch (state) {
    case RUNNING:
      for(GameObject go: gameObjects) {
        go.render();
      }
    break;
    
    case WIN: 
      clear();
      background(0,256,0);
      text("YOU WIN :D", width / 2 - 100, height / 2);
    break;
    
    case LOSE: 
      clear();
      background(256,0,0);
      text("YOU LOSE :(", width / 2 - 100, height / 2);
    break;
    
    case START: 
      clear();
      text("PRESS ENTER TO PLAY \\o/", width / 2 - 190, height / 2);
    break;
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
  if (keyCode == 10 && state == GameState.START) {
    startTime = millis();
    state = GameState.RUNNING;
  } else {
    ball.keyPressed();
  }
}
